"""
Les Houches event output, for Pythia to shower and hadronize.

Two things here are easy to get wrong and both change the physics.

**Colour flow must be local to each decay.**  Every phi -> q qbar is a colour
singlet, so its colour line belongs to that decay and nothing else.  Connecting
colour across the cascade -- for instance giving every quark in the event tags
from one running counter that happens to pair them up across different parents
-- builds strings spanning the whole event and materially changes the hadronic
activity.  Each decay here gets a fresh pair of tags, and
``check_colour_flow`` asserts that every tag is used exactly twice, once as a
colour and once as an anticolour.

**The hidden scalars have to be in the record.**  A flat list of partons cannot
be displaced: LHE carries no production vertex, only VTIMUP, the proper decay
length of a particle that has daughters.  At the shipped benchmark the scalars
below 2*min(spectrum) have ctau of order 1 mm and every cascade terminates on
one of them, so most visible particles come from a displaced vertex (see
lifetimes.py).  Writing only the final partons would silently make the whole
sample prompt.  So intermediate scalars are written with ISTUP = 2 and their
sampled proper length in VTIMUP.

All hidden scalars share one PDG id and carry their individual mass in the
record, which avoids defining 200 particles in Pythia.  ``pythia_fragment``
emits the matching declaration.
"""

import math

from .cascade import iter_nodes, COLOURED

# One id for every hidden scalar; the mass is per particle in the record.
# 9000006 is in the range PDG reserves for generator-specific states.
BSM_SCALAR_ID = 9000006

# LHE colour tags conventionally start at 501.
FIRST_COLOUR_TAG = 501


class LheParticle(object):
    __slots__ = ("pdg", "status", "mother1", "mother2", "col", "acol",
                 "px", "py", "pz", "e", "m", "vtim", "spin")

    def __init__(self, pdg, status, mother1, mother2, col, acol,
                 px, py, pz, e, m, vtim=0.0, spin=9.0):
        self.pdg = pdg
        self.status = status
        self.mother1 = mother1
        self.mother2 = mother2
        self.col = col
        self.acol = acol
        self.px = px
        self.py = py
        self.pz = pz
        self.e = e
        self.m = m
        self.vtim = vtim
        self.spin = spin

    def line(self):
        return ("{0:9d} {1:5d} {2:5d} {3:5d} {4:5d} {5:5d} "
                "{6:+.10e} {7:+.10e} {8:+.10e} {9:.10e} {10:.10e} "
                "{11:.4e} {12:.1f}").format(
            self.pdg, self.status, self.mother1, self.mother2,
            self.col, self.acol, self.px, self.py, self.pz, self.e, self.m,
            self.vtim, self.spin)


class ColourCounter(object):
    """Hands out fresh colour tags, one decay at a time."""

    def __init__(self, start=FIRST_COLOUR_TAG):
        self._next = start

    def take(self):
        c = self._next
        self._next += 1
        return c


def build_event(root, g1, g2, colours=None, scalar_id=BSM_SCALAR_ID):
    """
    Turn one kinematics-assigned decay tree into a list of LheParticle.

    ``g1`` / ``g2`` are the incoming gluon four-vectors from
    hardprocess.initial_state.  The tree must already have been through
    kinematics.assign_kinematics; if you want displaced vertices it must also
    have been through lifetimes.assign_proper_times.

    Indices in the returned list are 1-based when referred to by mother1 /
    mother2, matching the LHE convention.
    """
    if colours is None:
        colours = ColourCounter()

    # the incoming pair is a colour singlet: a closed loop between them
    c1 = colours.take()
    c2 = colours.take()
    parts = [
        LheParticle(21, -1, 0, 0, c1, c2, g1.px, g1.py, g1.pz, g1.e, 0.0),
        LheParticle(21, -1, 0, 0, c2, c1, g2.px, g2.py, g2.pz, g2.e, 0.0),
    ]

    index = {}

    def emit(node, mother1, mother2, col, acol):
        p4 = node.p4
        if p4 is None:
            raise ValueError("node has no four-vector; run assign_kinematics")
        if node.children:
            status = 2
            pdg = node.pdg if node.pdg is not None else scalar_id
            vtim = node.tau_mm if node.tau_mm is not None else 0.0
            if vtim == math.inf:
                raise ValueError("node has infinite lifetime; cannot write it "
                                 "as a decaying resonance")
        else:
            status = 1
            pdg = node.pdg
            vtim = 0.0
            if pdg is None:
                raise ValueError(
                    "undecayed hidden scalar of mass {0} reached the final "
                    "state; it has no PDG code".format(node.mass))
        parts.append(LheParticle(pdg, status, mother1, mother2, col, acol,
                                 p4.px, p4.py, p4.pz, p4.e, node.mass, vtim))
        index[id(node)] = len(parts)
        return len(parts)

    emit(root, 1, 2, 0, 0)

    for node in iter_nodes(root):
        if not node.children:
            continue
        me = index[id(node)]
        a, b = node.children
        if a.species is not None and a.species in COLOURED:
            if a.species == "gluon":
                # closed gluon loop, local to this decay
                t1 = colours.take()
                t2 = colours.take()
                emit(a, me, me, t1, t2)
                emit(b, me, me, t2, t1)
            else:
                # q qbar singlet: one fresh line shared by the pair only
                t = colours.take()
                emit(a, me, me, t, 0)
                emit(b, me, me, 0, t)
        else:
            emit(a, me, me, 0, 0)
            emit(b, me, me, 0, 0)

    return parts


