#!/usr/bin/env python3
"""
Basic distributions for the signal test production, one page per signal.

    python3 make_review_plots.py --indir <eos test dir> --outdir <plots dir>

Reads the per-signal parquet files, writes

    <outdir>/<process>/overview.png     12-panel page of basic distributions
    <outdir>/_comparisons/*.png         overlays across related points
    <outdir>/summary.csv                one row of medians per signal
    <outdir>/index.html                 everything linked in one place

Two things about the file format that the plots are built around:

* ``L1T_PUPPIPart_*`` is truncated to the 1000 highest-pT candidates per event
  (``MAX_PF_PER_EVENT`` in process_root_parquet.py).  At PU 200 every event
  saturates that, so L1T candidate multiplicity is a constant 1000 and carries
  no information.  ``FullReco_PUPPIPart_*`` is not truncated, so the candidate
  multiplicity / softness panels use it.  Panel 1 draws both, which is what
  makes the truncation visible.
* ``ScalarHT`` is a scalar sum over candidates (~4.4 TeV at PU 200), not the
  jet-based HT the L1 menu cuts on.  HT30 is therefore recomputed here as the
  scalar sum of AK4 PUPPI jets above 30 GeV, which is comparable to the
  PuppiHT 450 seed.

Menu thresholds drawn as reference lines are the offline 95-100% plateau values
quoted in instructions.md; the online L1 cuts sit somewhat below them.
"""

import argparse
import glob
import os

import awkward as ak
import matplotlib
import numpy as np
import pyarrow.parquet as pq

matplotlib.use("agg")
import matplotlib.pyplot as plt  # noqa: E402

# Categorical slots 1-4 of the reference palette, validated for CVD separation
# against a white surface.  Assigned in fixed order, never cycled.
SERIES = ["#2a78d6", "#eb6834", "#1baf7a", "#eda100"]
THRESH = "#d03b3b"          # reference lines: a rule, not a series
GRID = "#d9d9d6"

COLUMNS = [
    "FullReco_PUPPIPart_PT", "FullReco_PUPPIPart_D0",
    "L1T_PUPPIPart_PT",
    "L1T_JetPuppiAK4_PT",
    "L1T_PUPPIMET_MET",
    "L1T_MuonTight_PT", "L1T_MuonTight_D0",
    "L1T_Electron_PT",
    "L1T_PhotonTight_PT", "L1T_PhotonTight_Eta", "L1T_PhotonTight_Phi",
]


def f32(x):
    """float16 columns cannot be reduced by awkward; widen them."""
    return ak.values_astype(x, np.float32)


def load(path, max_events=None):
    cols = [c for c in COLUMNS if c in pq.ParquetFile(path).schema_arrow.names]
    a = ak.from_arrow(pq.read_table(path, columns=cols))
    if max_events:
        a = a[:max_events]
    return a


def derive(a):
    """Everything the panels need, as flat numpy arrays."""
    d = {}
    cand_pt = f32(a["FullReco_PUPPIPart_PT"])
    d["n_cand_full"] = ak.to_numpy(ak.num(cand_pt))
    d["n_cand_l1t"] = ak.to_numpy(ak.num(a["L1T_PUPPIPart_PT"]))
    d["cand_pt"] = ak.to_numpy(ak.flatten(cand_pt))
    cand_d0 = np.abs(f32(a["FullReco_PUPPIPart_D0"]))
    d["cand_d0"] = ak.to_numpy(ak.flatten(cand_d0))
    # At PU 200 the ~5700 candidates in an event are overwhelmingly pileup, and
    # the inclusive |d0| median is a pileup quantity: it does not move at all
    # across a lifetime scan.  Requiring pT > 5 GeV enriches the hard scatter
    # and the displacement becomes visible (measured medians 0.016 / 0.092 /
    # 0.55 / 1.36 mm across the 4tau ctau = 0 / 1 / 10 / 100 mm scan).
    hard = cand_pt > 5.0
    d["cand_d0_hard"] = ak.to_numpy(ak.flatten(cand_d0[hard]))

    jet = f32(a["L1T_JetPuppiAK4_PT"])
    jet30 = jet[jet > 30.0]
    d["ht30"] = ak.to_numpy(ak.sum(jet30, axis=1))
    d["n_jet30"] = ak.to_numpy(ak.num(jet30))
    d["lead_jet_pt"] = ak.to_numpy(ak.fill_none(ak.max(jet, axis=1), 0.0))

    d["met"] = ak.to_numpy(ak.flatten(f32(a["L1T_PUPPIMET_MET"])))

    for name, col in (("mu", "L1T_MuonTight_PT"), ("ele", "L1T_Electron_PT"),
                      ("pho", "L1T_PhotonTight_PT")):
        pt = f32(a[col])
        d["n_" + name] = ak.to_numpy(ak.num(pt))
        d[name + "_pt"] = ak.to_numpy(ak.flatten(pt))
    d["mu_d0"] = np.abs(ak.to_numpy(ak.flatten(f32(a["L1T_MuonTight_D0"]))))
    return d


