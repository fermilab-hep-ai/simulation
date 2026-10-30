"""
Constants and benchmark definitions for the landscape scalar-cascade model.

Ported from the authors' Julia code (scalarattributesshare.jl,
ScalarProductionshare.jl, ScalarScanningshare.jl).

In the Julia these are module-level globals read implicitly inside the width
functions.  Here they live in a frozen dataclass that is passed explicitly, so
a benchmark cannot silently pick up a stale value.  The numeric values are
reproduced exactly, including the places where the code is internally
inconsistent -- see the notes on ``G_F`` below.
"""

from dataclasses import dataclass, replace


@dataclass(frozen=True)
class SMConstants:
    """Standard Model inputs, GeV.  Values from ScalarScanningshare.jl."""

    m_h: float = 125.11
    m_b: float = 4.18
    m_tau: float = 1.78
    m_charm: float = 1.28
    m_strange: float = 0.096
    m_muon: float = 0.10566
    m_electron: float = 0.000511
    m_W: float = 80.37
    m_Z: float = 91.19
    m_top: float = 172.57
    vev: float = 246.0

    # The Julia calls these m_u and m_d, but the values are pion masses:
    #   m_u = 0.134 is the pi0 mass and feeds the channel carrying the isospin
    #         factor 2, which the driver's legend labels pi+ pi-;
    #   m_d = 0.139 is the pi+- mass and feeds the factor-1 channel labelled
    #         pi0 pi0.
    # The labelling is inverted but the isospin factors are correct and the
    # numerical effect is negligible.  Renamed here for clarity; the VALUES are
    # deliberately NOT swapped, since that would change the numbers.
    # (instructions section 7e)
    m_pi0: float = 0.134    # Julia m_u, carries the isospin factor 2
    m_pipm: float = 0.139   # Julia m_d, carries factor 1

    # Fermi constant.  The Julia uses TWO slightly different values:
    #   DecaytoPhotons  -> 1.1664e-5
    #   Gamma_bb        -> 1.166e-5   (in every production function)
    # a 0.03% inconsistency.  Both are reproduced as written rather than
    # unified, so the port matches the original bit for bit.
    G_F_photons: float = 1.1664e-5
    G_F_gammabb: float = 1.166e-5

    alpha_em_inv: float = 137.0   # the Julia writes (1/137)
    alpha_s: float = 0.44         # fixed, used in DecaytoGluons

    @property
    def y_b(self):
        return self.m_b / self.vev

    @property
    def y_c(self):
        return self.m_charm / self.vev

    @property
    def y_tau(self):
        return self.m_tau / self.vev

    @property
    def y_s(self):
        return self.m_strange / self.vev

    @property
    def y_muon(self):
        return self.m_muon / self.vev

    @property
    def y_e(self):
        return self.m_electron / self.vev

    @property
    def y_t(self):
        return self.m_top / self.vev


@dataclass(frozen=True)
class ModelParams:
    """
    Landscape model parameters.

    Defaults are the shipped driver values from ScalarScanningshare.jl:
    N = 200, lambda = lambda' = 1e-4, M* = 10000 GeV, v2 = 0.9 v, spectrum
    uniform on [10/sqrt(200), 10] = [0.7071, 10] GeV, L = 3000 /fb.
    """

    N: int = 200
    lam: float = 1e-4          # Julia lambdaa
    lam_prime: float = 1e-4    # Julia lambdaaprime
    M_star: float = 10000.0    # Julia Mstarr
    vev_2: float = 0.9 * 246.0  # Julia vev_2
    mass_low: float = 10.0 / (200 ** 0.5)
    mass_high: float = 10.0
    luminosity_pb: float = 3000e15   # Julia luminosity = 3000 * 10^15

    # ---- switches for the deliberate deviations, instructions section 7 ----

    # (a) gamma/gluon conditional split.  "code" reproduces the authors'
    #     BR[l-1]/BR[l] form; "standard" uses BR[l-1]/(BR[l-1]+BR[l]).
    photon_gluon_split: str = "code"

    # (b) ZZ width uses m_W in the kinematic factor rather than m_Z.  Only
    #     matters for m_phi > 2 m_Z ~ 182 GeV.
    zz_uses_mW: bool = True

    # (f) mixing angle uses m_h^2 rather than |m_h^2 - m_phi^2|.
    mixing_mass_dependent: bool = False

    # (g) a fresh spectrum per event (the paper's marginalised mode) versus a
    #     single fixed realisation per sample.  Fixed is the default: we live in
    #     one vacuum, and marginalising smears out the structure an anomaly
    #     detector keys on.
    spectrum_per_event: bool = False

    def mixing(self, consts: SMConstants, m_phi=None) -> float:
        """
        Scalar-Higgs mixing angle.

            theta = lambda * M* * v2 / (sqrt(N) * m_h^2)

        Mass-independent as written in the Julia (the m_phi << m_h limit).
        With ``mixing_mass_dependent`` the denominator becomes
        |m_h^2 - m_phi^2|, which is the physically sensible form as m_phi
        approaches m_h.
        """
        denom = consts.m_h ** 2
        if self.mixing_mass_dependent:
            if m_phi is None:
                raise ValueError("m_phi required when mixing_mass_dependent")
            denom = abs(consts.m_h ** 2 - m_phi ** 2)
        return (self.lam * self.M_star * self.vev_2) / ((self.N ** 0.5) * denom)


