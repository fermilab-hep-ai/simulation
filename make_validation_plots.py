#!/usr/bin/env python3
"""
Quick Delphes validation – now with L1T overlays and extra physics checks.

Usage
-----
    python make_validation_plots.py  /path/to/PROC-NEV-SEED/parent  [--outdir OUT]

The top directory must contain folders named
        PROCESS-NUMEVENTS-RANDSEED
each holding an *event.root* produced by your pipeline.
"""

import argparse, os, re, sys
from pathlib import Path
import ROOT
ROOT.gROOT.SetBatch(True)                 # no GUI

# --------------------------------------------------------------------------- #
# helper utilities
# --------------------------------------------------------------------------- #
def branch_exists(tree, branch):
    "True if *branch* (or its prefix before a dot) exists in the tree."
    return bool(tree.GetBranch(branch.split('.')[0]))

def ensure_dir(p):
    Path(p).mkdir(parents=True, exist_ok=True)

def draw(tree, expr, cut, bins, name, color):
    tree.Draw(f"{expr}>>{name}{bins}", cut, "goff")
    h = ROOT.gDirectory.Get(name)
    h.SetLineColor(color);   h.SetLineWidth(2);   h.SetFillStyle(0)
    return h

def first_branch(tree, candidates):
    "Return first branch present in *candidates*, or None."
    for br in candidates:
        if branch_exists(tree, br):
            return br
    return None

# ---- shorthand builders for L1-mirrored branches -------------------------- #
jet  = lambda tag, fld: f"{('L1TJet'   if tag else 'Jet')}.{fld}"
lep  = lambda tag, flav, fld: f"{('L1T' if tag else '')}{flav}.{fld}"
met  = lambda tag, fld='MET': f"{('L1T' if tag else '')}MissingET.{fld}"

COL  = {'': ROOT.kBlue+2,           # offline
        'L1T': ROOT.kGreen+2}       # L1T
