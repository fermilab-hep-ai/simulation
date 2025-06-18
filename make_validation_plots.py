#!/usr/bin/env python3
"""
Quick Delphes validation with L1 plots and PUPPI weights.

Usage
-----
    python validate_delphes.py /path/to/top/dir [--outdir OUT]

The top directory must contain
    PROCESS-NUMEVENTS-RANDSEED/event.root
folders as produced by your pipeline.
"""

import argparse, os, re, sys
from pathlib import Path
import ROOT

ROOT.gROOT.SetBatch(True)                 # no GUI


# --------------------------------------------------------------------------- #
# helpers
# --------------------------------------------------------------------------- #
def branch_exists(tree, branch):
    """Return True if *branch* (or its prefix before a dot) is in the TTree."""
    return bool(tree.GetBranch(branch.split('.')[0]))

def ensure_dir(p):
    """mkdir -p."""
    Path(p).mkdir(parents=True, exist_ok=True)

def draw(tree, expression, selection, bins, name, color):
    tree.Draw(f"{expression}>>{name}{bins}", selection, "goff")
    h = ROOT.gDirectory.Get(name)
    h.SetLineColor(color)
    h.SetLineWidth(2)
    h.SetFillStyle(0)
    return h

# helper – return first branch that exists
def first_branch(tree, candidates):
    for br in candidates:
        if branch_exists(tree, br):
            return br
    return None

