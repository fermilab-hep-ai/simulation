import ROOT
from array import array

import argparse, os, sys
parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input",  required=True,
                    help="input Delphes ROOT file (event.root)")
parser.add_argument("-o", "--output", required=True,
                    help="output skimmed ROOT file")
args = parser.parse_args()

if not os.path.isfile(args.input):
    sys.exit(f"[process_root_L1T] Input file {args.input} not found")


# Load Delphes shared libraries
ROOT.gSystem.Load("/usr/local/share/delphes/Delphes-3.5.0/libDelphes.so")

def copy_selected_branches_with_flags(
    delphes_tree,
    branches,
    loose_branches=None,
    tight_branches=None,
    branch_prefix=""
):
    """
    Creates a new TTree containing only 'branches',
    plus three additional integer branches:
      1) EventID
      2) isLoose
      3) isTight
    which are set per event.
    """
    delphes_tree.SetBranchStatus("*", 0)  # Deactivate all branches

    # Activate only selected branches
    for branch in branches:
        full_branch_name = f"{branch_prefix}{branch}" if branch_prefix else branch
        if delphes_tree.GetBranch(full_branch_name):
            delphes_tree.SetBranchStatus(full_branch_name, 1)
        else:
            print(f"Warning: Branch '{full_branch_name}' not found in {delphes_tree.GetName()}")

    # Clone a skeleton tree
    new_tree = delphes_tree.CloneTree(0)

    # Arrays for new branches
    event_id = array('i', [0])
    is_loose = array('i', [0])
    is_tight = array('i', [0])

    new_tree.Branch("EventID", event_id, "EventID/I")
    new_tree.Branch("isLoose", is_loose, "isLoose/I")
    new_tree.Branch("isTight", is_tight, "isTight/I")

    # 1) Collect unique IDs for LOOSE
    loose_entries = set()
    if loose_branches:
        loose_tree = input_file.Get("Delphes")  # or however you read the same tree
        loose_tree.SetBranchStatus("*", 0)
        for lb in loose_branches:
            if loose_tree.GetBranch(lb):
                loose_tree.SetBranchStatus(lb, 1)
            else:
                print(f"Warning: Loose branch '{lb}' not found in {loose_tree.GetName()}")
        for i in range(loose_tree.GetEntries()):
            loose_tree.GetEntry(i)
            unique_id = getattr(loose_tree, "fUniqueID", None)
            if unique_id is not None:
                # If this event has "loose" objects, mark its ID
                loose_entries.add(unique_id)

    # 2) Collect unique IDs for TIGHT
    tight_entries = set()
    if tight_branches:
        tight_tree = input_file.Get("Delphes")
        tight_tree.SetBranchStatus("*", 0)
        for tb in tight_branches:
            if tight_tree.GetBranch(tb):
                tight_tree.SetBranchStatus(tb, 1)
            else:
                print(f"Warning: Tight branch '{tb}' not found in {tight_tree.GetName()}")
        for i in range(tight_tree.GetEntries()):
            tight_tree.GetEntry(i)
            unique_id = getattr(tight_tree, "fUniqueID", None)
            if unique_id is not None:
                # If this event has "tight" objects, mark its ID
                tight_entries.add(unique_id)

    # 3) Loop over events in the main tree and set flags
    for entry in range(delphes_tree.GetEntries()):
        delphes_tree.GetEntry(entry)

        event_id[0] = entry

        unique_id = getattr(delphes_tree, "fUniqueID", None)
        is_loose[0] = 1 if (unique_id in loose_entries) else 0
        is_tight[0] = 1 if (unique_id in tight_entries) else 0

        new_tree.Fill()

    return new_tree

def process_branches(
    input_file,
    output_file,
    branches_to_copy,
    loose_branches=None,
    tight_branches=None,
    branch_prefix="",
    output_tree_name="Delphes"
):
    delphes_tree = input_file.Get("Delphes")
    if not delphes_tree:
        print("Error: 'Delphes' tree not found in input file.")
        return

    output_file.cd()
    new_tree = copy_selected_branches_with_flags(
        delphes_tree,
        branches=branches_to_copy,
        loose_branches=loose_branches,
        tight_branches=tight_branches,
        branch_prefix=branch_prefix
    )
    new_tree.SetName(output_tree_name)
    new_tree.Write()
    print(f"Tree '{output_tree_name}' successfully written to output file.")

