<!-- @format -->

# Design Decisions

This document records the major architectural decisions made during the development of the OAJ Solar Finder System.

---

## DD-001

### Decision

Use a modular adapter system instead of making the telescope foot part of the main body.

### Reason

- Supports multiple telescope brands.
- Reduces waste.
- Only the adapter needs replacing when changing telescopes.
- Cheaper to manufacture and ship.
- Easier to improve individual adapters.
- Allows future accessories to use the same interface.

### Status

Approved

---

## DD-002

### Decision

Use a captured sliding dovetail with 0.25 mm clearance per side for the universal adapter interface.

### Reason

- The body cannot lift away from the adapter during use.
- The adapter prints without support.
- Fit can be tuned with one parameter after P1 testing.
- A positive front stop makes insertion repeatable.

### Status

Approved for P1

---

## DD-003

### Decision

Use separate removable pinhole and target plates, with six rigid target positions from 45 mm to 70 mm.

### Reason

- Plates can print flat for cleaner apertures and markings.
- Damaged plates can be replaced without reprinting the body.
- Multiple distances allow the first sunlight test to identify the clearest spot.
- Rigid slots are simpler and safer to validate than a folding mechanism.

### Status

Approved for P1