def check_colour_flow(parts):
    """
    Every colour tag must appear exactly twice: once as a colour and once as an
    anticolour.  Returns a list of complaints, empty if the flow is consistent.

    This is the check that would catch colour lines leaking across the cascade,
    which is the failure mode that quietly changes the hadronic activity.
    """
    seen = {}
    for i, p in enumerate(parts, 1):
        for tag, which in ((p.col, "col"), (p.acol, "acol")):
            if tag:
                seen.setdefault(tag, []).append((i, which))
    bad = []
    for tag, uses in sorted(seen.items()):
        if len(uses) != 2:
            bad.append("tag {0} used {1} times: {2}".format(
                tag, len(uses), uses))
            continue
        kinds = sorted(w for _, w in uses)
        if kinds != ["acol", "col"]:
            bad.append("tag {0} used as {1}".format(tag, kinds))
    return bad


def check_momentum(parts, tol=1e-6):
    """
    Incoming momentum must equal the sum over final-state (status 1) particles.

    Returns the worst absolute residual in GeV.  Intermediate resonances are
    skipped: counting them as well would double count.
    """
    inc = [0.0] * 4
    out = [0.0] * 4
    for p in parts:
        tgt = inc if p.status == -1 else (out if p.status == 1 else None)
        if tgt is None:
            continue
        tgt[0] += p.e
        tgt[1] += p.px
        tgt[2] += p.py
        tgt[3] += p.pz
    return max(abs(a - b) for a, b in zip(inc, out))


def format_event(parts, weight=1.0, scale=0.0, alpha_qed=-1.0, alpha_qcd=-1.0,
                 process_id=1):
    lines = ["<event>",
             "{0:5d} {1:5d} {2:+.10e} {3:.10e} {4:.10e} {5:.10e}".format(
                 len(parts), process_id, weight, scale, alpha_qed, alpha_qcd)]
    lines.extend(p.line() for p in parts)
    lines.append("</event>")
    return "\n".join(lines)


def format_header(cross_section_pb, cross_section_err_pb=0.0, sqrt_s=14000.0,
                  comments=(), process_id=1):
    """
    LHE preamble and <init> block.

    IDWTUP = 3: unweighted events of weight +1, with the cross section carried
    by XSECUP.  Beam PDF ids are written as 0 because the events are not
    reweightable -- Pythia is told the PDF separately in the fragment.
    """
    e_beam = 0.5 * sqrt_s
    out = ["<LesHouchesEvents version=\"3.0\">", "<header>"]
    out.extend("  " + c for c in comments)
    out.append("</header>")
    out.append("<init>")
    out.append("{0:9d} {1:9d} {2:.8e} {3:.8e} {4:5d} {5:5d} {6:5d} {7:5d} "
               "{8:5d} {9:5d}".format(2212, 2212, e_beam, e_beam,
                                      0, 0, 0, 0, 3, 1))
    out.append("{0:.8e} {1:.8e} {2:.8e} {3:5d}".format(
        cross_section_pb, cross_section_err_pb, 1.0, process_id))
    out.append("</init>")
    return "\n".join(out)


def pythia_fragment(scalar_id=BSM_SCALAR_ID, m_nominal=5.0,
                    m_min=0.05, m_max=1000.0):
    """
    The Pythia settings an LHE written here needs.

    The hidden scalar is declared once with a wide allowed mass range, because
    every scalar in the spectrum shares the id and supplies its own mass in the
    record.  mayDecay is off: the cascade is already fully decayed in the file,
    and Pythia must not decay these again.
    """
    return "\n".join([
        "! Hidden landscape scalar: one id for the whole spectrum, mass and",
        "! proper lifetime supplied per particle by the LHE record.",
        "{0}:new = phi phi 1 0 0 {1} 0.0 {2} {3}".format(
            scalar_id, m_nominal, m_min, m_max),
        "{0}:mayDecay = off".format(scalar_id),
        "{0}:isResonance = false".format(scalar_id),
        "",
        "Beams:frameType = 4",
        "",
        "! THIS ONE MATTERS.  setLifetime = 1 (Pythia's default) takes the",
        "! decay times from VTIMUP, which is where this sample's displacement",
        "! lives; setLifetime = 2 discards them and every hidden-scalar decay",
        "! vertex collapses to the origin, silently making the sample prompt.",
        "! Set explicitly rather than relied on.",
        "LesHouches:setLifetime = 1",
        "",
        "! The cascade is decayed in the LHE; let long-lived hadrons decay too.",
        "ParticleDecays:limitTau0 = off",
    ])


def write_lhe(path, events, cross_section_pb, cross_section_err_pb=0.0,
              sqrt_s=14000.0, comments=()):
    """
    ``events`` is an iterable of particle lists from build_event.

    Returns the number of events written.
    """
    n = 0
    with open(path, "w") as fh:
        fh.write(format_header(cross_section_pb, cross_section_err_pb,
                               sqrt_s, comments))
        fh.write("\n")
        for parts in events:
            fh.write(format_event(parts))
            fh.write("\n")
            n += 1
        fh.write("</LesHouchesEvents>\n")
    return n


def read_lhe(path):
    """Minimal reader, for tests: yields lists of LheParticle."""
    parts = None
    with open(path) as fh:
        for line in fh:
            s = line.strip()
            if s == "<event>":
                parts = []
                header = True
                continue
            if s == "</event>":
                yield parts
                parts = None
                continue
            if parts is None:
                continue
            if header:
                header = False
                continue
            f = s.split()
            if len(f) < 13:
                continue
            parts.append(LheParticle(
                int(f[0]), int(f[1]), int(f[2]), int(f[3]), int(f[4]),
                int(f[5]), float(f[6]), float(f[7]), float(f[8]),
                float(f[9]), float(f[10]), float(f[11]), float(f[12])))
