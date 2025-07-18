#!/usr/bin/env python3
"""
Delphes validation adapted from Eric Moreno's make_validation_plots.py to work with Parquet files.

Usage
-----
    python make_validation_plots.py  /path/to/PROC-NEV-SEED/parent  [--outdir OUT]

The top directory must contain folders named
        PROCESS-NUMEVENTS-RANDSEED
each holding an *event.parquet* produced by your pipeline.
"""

import argparse, os, re, sys
from pathlib import Path
import pyarrow as pa
import pyarrow.parquet as pq
import awkward as ak
import numpy as np
import matplotlib.pyplot as plt

# --------------------------------------------------------------------------- #
# helper utilities
# --------------------------------------------------------------------------- #
def dataset_exists(table, dataset):
    """ Check if a dataset exists in the Parquet table."""
    return dataset in table.column_names

def ensure_dir(p):
    Path(p).mkdir(parents=True, exist_ok=True)

def extract_awkward_data(table, exp):
    """
    Extract data from Parquet table based on the expression.
    Returns an Awkward array that is nested in order [event number][jet/particle index]([jet constituent]).
    (Axis 2 is only used for datasets ending in jet_constituents)
    """ 
    try:
        if dataset_exists(table, exp):
            data = ak.from_arrow(table[exp])
    except KeyError:
        print(f"Expression '{exp}' not found in Parquet file.")
        return None
    return data

def draw(data, bins, name, color, ax=None, return_hist_data=False):
    """
    Draws a histogram given a dataset and parameters.
    Returns the histogram object.
        data: awkward or numpy array
            The data to be plotted.
        bins: np.linspace
            The bins for the histogram. "(50,0,20)" in Root equals np.linspace(0, 20, 51) here.
        name: str
            The name/label of the histogram.
        color: str
            The color of the histogram.
        ax: matplotlib.axes.Axes, optional
            The matplotlib ax to draw the histogram on. If None, use current ax per default.
        return_hist_data: bool, optional
            Default: False. If True, return the histogram data (values, bins_edges, patches) returned by matplotlib .hist function.
    """
    if data is None:
        return None

    if ax is None:
        ax = plt.gca()    
    
    values, bins_edges, patches = ax.hist(data, bins=bins, color=color, label=name, histtype='step', density=False)

    if return_hist_data:
        return values, bins_edges, patches
    else:
        return None

def get_jet_multiplicity(table, col_name):
    """
    Get the jet multiplicity from the table used for plot 1.
    Returns the number of jets in the dataset. 
    col_name should end with PT.
    """
    if dataset_exists(table, col_name):
        pt_data = extract_awkward_data(table, col_name)
        multiplicities = ak.num(pt_data)
        return multiplicities
    else:
        print(f"Dataset '{col_name}' not found in Parquet file.")
        return None
    
    
def get_vertex_multiplicity(table, col_name):
    """
    Get the vertex multiplicity from the table used for plot 6.
    Returns the number of vertices in the dataset.
    col_name should end with PrimaryVertex_T.
    """
    if dataset_exists(table, col_name):
        vertex_arr = extract_awkward_data(table, col_name)
        multiplicities = ak.num(vertex_arr, axis=1) 
        return multiplicities
    else:
        print(f"Dataset '{col_name}' not found in Parquet file.")
        return None
  
def mT_events_with_leptons(table, dir, lepton_type):
    """
    Get mT data for plot 13 where we only look at events with leptons of the given type.
    """
    pt_data = extract_awkward_data(table, f"{dir}{lepton_type}_PT")
    has_lepton_mask = ak.num(pt_data, axis=1) > 0      
    lepton_lead_pt = pt_data[has_lepton_mask][:,0]  
    lepton_lead_phi = extract_awkward_data(table, f"{dir}{lepton_type}_Phi")[has_lepton_mask][:,0]
    met = extract_awkward_data(table, f"{dir}MET_MET")[has_lepton_mask]
    met_phi = extract_awkward_data(table, f"{dir}MET_Phi")[has_lepton_mask]
    mT = np.sqrt(2 * lepton_lead_pt * met * (1 - np.cos(np.arccos(np.cos(lepton_lead_phi - met_phi)))))
    return mT

