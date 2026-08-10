# RPVMSSM_UFO_Wn1

`RPVMSSM_UFO` as shipped in the mapyde container
(`/usr/local/MG5_aMC_v3_5_8/models/RPVMSSM_UFO`), with **one** change: the
lightest neutralino is given a settable width.

## Why

Stock `RPVMSSM_UFO` declares

```python
n1 = Particle(pdg_code = 1000022,
              ...
              width = Param.ZERO,
```

`Param.ZERO` is a model constant, not a param-card input. MG5's
`models/check_param_card.py::check_and_update` (the "Update the dependent
parameter of the param_card" step) therefore overwrites whatever the card asks
for with the model value, and logs

```
WARNING: For consistency, the width of particle 1000022 (n1) is changed to 0.0.
```

so `set param_card decay 1000022 <x>` in a `customizecards.dat` is a **silent
no-op**.

A zero width is right for the R-parity-*conserving* MSSM, where the lightest
neutralino is the stable LSP. It is wrong for this model: in RPV the neutralino
decays through lambda'', and every AIDA-Scout RPV point that puts `n1` in a
decay chain needs it to have a width.

Two things break without this patch:

1. **Event generation.** With `Gamma(n1) = 0` the `n1` propagator in a decay
   chain such as `p p > ur ur~, (ur > u n1, n1 > u d s)` has an unregulated
   pole. The integration does not converge -- measured on
   `RPV_squark120_cascade_LSP90`, MG5 reports
   `cross-section: 9.73e-09 +- 860.89` (the error is eleven orders of magnitude
   above the central value) and unweighting yields **9 events out of 5000
   requested**. `RPV_squark600_cascade_LSP550` gave 11 of 5000. This is the
   non-monotonic-cross-section artifact already noted in
   `processes/README_signals.md`, but it costs the events, not just the
   normalisation.
2. **Lifetimes.** `RPV_ewkino150_UDD_ctau10mm` sets its 10 mm proper lifetime
   as `set param_card decay 1000022 1.9730e-14` (Gamma = hbar c / ctau). That
   is exactly the value being discarded, so the point came out prompt.

## The patch

`particles.py`

```python
-              width = Param.ZERO,
+              width = Param.Wneu1,
```

`parameters.py` -- add, immediately before the existing `Wch1` declaration and
mirroring it:

```python
Wneu1 = Parameter(name = 'Wneu1',
                 nature = 'external',
                 type = 'real',
                 value = 0.0,
                 texname = '\\text{Wneu1}',
                 lhablock = 'DECAY',
                 lhacode = [ 1000022 ])
```

The default stays `0.0`, so any process that does not set the width explicitly
behaves exactly as it did with the stock model.

## Regenerating / verifying

```bash
img=/cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest
apptainer exec $img diff -rq \
    /usr/local/MG5_aMC_v3_5_8/models/RPVMSSM_UFO \
    models/RPVMSSM_UFO_Wn1
```

Only `particles.py` and `parameters.py` should differ.

## Checking it took effect

After `madevent` runs, `tmpdir/Cards/param_card.dat` should read

```
DECAY 1000022 1.000000e-01 # wneu1
```

and **not**

```
DECAY 1000022 0.000000e+00 # n1 : 0.0
```
