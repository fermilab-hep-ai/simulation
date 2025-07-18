#!/usr/bin/env python3
"""
Delphes validation adapted from make_validation_plots.py to work with HDF5 files.

Usage
-----
    python make_validation_plots.py  /path/to/PROC-NEV-SEED/parent  [--outdir OUT]

The top directory must contain folders named
        PROCESS-NUMEVENTS-RANDSEED
each holding an *event.h5* produced by your pipeline.
"""

import argparse, os, re, sys
from pathlib import Path
import h5py
import numpy as np
import matplotlib.pyplot as plt

# --------------------------------------------------------------------------- #
# helper utilities
# --------------------------------------------------------------------------- #
def dataset_exists(h5file, dataset):
    """Check if dataset exists in HDF5 file"""
    try:
        h5file[dataset]
        return True
    except:
        return False

def ensure_dir(p):
    Path(p).mkdir(parents=True, exist_ok=True)

def extract_data(h5file, exp):
    """Extract data from HDF5 file based on the expression.""" 
    try:
        data = h5file[exp][:]
    except KeyError:
        print(f"Expression '{exp}' not found in HDF5 file.")
        return None
    return data

def apply_cut(data, cut):
    """
    Apply a cut to the data.
    The cut is expected to be a boolean expression.
    """
    try:
        return data[cut]
    except Exception as e:
        print(f"Error applying cut '{cut}': {e}")
        return data


def draw(data, bins, name, color, ax=None):
    """
    Draws a histogram from the HDF5 file based on the expression and cut.
    Returns the histogram object.
        data: str
            The data to be plotted, typically a numpy array.
        bins: np.linspace
            The bins for the histogram.
        name: str
            The name of the histogram.
        color: str
            The color of the histogram.
        ax: matplotlib.axes.Axes, optional
            The axes to draw the histogram on. If None, use current ax.
    """
    if data is None:
        return None

    if ax is None:
        ax = plt.gca()    
    
    values, bins_edges, patches = ax.hist(data, bins=bins, color=color, label=name, histtype='step', density=False)
    
    return None

def first_dataset(h5file, candidates):
    " Return first dataset present in *candidates*, or None."
    for ds in candidates:
        if dataset_exists(h5file, ds):
            return ds
    return None

def get_jet_multiplicity(h5file, dataset_path):
    """
    Get the jet multiplicity from the HDF5 file.
    Returns the number of jets in the dataset. 
    Dataset path should end with PT_offsets.
    """
    if dataset_exists(h5file, dataset_path):
        offsets = h5file[dataset_path][:]
        multiplicities = np.diff(offsets)
        return multiplicities
    else:
        print(f"Dataset '{dataset_path}' not found in HDF5 file.")
        return None
    
def get_vertex_multiplicity(h5file, dataset_path):
    """
    Get the vertex multiplicity from the HDF5 file.
    Returns the number of vertices in the dataset.
    Dataset path should end with PrimaryVertex/T_offsets.
    """
    if dataset_exists(h5file, dataset_path):
        offsets = h5file[dataset_path][:]
        multiplicities = np.diff(offsets)
        return multiplicities
    else:
        print(f"Dataset '{dataset_path}' not found in HDF5 file.")
        return None
  
def mT_events_with_leptons(h5file, dir, lepton_type):
    """
    Get mT data for plot 11 where we only look at events with leptons of the given type.
    """
    pt_data = extract_data(h5file, f"{dir}{lepton_type}/PT_data")
    pt_offsets = extract_data(h5file, f"{dir}{lepton_type}/PT_offsets")
    has_lepton_mask = np.diff(pt_offsets) > 0         
    events_with_leptons = np.where(has_lepton_mask)[0]
    lepton_lead_pt = pt_data[pt_offsets[events_with_leptons]]  
    lepton_lead_phi = extract_data(h5file, f"{dir}{lepton_type}/Phi_data")[pt_offsets[events_with_leptons]]
    met = extract_data(h5file, f"{dir}MET/MET_data")[events_with_leptons]
    met_phi = extract_data(h5file, f"{dir}MET/Phi_data")[events_with_leptons]
    mT = np.sqrt(2 * lepton_lead_pt * met * (1 - np.cos(lepton_lead_phi - met_phi)))
    return mT