def make_plots(table, out_dir):
    """
    Create validation plots from the given pyarrow table, outputting them to out_dir.
    """
    
    ensure_dir(out_dir)
    COLORS = {
        'OFF': 'blue',           
        'L1T': 'green',       
        'GEN': 'black',       
        'PUP': 'red',
        'L1TPUP': 'magenta', 
        'ELE': 'magenta',
        'MU': 'orange'      
    }
    
    # ------------------------------------------------------------------- #
    # 1) Jet multiplicity   (PF vs L1 vs Gen)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))    
    
    h_pf = get_jet_multiplicity(table, "FullReco_JetAK4_PT")
    h_l1 = get_jet_multiplicity(table, "L1T_JetAK4_PT")
    h_ge = get_jet_multiplicity(table, "FullReco_GenJetAK4_PT")
    
    bins = np.linspace(0, 40, 21)
    draw(h_pf, bins, "PFJetMult", COLORS['OFF'], ax)
    if h_l1 is not None:
        draw(h_l1, bins, "L1JetMult", COLORS['L1T'], ax)
    if h_ge is not None:
        draw(h_ge, bins, "GenJetMult", COLORS['GEN'], ax)
    
    ax.set_xlabel("#jets/event")
    ax.set_ylabel("Events")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "01_JetMultiplicity.png"))
    plt.close(fig)

    # ------------------------------------------------------------------- #
    # 1 b) Jet multiplicity  – PF, PUPPI, Gen, L1, L1-PUPPI  (auto-range)
    # ------------------------------------------------------------------- #
        
    fig,ax = plt.subplots(figsize=(10, 6))
    
    max_jet_mult = 0
    for col_name in [
        "FullReco_JetAK4_PT",
        "FullReco_JetPuppiAK4_PT",
        "FullReco_GenJetAK4_PT",
        "L1T_JetAK4_PT",
        "L1T_JetPuppiAK4_PT",
    ]:
        if dataset_exists(table, col_name):
            multiplicities = get_jet_multiplicity(table, col_name)
            if multiplicities is not None:
                max_jet_mult = max(max_jet_mult, ak.max(multiplicities))
    
    max_jet_mult += 1
    bins = np.linspace(0, max_jet_mult, min(max_jet_mult, 50) + 1)
    
    for col_name, label, color in [
        ("FullReco_JetAK4_PT", "PF jets", COLORS['OFF']),
        ("FullReco_JetPuppiAK4_PT", "PUPPI jets", COLORS['PUP']),
        ("FullReco_GenJetAK4_PT", "Gen jets", COLORS['GEN']),        
        ("L1T_JetAK4_PT", "L1T jets", COLORS['L1T']),
        ("L1T_JetPuppiAK4_PT", "L1T-PUPPI jets", COLORS['L1TPUP']),
    ]:
        multiplicities = get_jet_multiplicity(table, col_name)
        draw(multiplicities, bins, label, color, ax)
    ax.set_xlabel("#jets/event")
    ax.set_ylabel("Events")
    ax.set_title("Jet multiplicity")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "01b_JetMultiplicity_PUPPI.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 1 c) Jet multiplicity with pT > 30 GeV (PF, L1, Gen)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    
    bins = np.linspace(-0.5, 50.5, 52)
    
    for col_name, label, color in [
        ("FullReco_JetAK4_PT", "PFJetMult>30", COLORS['OFF']),
        ("L1T_JetAK4_PT", "L1JetMult>30", COLORS['L1T']),
        ("FullReco_GenJetAK4_PT", "GenJetMult>30", COLORS['GEN']),
    ]:
        if dataset_exists(table, col_name):
            pt_data = extract_awkward_data(table, col_name)
            pt_mask = pt_data > 30
            multiplicities = ak.num(pt_data[pt_mask], axis=1)
            draw(multiplicities, bins, label, color, ax)  
    ax.set_xlabel("#jets/event (pT > 30 GeV)")
    ax.set_ylabel("Events")
    ax.set_title("Jet multiplicity with pT > 30 GeV")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "01c_JetMultiplicity_pt30.png"))
    plt.close(fig)

    # ------------------------------------------------------------------- #
    # 2) Leading & sub-leading jet pT (PF & L1T)
    # ------------------------------------------------------------------- #

    fig, ax = plt.subplots(figsize=(10, 6))
    
    xmax = ak.max([ak.max(ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_PT"),1,axis=1)[:,0]),
                  ak.max(ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_PT"),1,axis=1)[:,0]),
                  ak.max(ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_PT"),2,axis=1)[:,1]),
                  ak.max(ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_PT"),2,axis=1)[:,1])])

    #xmax = np.max([250, int(1.1*xmax)])
    xmax = int(xmax * 2)
    bins = np.linspace(0, xmax, 61)

    for pt_data, label, color in [
        (ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_PT"), 1, axis=1)[:,0], "hLeadPF", COLORS['OFF']),
        (ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_PT"), 1, axis=1)[:,0], "hLeadL1", COLORS['L1T']),
        (ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_PT"), 2, axis=1)[:,1], "hSubPF", 'lightblue'),
        (ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_PT"), 2, axis=1)[:,1], "hSubL1", 'lightgreen'),
    ]:
        draw(pt_data, bins, label, color, ax)
        
    ax.set_xlabel("jet pT (GeV)")
    ax.set_ylabel("Events")
    ax.set_title("Leading & sub-leading jet pT")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "02_LeadSubleadJetPT.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 3) Scalar H_T  (offline vs L1T)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    filtered_pt_off_data = extract_awkward_data(table, "FullReco_JetAK4_PT")*(np.abs(extract_awkward_data(table,"FullReco_JetAK4_Eta")) < 2.4)
    filtered_pt_l1t_data = extract_awkward_data(table, "L1T_JetAK4_PT")*(np.abs(extract_awkward_data(table,"L1T_JetAK4_Eta")) < 2.4)
    ht_off = ak.sum(filtered_pt_off_data, axis=1)
    ht_l1t = ak.sum(filtered_pt_l1t_data, axis=1)

    bins = np.linspace(0, 1500, 61)
    
    draw(ht_off, bins, "Offline HT", COLORS['OFF'], ax)
    draw(ht_l1t, bins, "L1T HT", COLORS['L1T'], ax)
    ax.set_xlabel("H_T (GeV)")
    ax.set_ylabel("Events")
    ax.set_title("Scalar H_T")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "03_EventHT.png"))
    plt.close(fig)

    
    # ------------------------------------------------------------------- #
    # 4) MET overlay  (Gen, PF, PUPPI, L1, L1-PUPPI)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    data = [
        (extract_awkward_data(table, "FullReco_GenMissingET_MET"), "Gen", COLORS['GEN']),
        (extract_awkward_data(table, "FullReco_MET_MET"), "PF", COLORS['OFF']),
        (extract_awkward_data(table, "FullReco_PUPPIMET_MET"), "PUPPI", COLORS['PUP']),
        (extract_awkward_data(table, "L1T_MET_MET"), "L1T", COLORS['L1T']),
        (extract_awkward_data(table, "L1T_PUPPIMET_MET"), "L1T-PUPPI", COLORS['L1TPUP']),
    ]
    
    xmax = np.max([np.max(d[0]) for d in data if d[0] is not None])
    xmax = np.max([250, int(1.1*xmax)])
    bins = np.linspace(0, xmax, 61)
    for met_data, label, color in data:
        if met_data is not None:
            draw(met_data, bins, label, color, ax)
    ax.set_xlabel("MET (GeV)")
    ax.set_ylabel("Events")
    ax.set_title("MET overlay")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "04_MET_Overlay.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 5) MET response  (Reco & L1T)  GenMET>10 GeV
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    gen_met = extract_awkward_data(table, "FullReco_GenMissingET_MET")
    pf_met = extract_awkward_data(table, "FullReco_MET_MET")
    l1t_met = extract_awkward_data(table, "L1T_MET_MET")
    gen_mask = gen_met > 10
    gen_met_filtered = ak.flatten(gen_met[gen_mask])
    pf_met_filtered = ak.flatten(pf_met[gen_mask])
    l1t_met_filtered = ak.flatten(l1t_met[gen_mask])
    bins = np.linspace(0, 2, 51)
    draw(pf_met_filtered/gen_met_filtered, bins, "METRespOffline", COLORS['OFF'], ax)
    draw(l1t_met_filtered/gen_met_filtered, bins, "METRespL1", COLORS['L1T'], ax)
    ax.set_xlabel("Reco or L1 MET / Gen MET (Gen MET>10 GeV)")
    ax.set_ylabel("Events")
    ax.set_title("MET response")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "05_MET_Response.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 6) Vertex multiplicity (offline & L1T)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    vtx_mult_off = get_vertex_multiplicity(table, "FullReco_PrimaryVertex_T")
    vtx_mult_l1t = get_vertex_multiplicity(table, "L1T_PrimaryVertex_T")
    
    if vtx_mult_off is not None or vtx_mult_l1t is not None:
        vmax = np.max([np.max(b) for b in (vtx_mult_off, vtx_mult_l1t) if b is not None] + [5])
        if vmax < 5:
            vmax = 5
        vmax = vmax + 100
        nbins = vmax + 1
        bins = np.linspace(-0.5, int(vmax + 0.5), nbins + 1) 
        if vtx_mult_off is not None:
            draw(vtx_mult_off, bins, "VtxMult Offline", COLORS['OFF'], ax)
        if vtx_mult_l1t is not None:
            draw(vtx_mult_l1t, bins, "VtxMult L1", COLORS['L1T'], ax)
        ax.set_xlabel("Vertex multiplicity")
        ax.set_ylabel("Events")
        ax.set_title("Vertex multiplicity")
        ax.legend()
        fig.savefig(os.path.join(out_dir, "06_VertexMultiplicity.png"))
    
    plt.close(fig)
    
    
    # ------------------------------------------------------------------- #
    # 7) PUPPI weight  (offline & L1T)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    puppi_weights_off = ak.flatten(extract_awkward_data(table, "FullReco_PUPPIPart_PuppiW"))
    puppi_weights_l1t = ak.flatten(extract_awkward_data(table, "L1T_PUPPIPart_PuppiW"))

    bins = np.linspace(0, 1, 51)
    ax.set_yscale('log')
    if puppi_weights_off is not None:
        draw(puppi_weights_off, bins, "PuppiW offline", COLORS['OFF'], ax)
    if puppi_weights_l1t is not None:
        draw(puppi_weights_l1t, bins, "PuppiW L1T", COLORS['L1T'], ax)
    ax.set_xlabel("PUPPI weight")
    ax.set_ylabel("Events")
    ax.set_title("PUPPI weight")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "07_PUPPIweights.png"))
    plt.close(fig)    
    
    # ------------------------------------------------------------------- #
    # 8)  Leading lepton pT  – electrons & muons (offline vs L1)
    # ------------------------------------------------------------------- #
    leptons =[("Electron", "leading e", COLORS['ELE']),
              ("MuonTight", "leading μ", COLORS['MU'])]
    for lepton_type, label, color in leptons: 
        fig, ax = plt.subplots(figsize=(10, 6))   
        br_off = f"FullReco_{lepton_type}_PT"
        br_off_data = ak.pad_none(extract_awkward_data(table, br_off),1,axis=1)[:,0]
        br_l1 = f"L1T_{lepton_type}_PT"
        br_l1_data = ak.pad_none(extract_awkward_data(table, br_l1),1,axis=1)[:,0]
        if dataset_exists(table, br_off) is None or dataset_exists(table, br_l1) is None:
            print(f"  Skipping {label} plots, datasets not found: {br_off}, {br_l1}")
            continue
        pmax = max(ak.max(br_off_data),
                   ak.max(br_l1_data))
        pmax = max(50, int(1.1*pmax))
        bins = np.linspace(0, pmax, 51)
        draw(br_off_data, bins, f"{label} OFF", color, ax)
        draw(br_l1_data, bins, f"{label} L1T", color, ax)
        ax.set_xlabel("Leading lepton pT (GeV)")
        ax.set_ylabel("Events")
        ax.set_title(f"Leading {lepton_type} pT")
        ax.legend()
        fig.savefig(os.path.join(out_dir, f"08_{lepton_type}_LeadingPT.png"))
        plt.close(fig)    
        
    # ------------------------------------------------------------------- #
    # 9) Dijet invariant mass (two leading jets)  – PF & L1
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    lead_jet_pt_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_PT"),1,axis=1)[:,0]
    sublead_jet_pt_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_PT"),2,axis=1)[:,1]
    lead_jet_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Eta"),1,axis=1)[:,0]
    sublead_jet_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Eta"),2,axis=1)[:,1]
    lead_jet_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Phi"),1,axis=1)[:,0]
    sublead_jet_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Phi"),2,axis=1)[:,1]
    dijet_mass_off = np.sqrt(
        2 * lead_jet_pt_off * sublead_jet_pt_off * 
        (np.cosh(lead_jet_eta_off - sublead_jet_eta_off) - 
         np.cos(lead_jet_phi_off - sublead_jet_phi_off))
    )
    lead_jet_pt_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_PT"),1,axis=1)[:,0]
    sublead_jet_pt_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_PT"),2,axis=1)[:,1]
    lead_jet_eta_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Eta"),1,axis=1)[:,0]
    sublead_jet_eta_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Eta"),2,axis=1)[:,1]
    lead_jet_phi_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Phi"),1,axis=1)[:,0]
    sublead_jet_phi_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Phi"),2,axis=1)[:,1]
    dijet_mass_l1 = np.sqrt(
        2 * lead_jet_pt_l1 * sublead_jet_pt_l1 * 
        (np.cosh(lead_jet_eta_l1 - sublead_jet_eta_l1) - 
         np.cos(lead_jet_phi_l1 - sublead_jet_phi_l1))
    )
    bins = np.linspace(0, 2000, 41)
    draw(dijet_mass_off, bins, "DijetOff", COLORS['OFF'])
    draw(dijet_mass_l1, bins, "DijetL1", COLORS['L1T'], ax)
    ax.set_xlabel("Dijet invariant mass (GeV)")
    ax.set_ylabel("Events")
    ax.set_yscale('log')
    ax.set_title("Dijet invariant mass (two leading jets)")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "09_DijetMass.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 9 b) Dilepton invariant mass  (ee, μμ, eμ)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
       
    lead_el_pt_off = ak.pad_none(extract_awkward_data(table, "FullReco_Electron_PT"),1,axis=1)[:,0]
    sublead_el_pt_off = ak.pad_none(extract_awkward_data(table, "FullReco_Electron_PT"),2,axis=1)[:,1]
    lead_el_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_Electron_Eta"),1,axis=1)[:,0]
    sublead_el_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_Electron_Eta"),2,axis=1)[:,1]
    lead_el_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_Electron_Phi"),1,axis=1)[:,0]
    sublead_el_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_Electron_Phi"),2,axis=1)[:,1]
    lead_mu_pt_off = ak.pad_none(extract_awkward_data(table, "FullReco_MuonTight_PT"),1,axis=1)[:,0]
    sublead_mu_pt_off = ak.pad_none(extract_awkward_data(table, "FullReco_MuonTight_PT"),2,axis=1)[:,1]
    lead_mu_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_MuonTight_Eta"),1,axis=1)[:,0]
    sublead_mu_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_MuonTight_Eta"),2,axis=1)[:,1]
    lead_mu_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_MuonTight_Phi"),1,axis=1)[:,0]
    sublead_mu_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_MuonTight_Phi"),2,axis=1)[:,1]
    dilepton_mass_ee_off = np.sqrt(
        2 * lead_el_pt_off * sublead_el_pt_off * 
        (np.cosh(lead_el_eta_off - sublead_el_eta_off) - 
         np.cos(lead_el_phi_off - sublead_el_phi_off))
    )
    dilepton_mass_mumu_off = np.sqrt(
        2 * lead_mu_pt_off * sublead_mu_pt_off * 
        (np.cosh(lead_mu_eta_off - sublead_mu_eta_off) - 
         np.cos(lead_mu_phi_off - sublead_mu_phi_off))
    )
    dilepton_mass_emu_off = np.sqrt(
        2 * lead_el_pt_off * lead_mu_pt_off * 
        (np.cosh(lead_el_eta_off - lead_mu_eta_off) - 
         np.cos(lead_el_phi_off - lead_mu_phi_off))
    )
    
    bins = np.linspace(0, 200, 61)
    draw(dilepton_mass_ee_off, bins, "Dilepton mass (e⁺e⁻)", COLORS['ELE'], ax)
    draw(dilepton_mass_mumu_off, bins, "Dilepton mass (μ⁺μ⁻)", COLORS['MU'], ax)
    draw(dilepton_mass_emu_off, bins, "Dilepton mass (e⁺μ⁻)", 'green', ax)
    ax.set_xlabel("Dilepton invariant mass (GeV)")
    ax.set_ylabel("Events")
    ax.set_yscale('log')
    ax.set_title("Dilepton invariant mass (e⁺e⁻, μ⁺μ⁻, e⁺μ⁻)")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "09b_DileptonMass.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 10) Leading jet mass  – PF & L1
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    lead_jet_mass_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Mass"),1,axis=1)[:,0]
    lead_jet_mass_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Mass"),1,axis=1)[:,0]
    bins = np.linspace(0, 300, 51)
    draw(lead_jet_mass_off, bins, "LeadJetMass OFF", COLORS['OFF'], ax)
    draw(lead_jet_mass_l1, bins, "LeadJetMass L1T", COLORS['L1T'], ax)
    ax.set_xlabel("Leading jet mass (GeV)")
    ax.set_ylabel("Events")
    ax.set_yscale('log')
    ax.set_title("Leading jet mass")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "10_LeadJetMass.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 11) η / φ distributions (jets, muons, electrons -- leading object)
    # ------------------------------------------------------------------- #
    eta_phi_objs = [("JetAK4","jets",COLORS['OFF']),("MuonTight","muons",COLORS['MU']),
                    ("Electron","electrons",COLORS['ELE'])]
    for typ,lab,col in eta_phi_objs:
        for var,axis,bins in [('Eta', 'η', np.linspace(-5, 5, 51)),
                              ('Phi', 'φ', np.linspace(-3.2, 3.2,65))]:
            fig, ax = plt.subplots(figsize=(10, 6))
            off_data = ak.pad_none(extract_awkward_data(table, f"FullReco_{typ}_{var}"), 1, axis=1)[:,0]
            l1_data = ak.pad_none(extract_awkward_data(table, f"L1T_{typ}_{var}"), 1, axis=1)[:,0]
            draw(off_data, bins, f"{lab} {axis} OFF", col, ax)
            draw(l1_data, bins, f"{lab} {axis} L1T", col, ax)
            ax.set_xlabel(f"{lab} {axis}")
            ax.set_ylabel("Events")
            ax.set_yscale('log')
            ax.set_title(f"{lab} {axis} distribution")
            ax.legend()
            fig.savefig(os.path.join(out_dir, f"11_{var}_{lab}.png"))
            plt.close(fig)

    # ------------------------------------------------------------------- #
    # 12) ΔR between the two leading jets
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    lead_jet_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Eta"),1,axis=1)[:,0]
    sublead_jet_eta_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Eta"),2,axis=1)[:,1]
    lead_jet_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Phi"),1,axis=1)[:,0]
    sublead_jet_phi_off = ak.pad_none(extract_awkward_data(table, "FullReco_JetAK4_Phi"),2,axis=1)[:,1]
    lead_jet_eta_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Eta"),1,axis=1)[:,0]
    sublead_jet_eta_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Eta"),2,axis=1)[:,1]
    lead_jet_phi_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Phi"),1,axis=1)[:,0]
    sublead_jet_phi_l1 = ak.pad_none(extract_awkward_data(table, "L1T_JetAK4_Phi"),2,axis=1)[:,1]
    deltaR_off = np.sqrt((lead_jet_eta_off - sublead_jet_eta_off)**2 + 
                         (np.arccos(np.cos(lead_jet_phi_off - sublead_jet_phi_off)))**2)
    deltaR_l1 = np.sqrt((lead_jet_eta_l1 - sublead_jet_eta_l1)**2 + 
                        (np.arccos(np.cos(lead_jet_phi_l1 - sublead_jet_phi_l1)))**2)
    bins = np.linspace(0, 6, 51)
    draw(deltaR_off, bins, "DeltaROff", COLORS['OFF'], ax)
    draw(deltaR_l1, bins, "DeltaRL1T", COLORS['L1T'], ax)
    ax.set_xlabel("ΔR between leading jets")
    ax.set_ylabel("Events")
    ax.set_yscale('log')
    ax.set_title("ΔR between leading jets")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "12_DeltaR_Jets.png"))
    plt.close(fig)
    
    
    # ------------------------------------------------------------------- #
    # 13) Transverse mass  M_T(leading ℓ , MET)  (offline & L1T)
    # ------------------------------------------------------------------- #
    for lepton_type in ['Electron', 'MuonTight']:
        fig, ax = plt.subplots(figsize=(10, 6))
        for dir, tag in [('FullReco_', 'OFF'), ('L1T_', 'L1T')]:
            mT_data = mT_events_with_leptons(table, dir, lepton_type)
            if mT_data is not None:
                bins = np.linspace(0, 500, 51)
                draw(mT_data, bins, f"hMT_{tag}", COLORS[tag], ax)
        ax.set_xlabel("M_T(leading l, MET) [GeV]")
        ax.set_ylabel("Events")
        ax.set_yscale('log')
        ax.set_title(f"Transverse mass M_T")
        ax.legend()
        fig.savefig(os.path.join(out_dir, f"13_MT_{lepton_type}.png"))
        plt.close(fig)
    
    
    print(f"   ✔  Plots → {out_dir}")

# --------------------------------------------------------------------------- #
# walk the top directory once, keep one seed per process
# --------------------------------------------------------------------------- #
def collect_event_parquets(topdir):
    evt = {};  pat = re.compile(r"(?P<proc>.+)-\d+-\d+$")
    for dirpath,_,files in os.walk(topdir):
        if "event.parquet" not in files:  continue
        m = pat.match(Path(dirpath).name);  proc = m.group("proc") if m else None
        if proc and proc not in evt:   evt[proc] = Path(dirpath)/"event.parquet"
    return evt

# --------------------------------------------------------------------------- #
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo", help="Top folder with PROCESS-NEV-SEED sub-dirs")
    ap.add_argument("--outdir", default=None,
                    help="Output directory (default: <repo>/parquet_validation_plots)")
    args = ap.parse_args()

    repo = Path(args.repo).expanduser().resolve()
    if not repo.is_dir():
        sys.exit(f"Repository '{repo}' not found.")
    outdir = Path(args.outdir) if args.outdir else repo/"parquet_validation_plots"
    ensure_dir(outdir)

    todo = collect_event_parquets(repo)
    if not todo:
        sys.exit("No event.parquet files found – check directory layout.")

    for proc, parquet in sorted(todo.items()):
        print(f"Processing {proc:>20}  ({parquet})")
        table = pq.read_table(parquet)
        make_plots(table, outdir/f"{proc}_plots")

if __name__ == "__main__":
    main()
    