def photon_dr(a):
    """dR of the two hardest photons, for the h->aa->4gamma points."""
    eta, phi = f32(a["L1T_PhotonTight_Eta"]), f32(a["L1T_PhotonTight_Phi"])
    keep = ak.num(eta) >= 2
    eta, phi = eta[keep], phi[keep]
    if len(eta) == 0:
        return np.array([])
    deta = ak.to_numpy(eta[:, 0] - eta[:, 1])
    dphi = ak.to_numpy(phi[:, 0] - phi[:, 1])
    dphi = (dphi + np.pi) % (2 * np.pi) - np.pi
    return np.hypot(deta, dphi)


def hist(ax, data, bins, xlabel, title, logy=True, logx=False, thresh=None,
         thresh_label=None, series=None, labels=None):
    ax.set_axisbelow(True)
    ax.grid(True, color=GRID, lw=0.6, alpha=0.7)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    for s in ("left", "bottom"):
        ax.spines[s].set_color("#8a8a85")

    datasets = series if series is not None else [data]
    for i, dd in enumerate(datasets):
        if dd is None or len(dd) == 0:
            continue
        ax.hist(np.clip(dd, bins[0], bins[-1]), bins=bins, histtype="step",
                lw=1.8, color=SERIES[i % len(SERIES)],
                label=(labels[i] if labels else None))
    if thresh is not None:
        ax.axvline(thresh, color=THRESH, ls="--", lw=1.4)
        ax.text(thresh, ax.get_ylim()[1], " " + (thresh_label or str(thresh)),
                color=THRESH, fontsize=7, va="top", ha="left")
    if logy:
        ax.set_yscale("log")
    if logx:
        ax.set_xscale("log")
    ax.set_xlabel(xlabel, fontsize=8)
    ax.set_title(title, fontsize=9, loc="left")
    ax.tick_params(labelsize=7)
    if labels:
        ax.legend(fontsize=7, frameon=False)


def logbins(lo, hi, n=50):
    return np.logspace(np.log10(lo), np.log10(hi), n)