# --------------------------------------------------------------------------- #
# make plots for a single event.root
# --------------------------------------------------------------------------- #
def make_plots(rootfile, out_dir):
    f = ROOT.TFile.Open(str(rootfile))
    t = f.Get("Delphes")
    if not t:
        print(f"  !! no 'Delphes' tree in {rootfile}")
        return
    ensure_dir(out_dir)
    c      = ROOT.TCanvas("c","c",800,600)
    h_keep = []                       # keep refs until we write the file

    # colours
    OFF, L1, GEN, PUP = ROOT.kBlue+2, ROOT.kGreen+2, ROOT.kBlack, ROOT.kRed+1

    # ------------------------------------------------------------------- #
    # 1) Jet multiplicity   (PF vs L1 vs Gen)
    # ------------------------------------------------------------------- #
    stack = ROOT.THStack("hsJetMult", ";# jets / event;Events")

    h_pf  = draw(t,"Jet_size",    "", "(20,0,40)", "hPFJetMult",  OFF); stack.Add(h_pf)
    if branch_exists(t,"L1TJet_size"):
        h_l1 = draw(t,"L1TJet_size","", "(20,0,40)", "hL1JetMult", L1); stack.Add(h_l1)
    if branch_exists(t,"GenJet_size"):
        h_ge = draw(t,"GenJet_size","", "(20,0,40)", "hGenJetMult",GEN); stack.Add(h_ge)

    stack.Draw("nostack hist")
    leg = c.BuildLegend(0.60,0.70,0.88,0.88,"")
    leg.SetBorderSize(0); leg.SetFillStyle(0)
    c.SaveAs(f"{out_dir}/01_JetMultiplicity.png")
    h_keep.extend(stack.GetHists())

    # ------------------------------------------------------------------- #
    # 1 b) Jet multiplicity  – PF, PUPPI, Gen, L1, L1-PUPPI  (auto-range)
    # ------------------------------------------------------------------- #
    jet_branches = [
        ("Jet_size",            "PF jets",            OFF),
        ("JetPUPPI_size",       "PUPPI jets",         ROOT.kRed+1),
        ("GenJet_size",         "Gen jets",           GEN),
        ("L1TJet_size",         "L1T jets",           L1),
        ("L1TJetPUPPI_size",    "L1T-PUPPI jets",     ROOT.kMagenta+2),
    ]

    # work out the global max jet count
    mjet = max([int(t.GetMaximum(br)) for br,_,_ in jet_branches if branch_exists(t,br)] + [1])
    bins = f"({min(mjet,50)},0,{mjet})"         # ≤50 bins keeps it readable

    stack = ROOT.THStack("hsJetMultPUPPI", ";# jets / event;Events")

    for br, label, colour in jet_branches:
        if not branch_exists(t, br):
            continue
        h = draw(t, br, "", bins, f"h{br}", colour)
        stack.Add(h)

    stack.Draw("nostack hist")
    leg = c.BuildLegend(0.55,0.60,0.88,0.88,"")
    for br, label, colour in jet_branches:
        if branch_exists(t, br):
            leg.AddEntry(f"h{br}", label, "l")
    leg.SetBorderSize(0); leg.SetFillStyle(0)

    c.SaveAs(f"{out_dir}/01b_JetMultiplicity_PUPPI.png")
    h_keep.extend(stack.GetHists())

    # ------------------------------------------------------------------- #
    # 2) Leading & sub-leading jet pT     (auto-range)
    # ------------------------------------------------------------------- #
    # helper: maximum of a branch if it exists, otherwise 0
    def max_if(tree, branch):
        return tree.GetMaximum(branch) if branch_exists(tree, branch) else 0.

    # collect maxima first
    pmax = max(
        max_if(t, "Jet.PT[0]"),
        max_if(t, "Jet.PT[1]"),
        max_if(t, "L1TJet.PT[0]"),
        max_if(t, "L1TJet.PT[1]"),
    )

    # protect against completely empty events
    pmax = 50 if pmax < 250 else pmax * 2     # +10 % buffer
    pmax = 150
    bins = f"(60,0,{int(pmax)})"

    stack = ROOT.THStack("hsLeadJet",
                        ";jet p_{T}  [GeV];Events")

    # colours / styles
    col = { "leadPF" : OFF,
            "leadL1" : L1,
            "subPF"  : ROOT.kAzure+2,
            "subL1"  : ROOT.kGreen+3 }

    # 1) leading PF
    h_leadPF = draw(t,"Jet.PT[0]","", bins, "hLeadPF", col["leadPF"])
    stack.Add(h_leadPF)

    # 2) leading L1
    if branch_exists(t,"L1TJet.PT"):
        h_leadL1 = draw(t,"L1TJet.PT[0]","", bins, "hLeadL1", col["leadL1"])
        stack.Add(h_leadL1)

    # 3) sub-leading PF
    if branch_exists(t,"Jet.PT[1]"):
        h_subPF  = draw(t,"Jet.PT[1]","", bins, "hSubPF",  col["subPF"])
        stack.Add(h_subPF)

    # 4) sub-leading L1
    if branch_exists(t,"L1TJet.PT[1]"):
        h_subL1  = draw(t,"L1TJet.PT[1]","", bins, "hSubL1", col["subL1"])
        stack.Add(h_subL1)

    # draw & decorate
    stack.Draw("nostack hist")
    leg = c.BuildLegend(0.55,0.62,0.88,0.88,"")
    leg.SetBorderSize(0); leg.SetFillStyle(0)
    c.SaveAs(f"{out_dir}/02_LeadSubleadJetPT.png")

    # keep hists for output ROOT
    h_keep.extend(stack.GetHists())

    # ------------------------------------------------------------------- #
    # 3) Event H_T   (offline vs L1)
    # ------------------------------------------------------------------- #
    h_pf = draw(t,"Sum$(Jet.PT*(abs(Jet.Eta)<2.4))","", "(60,0,1500)", "hHToff",OFF)
    h_pf.GetXaxis().SetTitle("H_{T} (|η|<2.4)  [GeV]")
    h_pf.Draw("hist")
    if branch_exists(t,"L1TJet.PT"):
        h_l1 = draw(t,"Sum$(L1TJet.PT*(abs(L1TJet.Eta)<2.4))","",
                    "(60,0,1500)", "hHTl1", L1); h_l1.Draw("hist SAME")
    c.BuildLegend(0.60,0.70,0.88,0.88,"").SetBorderSize(0)
    c.SaveAs(f"{out_dir}/03_EventHT.png")
    h_keep.extend([h_pf, h_l1] if branch_exists(t,"L1TJet.PT") else [h_pf])

    # ------------------------------------------------------------------- #
    # 4) MET overlay – Gen, PF, PUPPI, L1, L1-PUPPI  (auto-range)
    # ------------------------------------------------------------------- #
    met_branches = [
        ("GenMissingET.MET",        "Gen MET",           GEN),
        ("MissingET.MET",           "PF MET",            OFF),
        ("PuppiMissingET.MET",      "PUPPI MET",         ROOT.kRed+1),
        ("L1TMissingET.MET",        "L1T MET",           L1),
        ("L1TPuppiMissingET.MET",   "L1T-PUPPI MET",     ROOT.kMagenta+2),
    ]

    if branch_exists(t,"MissingET.MET"):          # need at least one to draw
        met_max = max([t.GetMaximum(br) for br,_,_ in met_branches if branch_exists(t,br)])
        met_max = 200 if met_max < 200 else met_max*1.10
        bins = f"(60,0,{int(met_max)})"

        first = True
        for br, label, colour in met_branches:
            if not branch_exists(t, br):
                continue
            h = draw(t, br, "", bins, f"h{label.replace(' ','')}", colour)
            if first:
                h.Draw("hist")
                first = False
            else:
                h.Draw("hist SAME")

        leg = c.BuildLegend(0.55,0.60,0.88,0.88,"")
        for br,label,_ in met_branches:
            if branch_exists(t, br):
                leg.AddEntry(f"h{label.replace(' ','')}", label, "l")
        leg.SetBorderSize(0); leg.SetFillStyle(0)

        c.SaveAs(f"{out_dir}/04_MET_Overlay.png")
        h_keep.extend([ROOT.gDirectory.Get(f"h{label.replace(' ','')}")
                   for br,label,_ in met_branches            # ← use br here
                   if branch_exists(t, br) and
                      ROOT.gDirectory.Get(f"h{label.replace(' ','')}")])

    # ------------------------------------------------------------------- #
    # 5) MET response (Reco and L1)
    # ------------------------------------------------------------------- #
    if branch_exists(t,"GenMissingET"):
        sel   = "GenMissingET.MET>10"
        h_resp = draw(t,"MissingET.MET/GenMissingET.MET", sel,
                      "(50,0,2)", "hRespReco", OFF)
        h_resp.GetXaxis().SetTitle("Reco MET / Gen MET (Gen MET>10 GeV)")
        h_resp.Draw("hist")
        if branch_exists(t,"L1TMissingET"):
            h_rL1 = draw(t,"L1TMissingET.MET/GenMissingET.MET", sel,
                         "(50,0,2)", "hRespL1", L1); h_rL1.Draw("hist SAME")
        c.BuildLegend(0.58,0.72,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/05_MET_Response.png")
        h_keep.append(h_resp)
        if branch_exists(t,"L1TMissingET"): h_keep.append(h_rL1)

    # ------------------------------------------------------------------- #
    # 6) Vertex multiplicity  – offline *and* L1 overlay, dynamic x-range
    # ------------------------------------------------------------------- #
    vtx_off = first_branch(t, [           # standard / phase-II offline collections
        "Vertex_size",                    # classic Delphes vertexer
        "PV_size",                        # phase-II PV module
        "GenVertex_size"                  # truth vertices
    ])

    vtx_l1  = first_branch(t, [           # typical L1 names
        "L1TPV_size",                     # Delphes phase-II L1T PV
        "L1Vertex_size",                  # alternative naming
        "L1TVertex_size",                 # …
        "L1TrackerVertex_size"
    ])

    if vtx_off or vtx_l1:
        # decide x-axis upper edge from whichever branch has the larger max
        vmax = 0
        if vtx_off: vmax = max(vmax, int(t.GetMaximum(vtx_off)))
        if vtx_l1:  vmax = max(vmax, int(t.GetMaximum(vtx_l1)))
        if vmax < 5: vmax = 5                    # protect against empty trees
        bins = f"({min(vmax,200)},0,{vmax})"     # ≤200 bins keeps things light

        stack = ROOT.THStack("hsVtx", ";vertex multiplicity;Events")

        if vtx_off:
            h_off = draw(t, vtx_off, "", bins, "hVtxOff", OFF)
            stack.Add(h_off)
        if vtx_l1:
            h_l1  = draw(t, vtx_l1,  "", bins, "hVtxL1",  L1)
            stack.Add(h_l1)

        stack.Draw("nostack hist")
        leg = c.BuildLegend(0.60,0.70,0.88,0.88,"")
        if vtx_off: leg.AddEntry(h_off, vtx_off.replace("_size",""), "l")
        if vtx_l1:  leg.AddEntry(h_l1,  vtx_l1.replace("_size",""),  "l")
        leg.SetBorderSize(0); leg.SetFillStyle(0)

        c.SaveAs(f"{out_dir}/06_VertexMultiplicity.png")
        if vtx_off: h_keep.append(h_off)
        if vtx_l1:  h_keep.append(h_l1)

    # ------------------------------------------------------------------- #
    # 7) PUPPI weight distributions (offline & L1)
    # ------------------------------------------------------------------- #
    puppi_off = first_branch(t, ["EFlowPuppi.PuppiW", "EFlow.PuppiW"])
    puppi_l1  = first_branch(t, ["L1TEFlowPuppi.PuppiW", "L1TEFlow.PuppiW"])

    if puppi_off:
        c.SetLogy(True)     
        h_wp = draw(t, puppi_off, "", "(50,0,1)", "hPuppiWoff", OFF)
        h_wp.GetXaxis().SetTitle("PUPPI weight")
        h_wp.Draw("hist")
        if puppi_l1:
            h_wl1 = draw(t, puppi_l1, "", "(50,0,1)", "hPuppiWl1", L1)
            h_wl1.Draw("hist SAME")
        c.BuildLegend(0.58,0.72,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/07_PUPPIweights.png")
        h_keep.append(h_wp)
        if puppi_l1: h_keep.append(h_wl1)

    # ------------------------------------------------------------------- #
    # write all kept hists
    # ------------------------------------------------------------------- #
    outf = ROOT.TFile.Open(f"{out_dir}/quick_validation.root","RECREATE")
    for h in h_keep: h.Write()
    outf.Close()
    c.Close()
    print(f"   ✔  Plots → {out_dir}")

# --------------------------------------------------------------------------- #
# walk the repository once, pick one seed per process
# --------------------------------------------------------------------------- #
def collect_event_roots(topdir):
    """Return dict {process : event.root path (first seed found)}."""
    evt_files = {}
    pat = re.compile(r"(?P<proc>.+)-\d+-\d+$")          # PROC-NEV-SEED
    for dirpath, _, filenames in os.walk(topdir):
        if "event.root" not in filenames:           # no root file here
            continue
        m = pat.match(Path(dirpath).name)
        if not m:                                   # directory not matching pattern
            continue
        proc = m.group("proc")
        if proc not in evt_files:                   # first seed wins
            evt_files[proc] = Path(dirpath) / "event.root"
    return evt_files

# --------------------------------------------------------------------------- #
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo",   help="Top directory with PROCESS-NEV-SEED folders")
    ap.add_argument("--outdir", default=None,
                    help="Where to dump plots (default: <repo>/validation_plots)")
    args = ap.parse_args()

    repo   = Path(args.repo).expanduser().resolve()
    if not repo.is_dir():
        sys.exit(f"Repository '{repo}' not found.")
    outdir = Path(args.outdir) if args.outdir else repo / "validation_plots"
    ensure_dir(outdir)

    todo = collect_event_roots(repo)
    if not todo:
        sys.exit("No event.root files found – check directory layout.")
    items = sorted(todo.items())
    items = list(reversed(items))
    #items = items[10::1]
    for proc, froot in items:
        print(f"\nProcessing {proc:>20}   ({froot})")
        
        make_plots(froot, outdir / f"{proc}_plots")

if __name__ == "__main__":
    main()
