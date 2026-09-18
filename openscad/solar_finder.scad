/*
  OAJ Solar Finder System — Prototype P1

  Projection finder for solar alignment. It does not contain a lens and must
  never be looked through. A certified full-aperture solar filter is still
  required on the telescope.

  Export with, for example:
    openscad -o stl/OAJ_SFS_P1_body.stl -D 'part="body"' openscad/solar_finder.scad
*/

$fn = 64;

// Select: layout, body, nacatin_adapter, pinhole_plate, target_plate, assembly.
part = "layout";

// Printer/service tuning. This is radial/per-side clearance, not total gap.
fit_clearance = 0.25;

// Universal body and adapter interface. Keep these values unchanged when
// adding telescope-specific adapters.
body_length = 90;
body_width = 30;
body_height = 9;
socket_start = 60;
adapter_tongue_length = 22;
adapter_tongue_neck_width = 16;
adapter_tongue_head_width = 20;
adapter_tongue_height = 4.5;
adapter_stop_thickness = 2;

// Projection plates.
plate_width = 34;
plate_height = 38;
plate_thickness = 3;
plate_tab_width = 18;
plate_tab_depth = 3;
plate_slot_length = plate_thickness + (2 * fit_clearance);
plate_slot_width = plate_tab_width + (2 * fit_clearance);
front_slot_x = 5;
target_distances = [45, 50, 55, 60, 65, 70];
pinhole_diameter = 0.8; // Printed pilot; finish carefully with a 0.8 mm drill.
optical_height = 21;

// Nacatin 90/800 finder-foot measurements. The height was estimated from
// photographs and is the main fit item to verify on P1.
nacatin_foot_length = 39.3;
nacatin_foot_top_width = 23.8;
nacatin_foot_bottom_width_front = 28.4;
nacatin_foot_bottom_width_rear = 29.5;
nacatin_foot_height = 5.5;
nacatin_notch_width = 14.9;
nacatin_notch_length = 4.2;
nacatin_notch_depth = 3.5;

eps = 0.02;

module dovetail_prism(length, neck_width, head_width, height) {
    // Extrude a captured dovetail along +X.
    rotate([0, 90, 0])
        linear_extrude(height = length)
            polygon([
                [0, -neck_width / 2],
                [-height, -head_width / 2],
                [-height,  head_width / 2],
                [0,  neck_width / 2]
            ]);
}

module plate_blank() {
    // Plate plane is Y/Z; thickness is X. Tab locates in a body slot.
    union() {
        translate([-plate_thickness / 2, -plate_width / 2, 0])
            cube([plate_thickness, plate_width, plate_height]);
        translate([-plate_thickness / 2, -plate_tab_width / 2, -plate_tab_depth])
            cube([plate_thickness, plate_tab_width, plate_tab_depth + eps]);
    }
}

module finder_body() {
    difference() {
        union() {
            cube([body_length, body_width, body_height]);
            // End shoulders protect the plate tab and identify the front.
            cube([10, 2, body_height + 1]);
            translate([0, body_width - 2, 0]) cube([10, 2, body_height + 1]);
        }

        // Captured female dovetail, open at the rear for adapter insertion.
        translate([socket_start - eps, body_width / 2, -eps])
            dovetail_prism(
                body_length - socket_start + (2 * eps),
                adapter_tongue_neck_width + (2 * fit_clearance),
                adapter_tongue_head_width + (2 * fit_clearance),
                adapter_tongue_height + fit_clearance
            );

        // Fixed front-plate slot.
        translate([
            front_slot_x - plate_slot_length / 2,
            (body_width - plate_slot_width) / 2,
            body_height - plate_tab_depth
        ]) cube([plate_slot_length, plate_slot_width, plate_tab_depth + eps]);

        // Rear target positions, measured from the pinhole plane.
        for (distance = target_distances)
            translate([
                front_slot_x + distance - plate_slot_length / 2,
                (body_width - plate_slot_width) / 2,
                body_height - plate_tab_depth
            ]) cube([plate_slot_length, plate_slot_width, plate_tab_depth + eps]);

        // Weight-reduction pockets stay clear of all slots and the socket.
        for (x = [18, 30, 42])
            translate([x, 5, 2.2]) cube([7, body_width - 10, body_height]);
    }
}