def overview(proc, d, a, outpath):
    fig, axes = plt.subplots(3, 4, figsize=(18, 10.5))
    fig.suptitle(proc, fontsize=13, x=0.01, ha="left", weight="bold")
    ax = axes.ravel()

    hist(ax[0], None, np.linspace(0, 9000, 60), "PUPPI candidates / event",
         "1. Candidate multiplicity", series=[d["n_cand_full"], d["n_cand_l1t"]],
         labels=["FullReco", "L1T (capped at 1000)"])
    hist(ax[1], d["cand_pt"], logbins(0.05, 200), "candidate $p_T$ [GeV]",
         "2. Candidate $p_T$ (FullReco)", logx=True)
    hist(ax[2], d["ht30"], np.linspace(0, 1200, 60), "$H_T$(jets>30) [GeV]",
         "3. $H_T$30", thresh=450, thresh_label="PuppiHT 450")
    hist(ax[3], d["lead_jet_pt"], np.linspace(0, 600, 60), "leading jet $p_T$ [GeV]",
         "4. Leading AK4 PUPPI jet", thresh=230, thresh_label="SingleJet 230")
    hist(ax[4], d["n_jet30"], np.arange(-0.5, 20.5), "N jets ($p_T>30$)",
         "5. Jet multiplicity")
    hist(ax[5], d["met"], np.linspace(0, 400, 60), "PUPPI $E_T^{miss}$ [GeV]",
         "6. PUPPI MET", thresh=200, thresh_label="PuppiMET 200")
    hist(ax[6], d["n_mu"], np.arange(-0.5, 20.5), "N muons", "7. Muon multiplicity")
    hist(ax[7], d["mu_pt"], logbins(0.5, 200), "muon $p_T$ [GeV]",
         "8. Muon $p_T$", logx=True, thresh=2, thresh_label="TkMu 2")
    hist(ax[8], d["n_ele"], np.arange(-0.5, 20.5), "N electrons",
         "9. Electron multiplicity")
    hist(ax[9], d["ele_pt"], logbins(0.5, 200), "electron $p_T$ [GeV]",
         "10. Electron $p_T$", logx=True, thresh=12, thresh_label="TkEle 12")
    hist(ax[10], d["pho_pt"], logbins(0.5, 200), "photon $p_T$ [GeV]",
         "11. Photon $p_T$", logx=True, thresh=12, thresh_label="TkIsoPho 12")
    hard_d0 = d["cand_d0_hard"]
    hist(ax[11], hard_d0[hard_d0 > 0], logbins(1e-4, 200),
         "candidate $|d_0|$ [mm]  ($p_T>5$ GeV)",
         "12. Displacement, hard candidates", logx=True)

    fig.tight_layout(rect=[0, 0, 1, 0.97])
    fig.savefig(outpath, dpi=95)
    plt.close(fig)


def summary_row(proc, n_ev, d, a):
    def med(x):
        return float(np.median(x)) if len(x) else float("nan")
    dr = photon_dr(a)
    return {
        "process": proc,
        "events": n_ev,
        "med_Ncand_fullreco": med(d["n_cand_full"]),
        "med_cand_pT": med(d["cand_pt"]),
        "med_HT30": med(d["ht30"]),
        "med_lead_jet_pT": med(d["lead_jet_pt"]),
        "med_Njet30": med(d["n_jet30"]),
        "frac_HT30_gt450": float((d["ht30"] > 450).mean()),
        "frac_leadjet_gt230": float((d["lead_jet_pt"] > 230).mean()),
        "med_MET": med(d["met"]),
        "frac_MET_gt200": float((d["met"] > 200).mean()),
        "mean_Nmu": float(d["n_mu"].mean()),
        "med_mu_pT": med(d["mu_pt"]),
        "mean_Nele": float(d["n_ele"].mean()),
        "med_ele_pT": med(d["ele_pt"]),
        "mean_Npho": float(d["n_pho"].mean()),
        "med_pho_pT": med(d["pho_pt"]),
        "med_pho_dR": med(dr),
        "med_cand_d0_mm": med(d["cand_d0"][d["cand_d0"] > 0]),
        "med_hard_d0_mm": med(d["cand_d0_hard"][d["cand_d0_hard"] > 0]),
        "med_mu_d0_mm": med(d["mu_d0"][d["mu_d0"] > 0]),
    }


