<!-- @format -->

# System Architecture

## Overview

The OAJ Solar Finder System (SFS) is designed as a modular accessory system.

The objective is to separate telescope-specific components from the universal finder body.

---

## High Level Architecture

```text
                   Rear Plate
                        ▲
                        │
                 Slides into
                        │
        ┌────────────────────────┐
        │                        │
        │      Main Body         │
        │                        │
        └────────────┬───────────┘
                     │
           Universal Interface
                     │
        ┌────────────┴───────────┐
        │                        │
        │    Telescope Adapter   │
        │                        │
        └────────────┬───────────┘
                     │
             Telescope Finder Shoe
```

---

## Core Principles

- Modular
- Easy to print
- Replaceable components
- Universal interface
- Low cost
- Beginner friendly

---

## Current Status

Architecture Design
