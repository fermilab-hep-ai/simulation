#!/usr/bin/env python3
"""
Quick Delphes validation with L1 plots and PUPPI weights.

Usage
-----
    python validate_delphes.py /path/to/event.root   [--outdir OUT]
    python validate_delphes.py /path/to/top/dir      [--outdir OUT]

The top directory must contain
    PROCESS-NUMEVENTS-RANDSEED/event.root
folders as produced by your pipeline.
"""

import argparse, os, re, sys
from pathlib import Path
import ROOT

ROOT.gROOT.SetBatch(True)                 # no GUI
ROOT.gStyle.SetOptStat(0)                 # hide stats box
ROOT.gStyle.SetLabelFont(42, "XYZ")
ROOT.gStyle.SetTitleFont(42, "XYZ")
ROOT.gStyle.SetLabelSize(0.04, "XYZ")
ROOT.gStyle.SetTitleSize(0.045,"XYZ")
ROOT.gROOT.ForceStyle()
ROOT.gStyle.SetPadLeftMargin(0.12)
ROOT.gStyle.SetPadBottomMargin(0.12)

NICE_NAME = {
    "Jet.Mass[0]"      : "Leading jet mass",
    "L1TJet.Mass[0]"   : "Leading jet mass (L1)",
    # add more mappings here
}

# --------------------------------------------------------------------------- #
# helpers
# --------------------------------------------------------------------------- #
def pretty(expr):
    """Return a human‐readable title for a branch or formula."""
    return NICE_NAME.get(expr, expr)

def branch_exists(tree, branch):
    """Return True if *branch* (or its prefix before a dot) is in the TTree."""
    return bool(tree.GetBranch(branch.split('.')[0]))

def ensure_dir(p):
    """mkdir -p."""
    Path(p).mkdir(parents=True, exist_ok=True)


def draw(tree, expression, selection, bins, name, color, title=""):
    """Draw into a hidden hist, apply line style + optional title."""
    tree.Draw(f"{expression}>>{name}{bins}", selection, "goff")
    h = ROOT.gDirectory.Get(name)
    h.SetLineColor(color)
    h.SetLineWidth(2)
    h.SetFillStyle(0)
    if title:
        h.SetTitle(title)
    else: 
        h.SetTitle("")
    return h