def make_plots(h5file, out_dir):
    
    ensure_dir(out_dir)
    COLORS = {
        'OFF': 'blue',           
        'L1T': 'green',       
        'GEN': 'black',       
        'PUP': 'red',
        'L1TPUP': 'magenta'        
    }
    
    # ------------------------------------------------------------------- #
    # 1) Jet multiplicity  (PF, L1T, Gen, PUPPI, L1T-PUPPI)
    # ------------------------------------------------------------------- #    
    
    
    fig,ax = plt.subplots(figsize=(10, 6))

    for ds_path, label, color in [
        ("FullReco/JetAK4/PT_offsets", "PF jets", COLORS['OFF']),
        ("FullReco/JetPuppiAK4/PT_offsets", "PUPPI jets", COLORS['PUP']),
        ("L1T/JetAK4/PT_offsets", "L1T jets", COLORS['L1T']),
        ("L1T/JetPuppiAK4/PT_offsets", "L1T-PUPPI jets", COLORS['L1TPUP']),
        ("FullReco/GenJetAK4/PT_offsets", "Gen jets", COLORS['GEN']),
    ]:
        multiplicities = get_jet_multiplicity(h5file, ds_path)
        draw(multiplicities, np.linspace(0,40,21), label, color, ax)
    ax.set_xlabel("#jets/event")
    ax.set_ylabel("Events")
    ax.set_title("Jet multiplicity")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "01_JetMultiplicity.png"))
    plt.close(fig)
    
    # ------------------------------------------------------------------- #
    # 2) Leading & sub-leading jet pT (PF & L1T)
    # ------------------------------------------------------------------- #

    fig, ax = plt.subplots(figsize=(10, 6))
    
    xmax = np.max([np.max(extract_data(h5file, "FullReco/JetAK4/PT_data")[extract_data(h5file, "FullReco/JetAK4/PT_offsets")[:-1]]),
                  np.max(extract_data(h5file, "L1T/JetAK4/PT_data")[extract_data(h5file, "L1T/JetAK4/PT_offsets")[:-1]]),
                  np.max(extract_data(h5file, "FullReco/JetAK4/PT_data")[1+extract_data(h5file, "FullReco/JetAK4/PT_offsets")[:-1]]),
                  np.max(extract_data(h5file, "L1T/JetAK4/PT_data")[1+extract_data(h5file, "L1T/JetAK4/PT_offsets")[:-1]])])

    xmax = np.max([250, int(1.1*xmax)])
    bins = np.linspace(0, xmax, 61)

    for pt_data, label, color in [
        (extract_data(h5file, "FullReco/JetAK4/PT_data")[extract_data(h5file, "FullReco/JetAK4/PT_offsets")[:-1]], "LeadPF", COLORS['OFF']),
        (extract_data(h5file, "L1T/JetAK4/PT_data")[extract_data(h5file, "L1T/JetAK4/PT_offsets")[:-1]], "LeadL1T", COLORS['L1T']), 
        (extract_data(h5file, "FullReco/JetAK4/PT_data")[1+extract_data(h5file, "FullReco/JetAK4/PT_offsets")[:-1]], "SubLeadPF", 'lightblue'),
        (extract_data(h5file, "L1T/JetAK4/PT_data")[1+extract_data(h5file, "L1T/JetAK4/PT_offsets")[:-1]], "SubLeadL1T", 'lightgreen'),
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
    filtered_pt_off_data = extract_data(h5file, "FullReco/JetAK4/PT_data")*(np.abs(extract_data(h5file,"FullReco/JetAK4/Eta_data")) < 2.4)
    filtered_pt_l1t_data = extract_data(h5file, "L1T/JetAK4/PT_data")*(np.abs(extract_data(h5file,"L1T/JetAK4/Eta_data")) < 2.4)
    ht_off = np.add.reduceat(filtered_pt_off_data, extract_data(h5file, "FullReco/JetAK4/PT_offsets")[:-1])
    ht_l1t = np.add.reduceat(filtered_pt_l1t_data, extract_data(h5file, "L1T/JetAK4/PT_offsets")[:-1])
    
    bins = np.linspace(0, 1500, 61)
    
    draw(ht_off, bins, "H_T (PF), |η|<2.4", COLORS['OFF'], ax)
    draw(ht_l1t, bins, "H_T (L1T), |η|<2.4", COLORS['L1T'], ax)
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
        (extract_data(h5file, "FullReco/GenMissingET/MET_data"), "Gen", COLORS['GEN']),
        (extract_data(h5file, "FullReco/MET/MET_data"), "PF", COLORS['OFF']),
        (extract_data(h5file, "FullReco/PUPPIMET/MET_data"), "PUPPI", COLORS['PUP']),
        (extract_data(h5file, "L1T/MET/MET_data"), "L1T", COLORS['L1T']),
        (extract_data(h5file, "L1T/PUPPIMET/MET_data"), "L1T-PUPPI", COLORS['L1TPUP']),
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
    gen_met = extract_data(h5file, "FullReco/GenMissingET/MET_data")
    pf_met = extract_data(h5file, "FullReco/MET/MET_data")
    l1t_met = extract_data(h5file, "L1T/MET/MET_data")
    gen_mask = gen_met > 10
    gen_met_filtered = gen_met[gen_mask]
    pf_met_filtered = pf_met[gen_mask]
    l1t_met_filtered = l1t_met[gen_mask]
    bins = np.linspace(0, 2, 51)
    draw(pf_met_filtered/gen_met_filtered, bins, "hRespReco", COLORS['OFF'], ax)
    draw(l1t_met_filtered/gen_met_filtered, bins, "hRespL1T", COLORS['L1T'], ax)
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
    vtx_mult_off = get_vertex_multiplicity(h5file, "FullReco/PrimaryVertex/T_offsets")
    vtx_mult_l1t = get_vertex_multiplicity(h5file, "L1T/PrimaryVertex/T_offsets")
    
    if vtx_mult_off is not None or vtx_mult_l1t is not None:
        vmax = np.max([np.max(b) for b in (vtx_mult_off, vtx_mult_l1t) if b is not None] + [5])
        bins = np.linspace(0, int(vmax), np.min([int(vmax), 200]) + 1) 
        if vtx_mult_off is not None:
            draw(vtx_mult_off, bins, "hVtxOff", COLORS['OFF'], ax)
        if vtx_mult_l1t is not None:
            draw(vtx_mult_l1t, bins, "hVtxL1T", COLORS['L1T'], ax)
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
    puppi_weights_off = extract_data(h5file, "FullReco/PUPPIPart/PuppiW_data")
    puppi_weights_l1t = extract_data(h5file, "L1T/PUPPIPart/PuppiW_data")
        
    bins = np.linspace(0, 1, 51)
    ax.set_yscale('log')
    if puppi_weights_off is not None:
        draw(puppi_weights_off, bins, "hPupOff", COLORS['OFF'], ax)
    if puppi_weights_l1t is not None:
        draw(puppi_weights_l1t, bins, "hPupL1T", COLORS['L1T'], ax)
    ax.set_xlabel("PUPPI weight")
    ax.set_ylabel("Events")
    ax.set_title("PUPPI weight")
    ax.legend()
    fig.savefig(os.path.join(out_dir, "07_PUPPIweights.png"))
    plt.close(fig)





    
    
    # ------------------------------------------------------------------- #
    # 8) m(jj), ΔR(jj), m(jjj) – offline & L1T overlays
    # ------------------------------------------------------------------- #
    # still to do
    
    
    # ------------------------------------------------------------------- #
    # 9) Jet mass, η, φ spectra  (offline & L1T)
    # ------------------------------------------------------------------- #
    for axis, bins, label in [('Mass', np.linspace(0, 400, 61), "Jet mass (GeV)"),
                              ('Eta', np.linspace(-5, 5, 61), "Jet |η|"),
                              ('Phi', np.linspace(-3.2, 3.2, 65), "Jet φ")]:
        fig, ax = plt.subplots(figsize=(10, 6))   
        for dir, tag in [('FullReco/JetAK4/','OFF'),
                            ('L1T/JetAK4/','L1T')]:
            data = extract_data(h5file, f"{dir}{axis}_data")
            draw(data, bins, f"{tag} {label}", COLORS[tag], ax)
        ax.set_xlabel(label)
        ax.set_ylabel("Events")
        ax.set_title(f"{label}")
        ax.legend()
        fig.savefig(os.path.join(out_dir, f"09_Jet{axis}.png"))
        plt.close(fig)
   
    # ------------------------------------------------------------------- #
    # 10) Dilepton invariant masses (e⁺e⁻ / μ⁺μ⁻, offline & L1T)
    # ------------------------------------------------------------------- #
    # still to do
    
    # ------------------------------------------------------------------- #
    # 11) Transverse mass  M_T(leading ℓ , MET)  (offline & L1T)
    # ------------------------------------------------------------------- #
    fig, ax = plt.subplots(figsize=(10, 6))
    for dir, tag in [('FullReco/', 'OFF'), ('L1T/', 'L1T')]:
        pt_dataset = first_dataset(h5file, [f"{dir}Electron/PT_data", f"{dir}MuonTight/PT_data"])
        lepton_type = 'Electron' if 'Electron' in pt_dataset else 'MuonTight'
        mT_data = mT_events_with_leptons(h5file, dir, lepton_type)
        if mT_data is not None:
            bins = np.linspace(0, 500, 61)
            draw(mT_data, bins, f"hMT_{tag}", COLORS[tag], ax)
    ax.set_xlabel("M_T(leading l, MET) [GeV]")
    ax.set_ylabel("Events")
    ax.set_title(f"Transverse mass M_T")
    ax.legend()
    fig.savefig(os.path.join(out_dir, f"11_MT_lep_MET.png"))
    plt.close(fig)
   
    print(f"   ✔  Plots → {out_dir}")

# --------------------------------------------------------------------------- #
# walk the top directory once, keep one seed per process
# --------------------------------------------------------------------------- #
def collect_event_h5s(topdir):
    evt = {};  pat = re.compile(r"(?P<proc>.+)-\d+-\d+$")
    for dirpath,_,files in os.walk(topdir):
        if "event.h5" not in files:  continue
        m = pat.match(Path(dirpath).name);  proc = m.group("proc") if m else None
        if proc and proc not in evt:   evt[proc] = Path(dirpath)/"event.h5"
    return evt

# --------------------------------------------------------------------------- #
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo", help="Top folder with PROCESS-NEV-SEED sub-dirs")
    ap.add_argument("--outdir", default=None,
                    help="Output directory (default: <repo>/h5_validation_plots)")
    args = ap.parse_args()

    repo = Path(args.repo).expanduser().resolve()
    if not repo.is_dir():
        sys.exit(f"Repository '{repo}' not found.")
    outdir = Path(args.outdir) if args.outdir else repo/"h5_validation_plots"
    ensure_dir(outdir)

    todo = collect_event_h5s(repo)
    if not todo:
        sys.exit("No event.h5 files found – check directory layout.")

    for proc, h5 in sorted(todo.items()):
        print(f"Processing {proc:>20}  ({h5})")
        with h5py.File(h5, 'r') as h5file:
            make_plots(h5file, outdir/f"{proc}_plots")

if __name__ == "__main__":
    main()
    