COMPARISONS = [
    ("ctau_scan_HVdilep_mumu", "Displaced soft dimuons: muon $|d_0|$",
     ["HVdilep_Zp500_piD2_mumu", "HVdilep_Zp500_piD2_mumu_ctau1mm",
      "HVdilep_Zp500_piD2_mumu_ctau10mm", "HVdilep_Zp500_piD2_mumu_ctau100mm"],
     "mu_d0", logbins(1e-3, 500), "muon $|d_0|$ [mm]", True),
    ("ctau_scan_hToAA_4tau", "h->aa->4tau lifetime scan: candidate $|d_0|$ ($p_T>5$ GeV)",
     ["hToAA_4tau_ma10", "hToAA_4tau_ma10_ctau1mm",
      "hToAA_4tau_ma10_ctau10mm", "hToAA_4tau_ma10_ctau100mm"],
     "cand_d0_hard", logbins(1e-3, 500), "candidate $|d_0|$ [mm] ($p_T>5$ GeV)", True),
    ("ctau_scan_hToAA_4b", "h->aa->4b lifetime scan: candidate $|d_0|$ ($p_T>5$ GeV)",
     ["hToAA_4b_ma30", "hToAA_4b_ma30_ctau1mm",
      "hToAA_4b_ma30_ctau10mm", "hToAA_4b_ma30_ctau100mm"],
     "cand_d0_hard", logbins(1e-3, 500), "candidate $|d_0|$ [mm] ($p_T>5$ GeV)", True),
    ("flavour_pair_ee_vs_mumu", "Matched ee / mumu pair (Zp500, piD2)",
     ["HVdilep_Zp500_piD2_mumu", "HVdilep_Zp500_piD2_ee"],
     "n_lep_pair", np.arange(-0.5, 20.5), "N leptons (mu resp. e)", False),
    ("SUEPlike_lambda_scan", "Higgs-portal points: candidate multiplicity",
     ["SUEPlike_HV_mPhi125_mX2_Lam1", "SUEPlike_HV_mPhi125_mX2_Lam2",
      "SUEPlike_HV_mPhi400_mX2_Lam2", "SUEPlike_HV_mPhi400_mX2_Lam4"],
     "n_cand_full", np.linspace(4000, 9000, 60), "PUPPI candidates / event", False),
    ("RPV_jet_multiplicity", "RPV points: jet multiplicity ($p_T>30$ GeV)",
     ["RPV_squark120_cascade_LSP90", "RPV_squark150_cascade_LSP100",
      "RPV_squark300_cascade_LSP250", "RPV_squark600_cascade_LSP550"],
     "n_jet30", np.arange(-0.5, 20.5), "N jets ($p_T>30$)", False),
    ("RPV_ewkino_displacement", "RPV electroweakinos: candidate $|d_0|$",
     ["RPV_ewkino200_UDD", "RPV_ewkino300_UDD", "RPV_ewkino150_UDD_ctau10mm"],
     "cand_d0_hard", logbins(1e-3, 500), "candidate $|d_0|$ [mm] ($p_T>5$ GeV)", True),
    ("hToAA_4gamma_dR", "h->aa->4gamma: leading photon pair $\\Delta R$",
     ["hToAA_4gamma_ma1", "hToAA_4gamma_ma5", "hToAA_4gamma_ma10"],
     "pho_dr", np.linspace(0, 2.0, 60), "$\\Delta R(\\gamma_1,\\gamma_2)$", False),
]


def make_comparisons(store, outdir):
    os.makedirs(outdir, exist_ok=True)
    made = []
    for tag, title, procs, key, bins, xlabel, logx in COMPARISONS:
        series, labels = [], []
        for p in procs:
            if p not in store:
                continue
            d, a = store[p]
            if key == "pho_dr":
                v = photon_dr(a)
            elif key == "n_lep_pair":
                v = d["n_mu"] if p.endswith("mumu") else d["n_ele"]
            else:
                v = d[key]
                if key.endswith("d0"):
                    v = v[v > 0]
            series.append(v)
            labels.append(p.replace("HVdilep_", "").replace("hToAA_", "")
                          .replace("SUEPlike_HV_", ""))
        if not series:
            continue
        fig, ax = plt.subplots(figsize=(7.2, 4.4))
        hist(ax, None, bins, xlabel, title, logx=logx,
             series=series, labels=labels)
        fig.tight_layout()
        out = os.path.join(outdir, tag + ".png")
        fig.savefig(out, dpi=110)
        plt.close(fig)
        made.append((tag, title))
    return made


INDEX_CSS = """
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Helvetica,Arial,sans-serif;
margin:0;padding:2rem;background:#f9f9f7;color:#1a1a19;line-height:1.5}
h1{font-size:1.5rem;margin:0 0 .25rem}h2{font-size:1.05rem;margin:2rem 0 .5rem}
p.sub{color:#5a5a55;margin:0 0 1.5rem}
a{color:#2a78d6;text-decoration:none}a:hover{text-decoration:underline}
ul{columns:3;list-style:none;padding:0}li{margin:.2rem 0;break-inside:avoid}
table{border-collapse:collapse;font-size:.8rem;background:#fff;width:100%}
th,td{border:1px solid #e2e2df;padding:.3rem .5rem;text-align:right}
th{background:#f1f1ee;text-align:left}td:first-child,th:first-child{text-align:left}
img{max-width:100%;border:1px solid #e2e2df;background:#fff;margin:.5rem 0}
code{background:#f1f1ee;padding:.1rem .3rem;border-radius:3px;font-size:.85em}
.note{background:#fff;border-left:3px solid #eda100;padding:.75rem 1rem;margin:1rem 0}
"""