def make_legend(x1, y1, x2, y2, entries):
    """
    Build a legend at normalized coords (x1,y1,x2,y2).
      entries: [(hist, label, option), ...]
    """
    leg = ROOT.TLegend(x1, y1, x2, y2)
    leg.SetBorderSize(0)
    leg.SetFillStyle(0)
    leg.SetTextFont(42)
    leg.SetTextSize(0.035)
    for h, lbl, opt in entries:
        if h:
            leg.AddEntry(h, lbl, opt)
    return leg

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
    ELE, MU = ROOT.kMagenta+1, ROOT.kOrange+1       

    # ------------------------------------------------------------------- #
    # 1) Jet multiplicity   (PF vs L1 vs Gen)
    # ------------------------------------------------------------------- #
    stack = ROOT.THStack("hsJetMult", ";# jets / event;Events")

    h_pf  = draw(t,"Jet_size",    "", "(20,0,40)", "PFJetMult",  OFF); stack.Add(h_pf)
    if branch_exists(t,"L1TJet_size"):
        h_l1 = draw(t,"L1TJet_size","", "(20,0,40)", "L1JetMult", L1); stack.Add(h_l1)
    if branch_exists(t,"GenJet_size"):
        h_ge = draw(t,"GenJet_size","", "(20,0,40)", "GenJetMult",GEN); stack.Add(h_ge)

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
    entries = []
    for br, label, _ in jet_branches:
        if branch_exists(t, br):
            hist = ROOT.gDirectory.Get(f"h{br}")   # histogram we just made
            entries.append((hist, label, "l"))

    leg = make_legend(0.55, 0.60, 0.88, 0.88, entries)
    leg.Draw()

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
    pmax = 100     # +10 % buffer
    #pmax = pmax + 50    # +50 GeV buffer
    #pmax = 150
    bins = f"(30,0,{int(pmax)})"

    stack = ROOT.THStack("hsLeadJet",
                        ";jet p_{T}  [GeV];Events")

    # colours / styles
    col = {
    "leadPF": ROOT.TColor.GetColor("#08519c"),  # deep blue
    "subPF":  ROOT.TColor.GetColor("#6baed6"),  # light blue
    "leadL1": ROOT.TColor.GetColor("#006d2c"),  # deep green
    "subL1":  ROOT.TColor.GetColor("#74c476"),  # light green
        }
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

    stack.Draw("nostack hist")
    # single clean legend (avoid double‐drawing)
    leg = make_legend(0.55, 0.62, 0.88, 0.88, [
        (h_leadPF, "Leading PF jet",   "l"),
        (h_leadL1 if 'h_leadL1' in locals() else None, "Leading L1 jet",   "l"),
        (h_subPF  if 'h_subPF'  in locals() else None, "Sub-leading PF jet","l"),
        (h_subL1  if 'h_subL1'  in locals() else None, "Sub-leading L1 jet","l"),
    ])
    leg.Draw()
    c.SaveAs(f"{out_dir}/02_LeadSubleadJetPT.png")

    # keep hists for output ROOT
    h_keep.extend(stack.GetHists())

    # ------------------------------------------------------------------- #
    # 3) Event H_T   (offline vs L1)
    # ------------------------------------------------------------------- #
    h_pf = draw(t,"Sum$(Jet.PT*(abs(Jet.Eta)<2.4))","", "(30,0,300)", "Offline HT",OFF)
    h_pf.GetXaxis().SetTitle("H_{T} (|η|<2.4)  [GeV]")
    h_pf.Draw("hist")
    if branch_exists(t,"L1TJet.PT"):
        h_l1 = draw(t,"Sum$(L1TJet.PT*(abs(L1TJet.Eta)<2.4))","",
                    "(30,0,300)", "L1T HT", L1); h_l1.Draw("hist SAME")
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
        met_max = 150
        bins = f"(30,0,{int(met_max)})"

        entries = []
        first = True
        for br, label, colour in met_branches:
            if not branch_exists(t, br):
                continue
            h = draw(t, br, "", bins, f"h{label.replace(' ','')}", colour)
            entries.append((h, label, "l"))
            if first:
                h.Draw("hist")
                first = False
            else:
                h.Draw("hist SAME")

        # single clean legend
        leg = make_legend(0.55, 0.60, 0.88, 0.88, entries)
        leg.Draw()
        

        c.SaveAs(f"{out_dir}/04_MET_Overlay.png")
        h_keep.extend([ROOT.gDirectory.Get(f"h{label.replace(' ','')}")
                   for br,label,_ in met_branches            # ← use br here
                   if branch_exists(t, br) and
                      ROOT.gDirectory.Get(f"h{label.replace(' ','')}")])

    # ------------------------------------------------------------------- #
    # 5) MET response (Reco and L1)
    # ------------------------------------------------------------------- #
    if branch_exists(t,"GenMissingET"):
        sel   = "GenMissingET.MET>50"
        h_resp = draw(t,"MissingET.MET/GenMissingET.MET", sel,
                      "(30,0,2)", "METRespOffline", OFF)
        h_resp.GetXaxis().SetTitle("Reco MET / Gen MET (Gen MET>50 GeV)")
        h_resp.Draw("hist")
        if branch_exists(t,"L1TMissingET"):
            h_rL1 = draw(t,"L1TMissingET.MET/GenMissingET.MET", sel,
                         "(30,0,2)", "METRespL1", L1); h_rL1.Draw("hist SAME")
        c.BuildLegend(0.58,0.72,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/05_MET_Response.png")
        h_keep.append(h_resp)
        if branch_exists(t,"L1TMissingET"): h_keep.append(h_rL1)

    # if branch_exists(t, "GenMissingET"):
    #     h_u_over_ugen = draw(
    #         t,
    #         "-MissingET.MET/GenMissingET.MET",   # simple magnitude ratio
    #         "GenMissingET.MET>10",
    #         "(50,-2,2)", "hRecoilRespReco", OFF
    #     )
    #     c.SaveAs(f"{out_dir}/05b_HADrecoil_Response.png")
    
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
        # if vmax < 5: vmax = 5                    # protect against empty trees
        # bins = f"({min(vmax,200)},0,{vmax})"     # ≤200 bins keeps things light

        if vmax < 5:
            vmax = 5                             # protect against empty trees
        vmax = vmax + 100

        # one-vertex-wide bins centered on the integers
        nbins = vmax + 1                         # covers 0 … vmax
        bins  = f"({nbins}, -0.5, {vmax + 0.5})"

        stack = ROOT.THStack("hsVtx", ";vertex multiplicity;Events")

        if vtx_off:
            h_off = draw(t, vtx_off, "", bins, "VtxMult Offline", OFF)
            stack.Add(h_off)
        if vtx_l1:
            h_l1  = draw(t, vtx_l1,  "", bins, "VtxMult L1T",  L1)
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
        h_wp = draw(t, puppi_off, "", "(50,0,1)", "PuppiW offline", OFF)
        h_wp.GetXaxis().SetTitle("PUPPI weight")
        h_wp.Draw("hist")
        if puppi_l1:
            h_wl1 = draw(t, puppi_l1, "", "(50,0,1)", "PuppiW L1T", L1)
            h_wl1.Draw("hist SAME")
        c.BuildLegend(0.58,0.72,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/07_PUPPIweights.png")
        h_keep.append(h_wp)
        if puppi_l1: h_keep.append(h_wl1)

    # ------------------------------------------------------------------- #
    # write all kept hists
    # ------------------------------------------------------------------- #
    # outf = ROOT.TFile.Open(f"{out_dir}/quick_validation.root","RECREATE")
    # for h in h_keep: h.Write()
    # outf.Close()
    # c.Close()
    # print(f"   ✔  Plots → {out_dir}")

    #
    #  NOTE:  new material is inserted **above** this comment,
    #  so the final ROOT file already contains the extra histograms.
    # ------------------------------------------------------------------- #

    # ------------------------------------------------------------------- #
    # 8) Jet multiplicity with pT > 30 GeV (PF, L1, Gen)
    # ------------------------------------------------------------------- #

    # helper: evaluate an expression’s maximum if its branches exist
    def max_of_expr(tree, expr):
        hist_name = "tmpMax30"
        tree.Draw(f"{expr}>>{hist_name}(1)", "", "goff")
        h_tmp = ROOT.gDirectory.Get(hist_name)
        return h_tmp.GetMaximum() if h_tmp else 0.

    vmax = 0
    vmax = max(vmax, max_of_expr(t, "Sum$(Jet.PT>30)"))
    if branch_exists(t, "L1TJet.PT"):
        vmax = max(vmax, max_of_expr(t, "Sum$(L1TJet.PT>30)"))
    if branch_exists(t, "GenJet.PT"):
        vmax = max(vmax, max_of_expr(t, "Sum$(GenJet.PT>30)"))

    # give plenty of room: +50 on top of whatever we actually found
    xmax  = 50
    nbins = xmax + 1                       # bin width = 1 jet
    bins  = f"({nbins}, -0.5, {xmax + 0.5})"

    stack = ROOT.THStack("hsJetMult30",
                        ";# jets (p_{T} > 30 GeV);Events")

    h_pf30  = draw(t, "Sum$(Jet.PT>30)",   "", bins, "PFJetMult>30",  OFF)
    stack.Add(h_pf30)
    if branch_exists(t, "L1TJet.PT"):
        h_l130 = draw(t, "Sum$(L1TJet.PT>30)", "", bins, "L1JetMult>30", L1)
        stack.Add(h_l130)
    if branch_exists(t, "GenJet.PT"):
        h_ge30 = draw(t, "Sum$(GenJet.PT>30)",  "", bins, "GenJetMult>30", GEN)
        stack.Add(h_ge30)

    stack.Draw("nostack hist")
    leg = make_legend(0.60, 0.70, 0.88, 0.88, [
        (h_pf30, "PF jets",  "l"),
        (h_l130 if 'h_l130' in locals() else None, "L1 jets", "l"),
        (h_ge30 if 'h_ge30' in locals() else None, "Gen jets","l"),
    ])
    leg.Draw()

    c.SaveAs(f"{out_dir}/01c_JetMultiplicity_pt30.png")
    h_keep.extend(stack.GetHists())

    # ------------------------------------------------------------------- #
    # 9)  Leading lepton pT  – electrons & muons (offline vs L1)
    # ------------------------------------------------------------------- #
    leptons = [("Electron", "leading e", ELE),
               ("Muon",     "leading #mu", MU)]
    def max_if(tree, br):                 # (defined earlier; reused here)
        return tree.GetMaximum(br) if branch_exists(tree, br) else 0.
    for typ, label, col in leptons:
        br_off = f"{typ}.PT[0]"
        br_l1  = f"L1T{typ}.PT[0]"
        if not (branch_exists(t,br_off) or branch_exists(t,br_l1)):
            continue
        pmax = max(max_if(t,br_off), max_if(t,br_l1))
        pmax = 50 if pmax < 50 else pmax*1.2
        bins = f"(50,0,{int(pmax)})"
        first = True
        if branch_exists(t,br_off):
            h=draw(t,br_off, "",bins,f"{typ}LeadOff",col); h.Draw("hist")
            first=False; h_keep.append(h)
        if branch_exists(t,br_l1):
            h=draw(t,br_l1, "",bins,f"{typ}LeadL1",col+2)
            h.Draw("hist SAME"); h_keep.append(h)
        if not first:
            lg=c.BuildLegend(0.55,0.72,0.88,0.88,"")
            lg.SetBorderSize(0); lg.SetFillStyle(0)
            if branch_exists(t,br_off):
                lg.AddEntry(f"",f"{label} (PF)","l")
            if branch_exists(t,br_l1):
                lg.AddEntry(f"",f"{label} (L1)","l")
            c.SaveAs(f"{out_dir}/08_{typ}_LeadingPT.png")

    # ------------------------------------------------------------------- #
    # 10) Dijet invariant mass (two leading jets)  – PF & L1
    # ------------------------------------------------------------------- #
    dijet_off  = ("sqrt(2*Jet.PT[0]*Jet.PT[1]*(cosh(Jet.Eta[0]-Jet.Eta[1])"
                  "-cos(Jet.Phi[0]-Jet.Phi[1])))")
    dijet_l1   = ("sqrt(2*L1TJet.PT[0]*L1TJet.PT[1]*(cosh(L1TJet.Eta[0]"
                  "-L1TJet.Eta[1])-cos(L1TJet.Phi[0]-L1TJet.Phi[1])))")
    if t.GetMaximum("Jet_size")>1 or (
       branch_exists(t,"L1TJet_size") and t.GetMaximum("L1TJet_size")>1):
        first=True
        if t.GetMaximum("Jet_size")>1:
            h=draw(t,dijet_off,"","(40,0,2000)","DijetOff",OFF)
            h.Draw("hist"); first=False; h_keep.append(h)
        if branch_exists(t,"L1TJet.PT") and t.GetMaximum("L1TJet_size")>1:
            h=draw(t,dijet_l1,"","(40,0,2000)","DijetL1",L1)
            h.Draw("hist SAME"); h_keep.append(h)
        if not first:
            c.BuildLegend(0.55,0.72,0.88,0.88,"").SetBorderSize(0)
            c.SaveAs(f"{out_dir}/09_DijetMass.png")

    # ------------------------------------------------------------------- #
    # 9 b) Dilepton invariant mass  (ee, μμ, eμ)
    # ------------------------------------------------------------------- #
    # expressions in Delphes branches (scalar √(2 p₁ p₂ (coshΔη − cosΔφ)))
    ee_expr = ("sqrt(2*Electron.PT[0]*Electron.PT[1]*"
               "(cosh(Electron.Eta[0]-Electron.Eta[1])"
               "-cos(Electron.Phi[0]-Electron.Phi[1])))")
    mm_expr = ("sqrt(2*Muon.PT[0]*Muon.PT[1]*"
               "(cosh(Muon.Eta[0]-Muon.Eta[1])"
               "-cos(Muon.Phi[0]-Muon.Phi[1])))")
    em_expr = ("sqrt(2*Electron.PT[0]*Muon.PT[0]*"
               "(cosh(Electron.Eta[0]-Muon.Eta[0])"
               "-cos(Electron.Phi[0]-Muon.Phi[0])))")

    # fixed, sensible mass window (change if you expect heavier resonances)
    bins = "(60,0,200)"          # 3 GeV bin width up to 200 GeV

    first    = True
    entries  = []
    # colours for the three curves
    COL_EE   = ELE
    COL_MM   = MU
    COL_EM   = ROOT.kAzure+4

    if t.GetMaximum("Electron_size") > 1:
        h_ee = draw(t, ee_expr, "", bins, "hMassEE", COL_EE,
                    "Invariant mass e^{+}e^{-}")
        h_ee.Draw("hist")
        entries.append((h_ee, "e^{+}e^{-}", "l"))
        first = False
        h_keep.append(h_ee)

    if t.GetMaximum("Muon_size") > 1:
        h_mm = draw(t, mm_expr, "", bins, "hMassMM", COL_MM,
                    "Invariant mass μ^{+}μ^{-}")
        h_mm.Draw("hist SAME" if not first else "hist")
        entries.append((h_mm, "μ^{+}μ^{-}", "l"))
        first = False
        h_keep.append(h_mm)

    if (t.GetMaximum("Electron_size") > 0 and
        t.GetMaximum("Muon_size")    > 0):
        h_em = draw(t, em_expr, "", bins, "hMassEM", COL_EM,
                    "Invariant mass eμ")
        h_em.Draw("hist SAME" if not first else "hist")
        entries.append((h_em, "eμ (e±μ∓)", "l"))
        h_keep.append(h_em)

    if entries:
        leg = make_legend(0.60, 0.70, 0.88, 0.88, entries)
        leg.Draw()
        c.SaveAs(f"{out_dir}/09b_DileptonMass.png")

    # ------------------------------------------------------------------- #
    # 11) Leading jet mass  – PF & L1
    # ------------------------------------------------------------------- #
    if branch_exists(t,"Jet.Mass"):
        h=draw(t,"Jet.Mass[0]","","(50,0,300)","JetMassOff",OFF)
        h.Draw("hist"); h_keep.append(h)
        if branch_exists(t,"L1TJet.Mass"):
            h2=draw(t,"L1TJet.Mass[0]","","(50,0,300)","JetMassL1",L1)
            h2.Draw("hist SAME"); h_keep.append(h2)
        c.BuildLegend(0.55,0.72,0.88,0.88,"").SetBorderSize(0)
        c.SaveAs(f"{out_dir}/10_LeadJetMass.png")

    # ------------------------------------------------------------------- #
    # 12) η / φ distributions (jets, muons, electrons -- leading object)
    # ------------------------------------------------------------------- #
    eta_phi_objs = [("Jet","jets",OFF),("Muon","muons",MU),
                    ("Electron","electrons",ELE)]
    for typ,lab,col in eta_phi_objs:
        for var,axis,bnds in [("Eta","η",(50,-5,5)),
                              ("Phi","φ",(64,-3.2,3.2))]:
            br  = f"{typ}.{var}[0]"
            brL1= f"L1T{typ}.{var}[0]"
            if not (branch_exists(t,br) or branch_exists(t,brL1)):
                continue
            first=True
            if branch_exists(t,br):
                h=draw(t,br,"",f"({bnds[0]},{bnds[1]},{bnds[2]})",
                       f"{typ}{var}Off",col)
                h.Draw("hist"); first=False; h_keep.append(h)
            if branch_exists(t,brL1):
                h=draw(t,brL1,"",f"({bnds[0]},{bnds[1]},{bnds[2]})",
                       f"{typ}{var}L1",col+2)
                h.Draw("hist SAME"); h_keep.append(h)
            if not first:
                lg=c.BuildLegend(0.60,0.72,0.88,0.88,"")
                lg.SetBorderSize(0); lg.SetFillStyle(0)
                c.SaveAs(f"{out_dir}/11_{var}_{lab}.png")

    # ------------------------------------------------------------------- #
    # 13) ΔR between the two leading jets
    # ------------------------------------------------------------------- #
    if t.GetMaximum("Jet_size")>1 or (
       branch_exists(t,"L1TJet_size") and t.GetMaximum("L1TJet_size")>1):
        dr_off  = ("sqrt((Jet.Eta[0]-Jet.Eta[1])^2"
                   "+acos(cos(Jet.Phi[0]-Jet.Phi[1]))^2)")
        dr_l1   = ("sqrt((L1TJet.Eta[0]-L1TJet.Eta[1])^2"
                   "+acos(cos(L1TJet.Phi[0]-L1TJet.Phi[1]))^2)")
        first=True
        if t.GetMaximum("Jet_size")>1:
            h=draw(t,dr_off,"","(50,0,6)","DeltaRjetsOff",OFF)
            h.Draw("hist"); first=False; h_keep.append(h)
        if branch_exists(t,"L1TJet.PT") and t.GetMaximum("L1TJet_size")>1:
            h=draw(t,dr_l1,"","(50,0,6)","DeltaRjetsL1",L1)
            h.Draw("hist SAME"); h_keep.append(h)
        if not first:
            c.BuildLegend(0.55,0.72,0.88,0.88,"").SetBorderSize(0)
            c.SaveAs(f"{out_dir}/13_DeltaR_Jets.png")

    # ------------------------------------------------------------------- #
    # 14) Transverse mass  M_T(leading lepton, MET)
    # ------------------------------------------------------------------- #
    mt_leps   = [("Electron",ELE),("Muon",MU)]
    for typ,col in mt_leps:
        pt  = f"{typ}.PT[0]";    phi = f"{typ}.Phi[0]"
        mpt = "MissingET.MET";   mphi= "MissingET.Phi"
        ptL = f"L1T{typ}.PT[0]"; phiL= f"L1T{typ}.Phi[0]"
        mptL= "L1TMissingET.MET";mphiL="L1TMissingET.Phi"
        expr_off = (f"sqrt(2*{pt}*{mpt}"
                    f"*(1-cos(acos(cos({mphi}-{phi})))) )")
        expr_l1  = (f"sqrt(2*{ptL}*{mptL}"
                    f"*(1-cos(acos(cos({mphiL}-{phiL})))) )")
        first=True
        if branch_exists(t,pt) and branch_exists(t,mpt):
            h=draw(t,expr_off,"","(50,0,500)",f"M_T{typ}Off",col)
            h.Draw("hist"); first=False; h_keep.append(h)
        if branch_exists(t,ptL) and branch_exists(t,mptL):
            h=draw(t,expr_l1,"","(50,0,500)",f"M_T{typ}L1",col+2)
            h.Draw("hist SAME"); h_keep.append(h)
        if not first:
            c.BuildLegend(0.55,0.72,0.88,0.88,"").SetBorderSize(0)
            c.SaveAs(f"{out_dir}/14_MT_{typ}.png")

    # ------------------------------------------------------------------- #
    # 15) Finally, dump *all* histograms – old + new – into one ROOT file
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
    ap.add_argument("path", help="Either a single event.root file **or** a top directory")
    ap.add_argument("--outdir", default=None,
                    help="Where to dump plots (default: <repo>/validation_plots)")
    args = ap.parse_args()

    target = Path(args.path).expanduser().resolve()

    # ------------------------------------------------------------------ #
    # Case A – user passed a single ROOT file → validate just that file
    # ------------------------------------------------------------------ #
    if target.is_file() and target.suffix == ".root":
        rootfile = target
        # name the plots directory automatically unless --outdir given
        outdir = Path(args.outdir) if args.outdir else rootfile.parent / "validation_plots"
        ensure_dir(outdir)
        proc   = rootfile.parent.name            # e.g.  γj-10000-42  → γj-10000-42
        make_plots(rootfile, outdir / f"{proc}_plots")
        return

    # ------------------------------------------------------------------ #
    # Case B – user passed a directory → behave exactly as before
    # ------------------------------------------------------------------ #
    if not target.is_dir():
        sys.exit(f"'{target}' is neither a directory nor a *.root file.")

    repo = target
    outdir = Path(args.outdir) if args.outdir else repo / "validation_plots"
    ensure_dir(outdir)

    todo = collect_event_roots(repo)
    if not todo:
        sys.exit("No event.root files found – check directory layout.")
    items = sorted(todo.items())
    #items = list(reversed(items))
    #items = items[10::1]
    for proc, froot in items:
        print(f"\nProcessing {proc:>20}   ({froot})")
        
        make_plots(froot, outdir / f"{proc}_plots")

if __name__ == "__main__":
    main()