# Two different Higgs cross sections appear in the Julia, in barns.
# ProductionProb uses 21.39e-12; Crosssections, ProductionProbjustHiggsDecay*
# and CrosssectionsjustHiggsDecay use 48.51e-12.  Exposed as named constants
# rather than literals so each call path can log which one it used.
# (instructions section 7c)
SIGMA_H_PRODUCTIONPROB = 21.39e-12   # barns
SIGMA_H_CROSSSECTIONS = 48.51e-12    # barns

# Direct-production normalisation above 18.1 GeV: sigma_s = C / m^2
C_DIRECT = 2.25 * 3.34754e-7

# Tabulated direct-production cross section, interpolated linearly below
# 18.1 GeV and extrapolated linearly outside the grid (Julia: Gridded(Linear())
# with extrapolate(..., Line())).  y is already scaled by 2.25 as in the Julia.
DIRECT_XSEC_X = [
    5.0456, 5.3263, 5.5929, 5.8316, 6.1263, 6.3790, 6.6456, 6.9123,
    7.1789, 7.4456, 7.7263, 8.0070, 8.3579, 8.6667, 9.0316, 9.3965,
    9.7053, 10.0702, 10.4351, 10.7860, 11.1228, 11.4596, 11.7544, 12.0632,
    12.3719, 12.7228, 13.0175, 13.3544, 13.6772, 14.0, 14.3368, 14.6456, 14.9263,
]
DIRECT_XSEC_Y = [2.25 * v for v in [
    6.6593, 6.4374, 6.2155, 6.0048, 5.7940, 5.5610, 5.3724, 5.1727,
    4.9509, 4.7512, 4.5626, 4.3851, 4.1965, 4.0856, 3.9857, 3.9525,
    4.1189, 4.1854, 4.1521, 4.0523, 3.9192, 3.7750, 3.6197, 3.4643,
    3.2979, 3.1204, 2.9762, 2.7987, 2.6434, 2.4992, 2.3661, 2.2330, 2.1331,
]]

# B-meson parameters used by the bmesondecay term.
M_BMESON = 5.27934
M_KAON = 0.493
BMESON_SUPPRESSION = 1e-3   # hard-coded factor applied in the production sum


DEFAULT_CONSTS = SMConstants()
DEFAULT_MODEL = ModelParams()