# --------------------------------------------------------------------------- #
# plot routine for a single event.root
# --------------------------------------------------------------------------- #
def make_plots(rootfile, out_dir):

    f = ROOT.TFile.Open(str(rootfile))
    t = f.Get("Delphes")
    if not t:
        print(f"  !! no 'Delphes' tree in {rootfile}")
        return

    ensure_dir(out_dir)
    c      = ROOT.TCanvas("c","c",800,600)
    h_keep = []                                   # keep refs till we write

    # palette
    OFF, L1, GEN, PUP = ROOT.kBlue+2, ROOT.kGreen+2, ROOT.kBlack, ROOT.kRed+1

    # ------------------------------------------------------------------- #
    # 1) Jet multiplicity  (PF, L1T, Gen, PUPPI, L1T-PUPPI)
    # ------------------------------------------------------------------- #
    stack = ROOT.THStack("hsJetMult", ";# jets / event;Events")
    for br, label, col in [
        ("Jet_size",            "PF jets",            OFF),
        ("JetPUPPI_size",       "PUPPI jets",         PUP),
        ("L1TJet_size",         "L1T jets",           L1),
        ("L1TJetPUPPI_size",    "L1T-PUPPI jets",     ROOT.kMagenta+2),
        ("GenJet_size",         "Gen jets",           GEN),
    ]:
        if not branch_exists(t, br):  continue
        h = draw(t, br, "", "(20,0,40)", f"h{br}", col)
        stack.Add(h)
    stack.Draw("nostack hist")
    c.BuildLegend(0.55,0.60,0.88,0.88,"").SetBorderSize(0)
    c.SaveAs(f"{out_dir}/01_JetMultiplicity.png")
    h_keep.extend(stack.GetHists())

    # ------------------------------------------------------------------- #
    # 2) Leading & sub-leading jet pT (PF & L1T)
    # ------------------------------------------------------------------- #
    c.Clear()
    stack = ROOT.THStack("hsLeadJet",";jet p_{T}  [GeV];Events")
    xmax  = max([t.GetMaximum(b) for b in
                 ["Jet.PT[0]","Jet.PT[1]","L1TJet.PT[0]","L1TJet.PT[1]"]
                 if branch_exists(t,b)]+[0]) or 50
    xmax  = max(250, int(1.1*xmax))
    bins  = f"(60,0,{xmax})"

    for expr, name, col in [
        ("Jet.PT[0]"   ,"LeadPF",  OFF),
        ("L1TJet.PT[0]","LeadL1",  L1),
        ("Jet.PT[1]"   ,"SubPF",   ROOT.kAzure+2),
        ("L1TJet.PT[1]","SubL1",   ROOT.kGreen+3),
    ]:
        if not branch_exists(t, expr.split('[')[0]): continue
        stack.Add(draw(t, expr,"", bins, f"h{name}", col))
    stack.Draw("nostack hist")
    c.BuildLegend(0.55,0.62,0.88,0.88,"").SetBorderSize(0)
    c.SaveAs(f"{out_dir}/02_LeadSubleadJetPT.png")
    h_keep.extend(stack.GetHists())

    # ------------------------------------------------------------------- #
    # 3) Scalar H_T  (offline vs L1T)
    # ------------------------------------------------------------------- #
    c.Clear()
    h_off = draw(t,"Sum$(Jet.PT*(abs(Jet.Eta)<2.4))","",
                 "(60,0,1500)","hHT_off",OFF)
    h_off.GetXaxis().SetTitle("H_{T} (|η|<2.4)  [GeV]")
    h_off.Draw("hist")
    h_keep.append(h_off)
    if branch_exists(t,"L1TJet.PT"):
        h_l1  = draw(t,"Sum$(L1TJet.PT*(abs(L1TJet.Eta)<2.4))","",
                     "(60,0,1500)","hHT_l1",L1);  h_l1.Draw("hist SAME")
        h_keep.append(h_l1)
    c.BuildLegend(0.60,0.70,0.88,0.88,"").SetBorderSize(0)
    c.SaveAs(f"{out_dir}/03_EventHT.png")

    # ------------------------------------------------------------------- #
    # 4) MET overlay  (Gen, PF, PUPPI, L1, L1-PUPPI)
    # ------------------------------------------------------------------- #
    c.Clear()
    met_br = [
        ("GenMissingET.MET",      "Gen",      GEN),
        ("MissingET.MET",         "PF",       OFF),
        ("PuppiMissingET.MET",    "PUPPI",    PUP),
        ("L1TMissingET.MET",      "L1T",      L1),
        ("L1TPuppiMissingET.MET", "L1T-PUPPI",ROOT.kMagenta+2),
    ]
    avail = [b for b in met_br if branch_exists(t,b[0])]
    if avail:
        xmax = max(t.GetMaximum(b[0]) for b in avail);  xmax = max(200,int(1.1*xmax))
        bins = f"(60,0,{xmax})"
        first=True
        for br,label,col in avail:
            h = draw(t, br,"", bins, f"hMET{label}", col)
            (h.Draw("hist") if first else h.Draw("hist SAME"));  first=False
            h_keep.append(h)
        c.BuildLegend(0.55,0.60,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/04_MET_Overlay.png")

    # ------------------------------------------------------------------- #
    # 5) MET response  (Reco & L1T)  GenMET>10 GeV
    # ------------------------------------------------------------------- #
    if branch_exists(t,"GenMissingET.MET"):
        c.Clear()
        sel = "GenMissingET.MET>10"
        h_r = draw(t,"MissingET.MET/GenMissingET.MET",sel,"(50,0,2)",
                   "hRespReco",OFF);  h_r.Draw("hist");  h_keep.append(h_r)
        if branch_exists(t,"L1TMissingET.MET"):
            h_l = draw(t,"L1TMissingET.MET/GenMissingET.MET",sel,"(50,0,2)",
                       "hRespL1" ,L1);  h_l.Draw("hist SAME");  h_keep.append(h_l)
        h_r.GetXaxis().SetTitle("Reco or L1 MET / Gen MET (Gen MET>10 GeV)")
        c.BuildLegend(0.58,0.72,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/05_MET_Response.png")

    # ------------------------------------------------------------------- #
    # 6) Vertex multiplicity (offline & L1T)
    # ------------------------------------------------------------------- #
    vtx_off = first_branch(t,["Vertex_size","PV_size","GenVertex_size"])
    vtx_l1  = first_branch(t,["L1TPV_size","L1TVertex_size","L1TrackerVertex_size"])
    if vtx_off or vtx_l1:
        c.Clear()
        vmax = max([t.GetMaximum(b) for b in (vtx_off,vtx_l1) if b]+[5])
        bins = f"({min(int(vmax),200)},0,{int(vmax)})"
        first=True
        if vtx_off:
            h = draw(t,vtx_off,"",bins,"hVtxOff",OFF); h.Draw("hist"); first=False; h_keep.append(h)
        if vtx_l1:
            h = draw(t,vtx_l1,"",bins,"hVtxL1",L1);  h.Draw("hist SAME"); h_keep.append(h)
        c.BuildLegend(0.60,0.70,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/06_VertexMultiplicity.png")

    # ------------------------------------------------------------------- #
    # 7) PUPPI weight  (offline & L1T)
    # ------------------------------------------------------------------- #
    pup_off = first_branch(t,["EFlowPuppi.PuppiW" ,"EFlow.PuppiW"])
    pup_l1  = first_branch(t,["L1TEFlowPuppi.PuppiW","L1TEFlow.PuppiW"])
    if pup_off:
        c.Clear(); c.SetLogy(True)
        h = draw(t,pup_off,"","(50,0,1)","hPupOff",OFF);  h.Draw("hist"); h_keep.append(h)
        if pup_l1:
            h2= draw(t,pup_l1,"","(50,0,1)","hPupL1",L1); h2.Draw("hist SAME"); h_keep.append(h2)
        h.GetXaxis().SetTitle("PUPPI weight")
        c.BuildLegend(0.60,0.72,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/07_PUPPIweights.png")
        c.SetLogy(False)

    # ------------------------------------------------------------------- #
    # 8) m(jj), ΔR(jj), m(jjj) – offline & L1T overlays
    # ------------------------------------------------------------------- #
    c.Clear()
    first=True
    for tag in ('','L1T'):
        sz = jet(tag,'size')
        if not (branch_exists(t,sz) and t.GetMaximum(sz)>=2): continue

        mjj = (f"sqrt(max(0.,2*{jet(tag,'PT[0]')}*{jet(tag,'PT[1]')}*"
               f"(cosh({jet(tag,'Eta[0]')}-{jet(tag,'Eta[1]')})-"
               f"cos({jet(tag,'Phi[0]')}-{jet(tag,'Phi[1]')}))))")
        h = draw(t,mjj,"","(60,0,5000)",f"hMjj_{tag}",COL[tag])
        h.Draw("hist"+" SAME"*(not first));  first=False;  h_keep.append(h)

        dphi = (f"abs({jet(tag,'Phi[0]')}-{jet(tag,'Phi[1]')})>TMath::Pi()?("
                f"2*TMath::Pi()-abs({jet(tag,'Phi[0]')}-{jet(tag,'Phi[1]')})):"
                f"abs({jet(tag,'Phi[0]')}-{jet(tag,'Phi[1]')})")
        dr   = f"sqrt(pow({jet(tag,'Eta[0]')}-{jet(tag,'Eta[1]')},2)+pow({dphi},2))"
        h = draw(t,dr,"","(60,0,6)",f"hDRjj_{tag}",COL[tag])
        h.Draw("hist SAME"); h_keep.append(h)

        if t.GetMaximum(sz)>=3:
            m3 = (f"TMath::Sqrt(max(0.,"
                  f"pow(({jet(tag,'E[0]')}+{jet(tag,'E[1]')}+{jet(tag,'E[2]')}),2)-"
                  f"pow(({jet(tag,'Px[0]')}+{jet(tag,'Px[1]')}+{jet(tag,'Px[2]')}),2)-"
                  f"pow(({jet(tag,'Py[0]')}+{jet(tag,'Py[1]')}+{jet(tag,'Py[2]')}),2)-"
                  f"pow(({jet(tag,'Pz[0]')}+{jet(tag,'Pz[1]')}+{jet(tag,'Pz[2]')}),2)))")
            h = draw(t,m3,"","(60,0,5000)",f"hMjjj_{tag}",COL[tag])
            h.Draw("hist SAME");  h_keep.append(h)
    if not first:
        c.BuildLegend(0.55,0.65,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/08_Jets_Mass_DR.png")

    # ------------------------------------------------------------------- #
    # 9) Jet mass, η, φ spectra  (offline & L1T)
    # ------------------------------------------------------------------- #
    for axis,rng,xt in [('Mass',"(60,0,400)","jet mass [GeV]"),
                        ('Eta' ,"(60,-5,5)" ,"jet #eta"),
                        ('Phi' ,"(64,-3.2,3.2)","jet #phi")]:
        c.Clear(); first=True
        for tag in ('','L1T'):
            br = jet(tag,axis)
            if not branch_exists(t,br): continue
            h = draw(t,br,"",rng,f"hJet{axis}_{tag}",COL[tag])
            h.GetXaxis().SetTitle(xt)
            h.Draw("hist"+" SAME"*(not first));  first=False; h_keep.append(h)
        if not first:
            c.BuildLegend(0.60,0.70,0.88,0.88,"").SetBorderSize(0)
            c.SaveAs(f"{out_dir}/09_Jet{axis}.png")

    # ------------------------------------------------------------------- #
    # 10) Dilepton invariant masses (e⁺e⁻ / μ⁺μ⁻, offline & L1T)
    # ------------------------------------------------------------------- #
    c.Clear(); first=True
    for tag in ('','L1T'):
        for flav,col0 in [("Electron",ROOT.kOrange+7),("Muon",ROOT.kViolet+1)]:
            sz = lep(tag,flav,'size')
            if not (branch_exists(t,sz) and t.GetMaximum(sz)>=2): continue
            col = col0 if not tag else col0-4
            mll = (f"sqrt(max(0.,2*{lep(tag,flav,'PT[0]')}*{lep(tag,flav,'PT[1]')}*"
                   f"(cosh({lep(tag,flav,'Eta[0]')}-{lep(tag,flav,'Eta[1]')})-"
                   f"cos({lep(tag,flav,'Phi[0]')}-{lep(tag,flav,'Phi[1]')}))))")
            h = draw(t,mll,"","(60,0,500)",f"hMll_{tag}_{flav}",col)
            h.GetXaxis().SetTitle(f"m_{{{flav[0].lower()}{flav[0].lower()}}}  [GeV]")
            h.Draw("hist"+" SAME"*(not first)); first=False; h_keep.append(h)
    if not first:
        c.BuildLegend(0.53,0.68,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/10_DileptonMasses.png")

    # ------------------------------------------------------------------- #
    # 11) Transverse mass  M_T(leading ℓ , MET)  (offline & L1T)
    # ------------------------------------------------------------------- #
    c.Clear(); first=True
    for tag in ('','L1T'):
        if not branch_exists(t,met(tag)): continue
        lead = first_branch(t,[lep(tag,'Electron','PT[0]'), lep(tag,'Muon','PT[0]')])
        if not lead: continue
        pt  = lead.replace("[0]","")
        phi = pt.replace(".PT",".Phi")
        mt  = f"sqrt(2*{pt}[0]*{met(tag)}*(1-cos({phi}[0]-{met(tag,'Phi')})))"
        h = draw(t,mt,"","(60,0,500)",f"hMT_{tag}",COL[tag])
        h.GetXaxis().SetTitle("M_{T}(ℓ₁ , MET)  [GeV]")
        h.Draw("hist"+" SAME"*(not first)); first=False; h_keep.append(h)
    if not first:
        c.BuildLegend(0.60,0.70,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/11_MT_lep_MET.png")

    # ------------------------------------------------------------------- #
    #  write all histograms
    # ------------------------------------------------------------------- #
    outf = ROOT.TFile.Open(f"{out_dir}/quick_validation.root","RECREATE")
    for h in h_keep: h.Write()
    outf.Close();  c.Close()
    print(f"   ✔  Plots → {out_dir}")

# --------------------------------------------------------------------------- #
# walk the top directory once, keep one seed per process
# --------------------------------------------------------------------------- #
def collect_event_roots(topdir):
    evt = {};  pat = re.compile(r"(?P<proc>.+)-\d+-\d+$")
    for dirpath,_,files in os.walk(topdir):
        if "event.root" not in files:  continue
        m = pat.match(Path(dirpath).name);  proc = m.group("proc") if m else None
        if proc and proc not in evt:   evt[proc] = Path(dirpath)/"event.root"
    return evt

# --------------------------------------------------------------------------- #
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo", help="Top folder with PROCESS-NEV-SEED sub-dirs")
    ap.add_argument("--outdir", default=None,
                    help="Output directory (default: <repo>/validation_plots)")
    args = ap.parse_args()

    repo = Path(args.repo).expanduser().resolve()
    if not repo.is_dir():
        sys.exit(f"Repository '{repo}' not found.")
    outdir = Path(args.outdir) if args.outdir else repo/"validation_plots"
    ensure_dir(outdir)

    todo = collect_event_roots(repo)
    if not todo:
        sys.exit("No event.root files found – check directory layout.")

    for proc, rootf in sorted(todo.items()):
        print(f"Processing {proc:>20}  ({rootf})")
        make_plots(rootf, outdir/f"{proc}_plots")

if __name__ == "__main__":
    main()