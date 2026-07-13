/*
========================================================
OUR ASTRO JOURNEY
Modular Solar Finder System

Prototype: P1
Year: 2026

Purpose:
- Interchangeable telescope adapters
- Removable target plate
- Fixed front pinhole plate
- Multiple target-distance positions
========================================================
*/

$fn = 48;


// ======================================================
// PRINT SETTINGS
// ======================================================

// General clearance between separately printed parts.
// Increase to 0.30 or 0.35 if the print service produces tight fits.
fit_clearance = 0.25;


// ======================================================
// UNIVERSAL ADAPTER INTERFACE
// ======================================================

// These dimensions must remain consistent across every
// future telescope adapter.

adapter_tongue_length = 22;
adapter_tongue_top_width = 16;
adapter_tongue_bottom_width = 20;
adapter_tongue_height = 4.5;

adapter_stop_thickness = 2;


// ======================================================
// SOLAR FINDER BODY
// ======================================================

body_length = 90;
body_width = 30;
body_thickness = 4;


// Front plate
front_plate_width = 34;
front_plate_height = 38;
front_plate_thickness = 3;

pinhole_diameter = 0.7;


// Rear target plate
rear_plate_width = 34;
rear_plate_height = 38;
rear_plate_thickness = 3;


// Target distances measured from the front plate
target_positions = [45, 50, 55, 60, 65, 70];


// Rear plate locating tab
target_tab_width = 18;
target_tab_length = 5;
target_tab_depth = 3;


// ======================================================
// NACATIN ADAPTER MEASUREMENTS
// ======================================================

// Measurements taken from the original finder foot.
nacatin_foot_length = 39.3;
nacatin_foot_top_width = 23.8;
nacatin_foot_bottom_width_front = 28.4;
nacatin_foot_bottom_width_rear = 29.5;

// Height is currently estimated from the photographs.
// It remains adjustable for the first prototype.
nacatin_foot_height = 5.5;


// Original telescope shoe measurements
nacatin_socket_top_width = 24.3;
nacatin_socket_bottom_width = 30.1;
nacatin_socket_length = 39.8;
nacatin_socket_depth = 10.1;


// Locating notch
nacatin_notch_width = 14.9;
nacatin_notch_length = 4.2;
nacatin_notch_depth = 3.5;


// ======================================================
// UNIVERSAL MALE ADAPTER TONGUE
// ======================================================

module adapter_tongue() {

    linear_extrude(height = adapter_tongue_length)
        polygon([
            [-adapter_tongue_top_width / 2, 0],
            [ adapter_tongue_top_width / 2, 0],
            [ adapter_tongue_bottom_width / 2, -adapter_tongue_height],
            [-adapter_tongue_bottom_width / 2, -adapter_tongue_height]
        ]);

    // End stop prevents the adapter sliding too far
    translate([
        -adapter_tongue_bottom_width / 2,
        -adapter_tongue_height,
        adapter_tongue_length
    ])
        cube([
            adapter_tongue_bottom_width,
            adapter_tongue_height,
            adapter_stop_thickness
        ]);
}


// ======================================================
// PREVIEW
// ======================================================

// For now, show only the universal adapter tongue.
// Later this becomes part of the Nacatin adapter.

adapter_tongue();