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
