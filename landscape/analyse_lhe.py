"""
Parton-level summary of an LHE written by landscape/lhe.py.

    python3 -m landscape.analyse_lhe file.lhe [file2.lhe ...]

This is the level the paper's figures are at -- multiplicity and flavour of the
decay products *before* showering -- so it is the right place to compare with
them, and the right place to check closure: for the Higgs modes the final
partons must reconstruct 125.11 GeV, which tests the whole chain from the
cascade through the boosts to the file format in one number.

Everything here reads the file, not the generator, so it also serves as an
independent check that what was written is what was meant.
"""

import math
import sys
from collections import Counter

from . import lhe as LHE

NAMES = {5: "b", 4: "c", 15: "tau", 3: "s", 13: "mu", 11: "e", 6: "t",
         24: "W", 23: "Z", 211: "pi+-", 111: "pi0", 22: "gamma", 21: "gluon",
         25: "higgs"}


def vertices(parts):
    """Production vertex of every particle, in mm, by walking VTIMUP down."""
    vtx = {i: (0.0, 0.0, 0.0) for i in range(1, len(parts) + 1)}
    for i, p in enumerate(parts, 1):
        if p.status != 2:
            continue
        x, y, z = vtx[i]
        f = p.vtim / p.m if p.m > 0 else 0.0
        end = (x + p.px * f, y + p.py * f, z + p.pz * f)
        for j, q in enumerate(parts, 1):
            if q.mother1 == i and q.status != -1:
                vtx[j] = end
    return vtx


def summarise(path):
    mult, energies, rxy, mroot, ptroot = [], [], [], [], []
    flav = Counter()
    nev = 0
    for parts in LHE.read_lhe(path):
        nev += 1
        vtx = vertices(parts)
        e = px = py = pz = 0.0
        n = 0
        for i, p in enumerate(parts, 1):
            if p.status != 1:
                continue
            n += 1
            e += p.e
            px += p.px
            py += p.py
            pz += p.pz
            energies.append(p.e)
            flav[NAMES.get(abs(p.pdg), str(p.pdg))] += 1
            x, y, _ = vtx[i]
            rxy.append(math.hypot(x, y))
        mult.append(n)
        m2 = e * e - px * px - py * py - pz * pz
        mroot.append(math.sqrt(m2) if m2 > 0 else 0.0)
        ptroot.append(math.hypot(px, py))
    return {"path": path, "nev": nev, "mult": mult, "energies": energies,
            "rxy": rxy, "mroot": mroot, "ptroot": ptroot, "flav": flav}


def q(v, f):
    if not v:
        return 0.0
    s = sorted(v)
    return s[min(len(s) - 1, int(f * len(s)))]


def report(s):
    print("\n=== {0} ({1} events) ===".format(s["path"], s["nev"]))
    print("  {0:<30}{1:>9}{2:>9}{3:>9}{4:>9}".format(
        "", "mean", "median", "90%", "max"))
    for name, v in (("parton multiplicity", s["mult"]),
                    ("parton energy [GeV]", s["energies"]),
                    ("parton r_xy [mm]", s["rxy"])):
        print("  {0:<30}{1:>9.2f}{2:>9.2f}{3:>9.2f}{4:>9.2f}".format(
            name, sum(v) / len(v) if v else 0, q(v, 0.5), q(v, 0.9), max(v) if v else 0))

    mr = s["mroot"]
    print("  invariant mass of all partons: mean {0:.4f} GeV, spread "
          "{1:.2e} GeV".format(sum(mr) / len(mr), max(mr) - min(mr)))
    print("  net pT of all partons (must be 0 at LHE level): max {0:.2e} GeV"
          .format(max(s["ptroot"])))

    tot = sum(s["flav"].values())
    frac = ", ".join("{0} {1:.1%}".format(k, v / tot)
                     for k, v in s["flav"].most_common())
    print("  flavour: " + frac)
    disp = sum(1 for r in s["rxy"] if r > 0.1) / len(s["rxy"])
    print("  partons with r_xy > 0.1 mm: {0:.1%}".format(disp))


def main(argv=None):
    argv = argv or sys.argv[1:]
    if not argv:
        print(__doc__)
        return 1
    for path in argv:
        report(summarise(path))
    return 0


if __name__ == "__main__":
    sys.exit(main())
