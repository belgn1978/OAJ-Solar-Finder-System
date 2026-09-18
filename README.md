# OAJ Solar Finder System

A modular, 3D-printable projection finder for safely aligning a filtered telescope with the Sun. The telescope-specific foot is separated from the universal finder body, so future adapters can reuse the same optical assembly.

## Prototype P1

P1 is ready for its first fit and sunlight test. The printable set contains:

- `OAJ_SFS_P1_body.stl` — universal 90 mm finder body
- `OAJ_SFS_P1_nacatin_adapter.stl` — adapter for the measured Nacatin 90/800 finder shoe
- `OAJ_SFS_P1_pinhole_plate.stl` — removable front plate with a 0.8 mm pilot aperture
- `OAJ_SFS_P1_target_plate.stl` — pale rear target with recessed crosshair

The source is fully parametric in `openscad/solar_finder.scad`. Select a component with the `part` variable or run `scripts/export_stls.sh` to rebuild the complete STL set.

## How it works

Sunlight passes through the small front aperture and projects a spot onto the rear target. Centre the spot on the recessed crosshair to align the telescope. Six target positions provide pinhole-to-target distances from 45 mm to 70 mm.

## Important safety warning

This finder is a pointing aid only. It is **not** an eye-safe solar filter.

- Never look through the pinhole.
- Never look through an unfiltered telescope or finder.
- Fit a secure, certified full-aperture solar filter to the telescope before pointing it toward the Sun.
- Inspect the filter and its retention before every session.
- Supervise children continuously.

## Prototype status

The universal parts are dimensionally complete and their STL meshes have been checked as closed/manifold. The Nacatin foot is based on supplied measurements; its 5.5 mm height was estimated from photographs and must be verified by the first fit test.

See [`docs/P1_PRINT_AND_TEST_GUIDE.md`](docs/P1_PRINT_AND_TEST_GUIDE.md) before ordering or using the prototype.