# ---------------------------------------------------------------------------
# Retuned lambda for the Higgs-decay benchmarks
# ---------------------------------------------------------------------------
#
# The shipped lambda = 1e-4 puts BR(h -> BSM) at 7.6e-5 and sigma x BR at
# 3.7e-3 pb, three orders of magnitude below the Higgs signal-strength bound.
# instructions section 10 asks for L-B with lambda retuned; Gamma(h -> phi phi)
# goes as lambda^2 and nothing else in the chain depends on lambda, so the
# retuning is a closed form -- see landscape/retune.py.
#
# 2.7e-3 puts the PHYSICAL BR(h -> BSM) at 0.0994, i.e. just under the 0.1
# bound, and sigma x BR at 2.70 pb.  It is deliberately expressed against the
# physical normalisation rather than the Julia's: the Julia divides by
# Gamma_bb(pole) * 1.89 = 8.13e-3 GeV against a true SM width of 4.1e-3, so
# tuning the Julia's number to 0.1 would land at a physical 0.17 -- over the
# bound (deviation 7d).  In the Julia's own normalisation this point reads
# 0.0557.
#
# lambda' is NOT scaled with it.  Every hidden-sector width carries lambda'^2
# and every SM width carries theta^2 ~ lambda^2, so raising lambda alone
# reweights hidden against SM -- but at the shipped point the hidden channels
# already carry at least 1 - 6.9e-8 of every above-threshold scalar's width,
# and a factor 729 in lambda^2 leaves them at 1 - 5.0e-5.  The largest change
# in hidden fraction anywhere in the spectrum is 5.0e-5, so the cascade --
# multiplicity and flavour composition -- is untouched: 400 cascades driven by
# the same uniform stream come out element-for-element identical.  retune.cascade_invariance measures
# this, and tests/test_tier8_retune.py asserts it.
#
# What the retuning DOES change is the lifetime.  Below the hidden-pair
# threshold a scalar has no hidden channel open, so its width is pure mixing
# and ctau goes as lambda^-2: the median sub-threshold ctau drops from 2.7 mm
# to 3.7 microns and the sample flips from displaced to prompt.  That is a real
# change in the signature, so the shipped-lambda Higgs point is kept as a
# benchmark of its own (L-B-displaced) rather than being replaced.
LAMBDA_RETUNED = 2.7e-3

# instructions section 10: L-C is "as L-B with lambda'/lambda ~ 1e-6".  Pinned
# to the ratio rather than to an absolute value so it tracks the retuning.
LAMBDA_PRIME_RATIO_CONTROL = 1e-6

# The spectrum realisation used by every benchmark unless stated otherwise.
# Fixed per sample, not redrawn per event -- deviation 7g.
DEFAULT_SPECTRUM_SEED = 424242

# L-D: the realisation-to-realisation systematic (instructions section 10).
LD_SPECTRUM_SEEDS = (515151, 606060, 717171)


#: name -> (ModelParams, production mode, spectrum seed)
BENCHMARKS = {
    # Shipped driver parameters as-is; direct production dominates the Higgs
    # channel by ~500 here, so this is the point that reproduces the authors'
    # result.  Softest final state of the set.
    "L-A": (ModelParams(), "direct", DEFAULT_SPECTRUM_SEED),

    # Headline: gg -> h -> phi_i phi_j with lambda retuned to the Higgs
    # signal-strength bound.  Prompt.
    "L-B": (replace(ModelParams(), lam=LAMBDA_RETUNED), "higgs",
            DEFAULT_SPECTRUM_SEED),

    # The same Higgs-decay topology at the SHIPPED lambda.  Rate is 730x lower,
    # but the sub-threshold scalars live 730x longer, so this is the displaced
    # member of the family -- a different signature, not a weaker L-B.
    "L-B-displaced": (ModelParams(), "higgs", DEFAULT_SPECTRUM_SEED),

    # Negative control: lambda'/lambda = 1e-6, so the scalars decay straight to
    # the SM in two-body final states and existing searches already cover it.
    # Same production and same rate as L-B; only the cascade differs.
    "L-C": (replace(ModelParams(), lam=LAMBDA_RETUNED,
                    lam_prime=LAMBDA_RETUNED * LAMBDA_PRIME_RATIO_CONTROL),
            "higgs", DEFAULT_SPECTRUM_SEED),
}

# L-D is L-B on independent landscape realisations.
for _i, _seed in enumerate(LD_SPECTRUM_SEEDS, start=1):
    BENCHMARKS["L-D{0}".format(_i)] = (
        replace(ModelParams(), lam=LAMBDA_RETUNED), "higgs", _seed)
del _i, _seed


def benchmark(name: str) -> ModelParams:
    """Benchmark parameters by name.  See BENCHMARKS for the full entry."""
    try:
        return BENCHMARKS[name][0]
    except KeyError:
        raise ValueError("unknown benchmark {0!r}; known: {1}".format(
            name, ", ".join(sorted(BENCHMARKS))))


def benchmark_entry(name: str):
    """(ModelParams, production mode, spectrum seed) for one benchmark."""
    try:
        return BENCHMARKS[name]
    except KeyError:
        raise ValueError("unknown benchmark {0!r}; known: {1}".format(
            name, ", ".join(sorted(BENCHMARKS))))