# Define branch lists for non-L1T and L1T
non_l1t_branches = [
    "EFlowTrack.PT", "EFlowTrack.Eta", "EFlowTrack.Phi", "EFlowTrack.PID",
    "EFlowTrack.Charge", "EFlowTrack.Mass", "EFlowTrack.D0", "EFlowTrack.DZ",
    "EFlowTrack.ErrorD0", "EFlowTrack.ErrorDZ",
    "EFlow.PuppiW", "EFlow.Charge",
    "PhotonLoose.PT", "PhotonLoose.Eta", "PhotonLoose.Phi",
    "PhotonLoose.E", "PhotonLoose.EhadOverEem",
    "PhotonLoose.IsolationVarRhoCorr",
    "PhotonTight.PT", "PhotonTight.Eta", "PhotonTight.Phi",
    "PhotonTight.E", "PhotonTight.EhadOverEem",
    "PhotonTight.IsolationVarRhoCorr",
    "EFlowNeutralHadron.ET", "EFlowNeutralHadron.Eta", "EFlowNeutralHadron.Phi", 
    "EFlowNeutralHadron.E", "EFlowNeutralHadron.Eem", 
    "EFlowNeutralHadron.Ehad",
    "Electron.PT", "Electron.Eta", "Electron.Phi", "Electron.EhadOverEem",
    "Electron.IsolationVarRhoCorr", "Electron.D0", "Electron.DZ",
    "Electron.ErrorD0", "Electron.ErrorDZ",
    "MuonLoose.PT", "MuonLoose.Eta", "MuonLoose.Phi", "MuonLoose.IsolationVarRhoCorr", 
    "MuonLoose.D0", "MuonLoose.DZ", "MuonLoose.ErrorD0", "MuonLoose.ErrorDZ",
    "MuonTight.PT", "MuonTight.Eta", "MuonTight.Phi", "MuonTight.IsolationVarRhoCorr", 
    "MuonTight.D0", "MuonTight.DZ", "MuonTight.ErrorD0", "MuonTight.ErrorDZ",
    "Jet.PT", "Jet.Eta", "Jet.Phi", "Jet.Mass", "Jet.Constituents", 
    "JetAK8.PT", "JetAK8.Eta", "JetAK8.Phi", "JetAK8.Mass", "JetAK8.Constituents",
    "MissingET.MET", "MissingET.Phi", 
    "Particle.PT", "Particle.Eta", "Particle.Phi", "Particle.Mass", 
    "Particle.M1", "Particle.M2", "Particle.D1", "Particle.D2", 
    "GenJet.PT", "GenJet.Eta", "GenJet.Phi", "GenJet.Mass", 
    "GenJetAK8.PT", "GenJetAK8.Eta", "GenJetAK8.Phi", "GenJetAK8.Mass"
]

l1t_branches = [
    "L1TEFlowTrack.PT", "L1TEFlowTrack.Eta", "L1TEFlowTrack.Phi",
    "L1TEFlowTrack.PID", "L1TEFlowTrack.Charge", "L1TEFlowTrack.Mass",
    "L1TEFlow.PT", "L1TEFlow.Eta", "L1TEFlow.Phi", "L1TEFlow.PuppiW",
    "L1TPhotonLoose.PT", "L1TPhotonLoose.Eta", "L1TPhotonLoose.Phi",
    "L1TPhotonLoose.E", "L1TPhotonLoose.EhadOverEem",
    "L1TPhotonLoose.IsolationVarRhoCorr",
    "L1TPhotonTight.PT", "L1TPhotonTight.Eta", "L1TPhotonTight.Phi",
    "L1TPhotonTight.E", "L1TPhotonTight.EhadOverEem",
    "L1TPhotonTight.IsolationVarRhoCorr",
    "L1TEFlowNeutralHadron.ET", "L1TEFlowNeutralHadron.Eta", "L1TEFlowNeutralHadron.Phi", 
    "L1TEFlowNeutralHadron.E", "L1TEFlowNeutralHadron.Eem", 
    "L1TEFlowNeutralHadron.Ehad",
    "L1TElectron.PT", "L1TElectron.Eta", "L1TElectron.Phi", "L1TElectron.EhadOverEem",
    "L1TElectron.IsolationVarRhoCorr", "L1TElectron.D0", "L1TElectron.DZ",
    "L1TMuonLoose.PT", "L1TMuonLoose.Eta", "L1TMuonLoose.Phi", "L1TMuonLoose.IsolationVarRhoCorr", 
    "L1TMuonLoose.D0", "L1TMuonLoose.DZ", "L1TMuonLoose.ErrorD0", "L1TMuonLoose.ErrorDZ",
    "L1TMuonTight.PT", "L1TMuonTight.Eta", "L1TMuonTight.Phi", "L1TMuonTight.IsolationVarRhoCorr", 
    "L1TMuonTight.D0", "L1TMuonTight.DZ", "L1TMuonTight.ErrorD0", "L1TMuonTight.ErrorDZ",
    "L1TElectron.ErrorD0", "L1TElectron.ErrorDZ",
    "L1TJet.PT", "L1TJet.Eta", "L1TJet.Phi", "L1TJet.Mass", "L1TJet.Constituents", 
    "L1TJetAK8.PT", "L1TJetAK8.Eta", "L1TJetAK8.Phi", "L1TJetAK8.Mass", "L1TJetAK8.Constituents",
    "L1TMissingET.MET", "L1TMissingET.Phi",
]

#input_file = ROOT.TFile.Open("/afs/cern.ch/user/e/emoreno/foundation/simulation/test_root/event.root")
#output_file = ROOT.TFile("output_file_with_flags.root", "RECREATE")
input_file  = ROOT.TFile.Open(args.input)
output_file = ROOT.TFile(args.output, "RECREATE")

# For FullReco:
# Suppose we want to check Loose photons & muons and Tight photons & muons.
process_branches(
    input_file,
    output_file,
    non_l1t_branches,
    loose_branches=["PhotonLoose.PT", "MuonLoose.PT"],  # <--- add more as needed
    tight_branches=["PhotonTight.PT", "MuonTight.PT"], # <--- add more as needed
    branch_prefix="",
    output_tree_name="FullReco"
)

# For L1T:
# Similarly, use L1T loose/tight branches
process_branches(
    input_file,
    output_file,
    l1t_branches,
    loose_branches=["L1TPhotonLoose.PT", "L1TMuonLoose.PT"],  # If you have them
    tight_branches=["L1TPhotonTight.PT", "L1TMuonTight.PT"], # If you have them
    branch_prefix="",
    output_tree_name="L1T"
)

input_file.Close()
output_file.Close()