def write_index(outdir, procs, comparisons, rows):
    cols = ["process", "events", "med_Ncand_fullreco", "med_cand_pT", "med_HT30",
            "med_Njet30", "med_lead_jet_pT", "med_MET", "mean_Nmu", "med_mu_pT",
            "mean_Nele", "mean_Npho", "med_hard_d0_mm", "med_mu_d0_mm"]
    h = ["<style>%s</style>" % INDEX_CSS,
         "<h1>Signal test production &mdash; review plots</h1>",
         "<p class='sub'>5000 events per point, PU 200, full Delphes chain. "
         "One page of basic distributions per signal.</p>",
         "<div class='note'><b>Two format caveats these plots expose.</b> "
         "<code>L1T_PUPPIPart</code> is truncated to the 1000 hardest candidates "
         "per event, so its multiplicity saturates at PU 200 and panel 1 shows "
         "the FullReco collection alongside it. <code>ScalarHT</code> is a sum "
         "over candidates (~4.4 TeV), not the menu's jet HT, so HT30 is "
         "recomputed from AK4 PUPPI jets above 30 GeV.</div>"]

    h.append("<h2>Comparisons</h2>")
    for tag, title in comparisons:
        h.append("<h3 style='font-size:.95rem;margin:1rem 0 .25rem'>%s</h3>" % title)
        h.append("<img src='_comparisons/%s.png' alt='%s'>" % (tag, title))

    h.append("<h2>Summary</h2><table><tr>%s</tr>" %
             "".join("<th>%s</th>" % c for c in cols))
    for r in rows:
        cells = []
        for c in cols:
            v = r.get(c)
            cells.append("<td>%s</td>" % (v if isinstance(v, str)
                         else ("%d" % v if c in ("events",) else "%.3g" % v)))
        h.append("<tr>%s</tr>" % "".join(cells))
    h.append("</table>")

    h.append("<h2>Per-signal pages</h2><ul>")
    for p in procs:
        h.append("<li><a href='%s/overview.png'>%s</a></li>" % (p, p))
    h.append("</ul>")
    open(os.path.join(outdir, "index.html"), "w").write("\n".join(h))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--indir", default="/eos/cms/store/group/phys_b2g/CASE/collide_test")
    ap.add_argument("--outdir", required=True)
    ap.add_argument("--max-events", type=int, default=None)
    ap.add_argument("--only", default=None, help="comma-separated subset")
    args = ap.parse_args()

    only = set(args.only.split(",")) if args.only else None
    os.makedirs(args.outdir, exist_ok=True)

    procs, rows, store = [], [], {}
    for proc in sorted(os.listdir(args.indir)):
        d = os.path.join(args.indir, proc)
        if not os.path.isdir(d) or proc.startswith("_") or proc == "review_plots":
            continue
        if only and proc not in only:
            continue
        files = glob.glob(os.path.join(d, "*.parquet"))
        if not files:
            continue
        try:
            a = load(files[0], args.max_events)
            der = derive(a)
        except Exception as exc:  # noqa: BLE001
            print("  !! %s: %s" % (proc, exc))
            continue
        n_ev = len(der["n_cand_full"])
        os.makedirs(os.path.join(args.outdir, proc), exist_ok=True)
        overview(proc, der, a, os.path.join(args.outdir, proc, "overview.png"))
        rows.append(summary_row(proc, n_ev, der, a))
        store[proc] = (der, a)
        procs.append(proc)
        print("  %-42s %d events" % (proc, n_ev))

    comparisons = make_comparisons(store, os.path.join(args.outdir, "_comparisons"))

    if rows:
        keys = list(rows[0].keys())
        with open(os.path.join(args.outdir, "summary.csv"), "w") as fh:
            fh.write(",".join(keys) + "\n")
            for r in rows:
                fh.write(",".join(str(r[k]) for k in keys) + "\n")
    write_index(args.outdir, procs, comparisons, rows)
    print("\n%d signals -> %s" % (len(procs), args.outdir))


if __name__ == "__main__":
    main()
