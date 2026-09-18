<!-- @format -->

# Adapter Design

## Purpose

The adapter connects the solar finder to a specific telescope.

Only the adapter changes between telescope models.

The rest of the system remains identical.

---

## Supported Telescopes

- Nacatin 90/800 (Current)
- Sky-Watcher (Future)
- Celestron (Future)
- SVBONY (Future)

---

## Current Measurements

### Nacatin Finder Foot

Length: 39.3 mm

Top Width: 23.8 mm

Bottom Width:
28.4 mm front
29.5 mm rear

Approx Height:
5.5 mm

Rear Notch

Width: 14.9 mm

Length: 4.2 mm

Depth: 3.5 mm

---

## Prototype geometry

The P1 adapter reproduces the measured tapered foot and rear locating notch. A short pedestal carries the universal captured-dovetail tongue above the telescope shoe.

The estimated 5.5 mm foot height is deliberately isolated in the parametric OpenSCAD source so it can be corrected after the first fit test without redesigning the universal body.

## Status

P1 STL generated; physical fit validation pending.