module nacatin_foot() {
    // Tapered reproduction of the measured finder foot.
    difference() {
        polyhedron(
            points = [
                [0, -nacatin_foot_bottom_width_front / 2, 0],
                [0,  nacatin_foot_bottom_width_front / 2, 0],
                [nacatin_foot_length, -nacatin_foot_bottom_width_rear / 2, 0],
                [nacatin_foot_length,  nacatin_foot_bottom_width_rear / 2, 0],
                [0, -nacatin_foot_top_width / 2, nacatin_foot_height],
                [0,  nacatin_foot_top_width / 2, nacatin_foot_height],
                [nacatin_foot_length, -nacatin_foot_top_width / 2, nacatin_foot_height],
                [nacatin_foot_length,  nacatin_foot_top_width / 2, nacatin_foot_height]
            ],
            faces = [
                [0, 2, 3, 1], [4, 5, 7, 6],
                [0, 1, 5, 4], [2, 6, 7, 3],
                [0, 4, 6, 2], [1, 3, 7, 5]
            ],
            convexity = 10
        );

        // Measured rear locating notch.
        translate([
            nacatin_foot_length - nacatin_notch_length,
            -nacatin_notch_width / 2,
            nacatin_foot_height - nacatin_notch_depth
        ]) cube([
            nacatin_notch_length + eps,
            nacatin_notch_width,
            nacatin_notch_depth + eps
        ]);
    }
}

module nacatin_adapter() {
    pedestal_height = 3;
    tongue_x = (nacatin_foot_length - adapter_tongue_length) / 2;

    union() {
        nacatin_foot();
        translate([
            tongue_x - adapter_stop_thickness,
            -adapter_tongue_neck_width / 2,
            nacatin_foot_height
        ]) cube([
            adapter_tongue_length + adapter_stop_thickness,
            adapter_tongue_neck_width,
            pedestal_height
        ]);

        translate([tongue_x, 0, nacatin_foot_height + pedestal_height])
            dovetail_prism(
                adapter_tongue_length,
                adapter_tongue_neck_width,
                adapter_tongue_head_width,
                adapter_tongue_height
            );

        // Positive insertion stop at the front of the universal tongue.
        translate([
            tongue_x - adapter_stop_thickness,
            -adapter_tongue_head_width / 2,
            nacatin_foot_height + pedestal_height
        ]) cube([
            adapter_stop_thickness,
            adapter_tongue_head_width,
            adapter_tongue_height
        ]);
    }
}

module pinhole_plate_raw() {
    difference() {
        plate_blank();
        translate([0, 0, optical_height])
            rotate([0, 90, 0])
                cylinder(h = plate_thickness + 2, d = pinhole_diameter, center = true);
    }
}

module target_plate_raw() {
    groove_depth = 0.55;
    groove_width = 0.7;
    difference() {
        plate_blank();
        // Recessed crosshair on the Sun-facing side.
        translate([-plate_thickness / 2 - eps, -8, optical_height - groove_width / 2])
            cube([groove_depth + eps, 16, groove_width]);
        translate([-plate_thickness / 2 - eps, -groove_width / 2, optical_height - 8])
            cube([groove_depth + eps, groove_width, 16]);
        translate([-plate_thickness / 2 - eps, 0, optical_height])
            rotate([0, 90, 0])
                difference() {
                    cylinder(h = groove_depth + eps, d = 6);
                    translate([0, 0, -eps])
                        cylinder(h = groove_depth + (3 * eps), d = 4);
                }
    }
}

module pinhole_plate_print() {
    // Lay the broad face on the bed.
    translate([plate_height, 0, plate_thickness / 2])
        rotate([0, -90, 0]) pinhole_plate_raw();
}

module target_plate_print() {
    // Target face upwards so the shallow markings remain clean.
    translate([plate_height, 0, plate_thickness / 2])
        rotate([0, -90, 0]) target_plate_raw();
}

module assembled_preview(target_distance = 70) {
    color("DimGray") finder_body();
    color("Orange")
        translate([front_slot_x, body_width / 2, body_height]) pinhole_plate_raw();
    color("Ivory")
        translate([front_slot_x + target_distance, body_width / 2, body_height]) target_plate_raw();

    // Adapter shown inserted; it remains a separate printed component.
    adapter_tongue_local_x = (nacatin_foot_length - adapter_tongue_length) / 2;
    color("SteelBlue")
        translate([
            socket_start - adapter_tongue_local_x,
            body_width / 2,
            -(nacatin_foot_height + 3)
        ]) nacatin_adapter();
}

module print_layout() {
    finder_body();
    translate([0, 44, 0]) nacatin_adapter();
    translate([45, 55, 0]) pinhole_plate_print();
    translate([45, 100, 0]) target_plate_print();
}

if (part == "body") finder_body();
else if (part == "nacatin_adapter") nacatin_adapter();
else if (part == "pinhole_plate") pinhole_plate_print();
else if (part == "target_plate") target_plate_print();
else if (part == "assembly") assembled_preview();
else print_layout();
