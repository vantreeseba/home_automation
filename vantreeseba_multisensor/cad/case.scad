// The thickness of the exterior of case.
bezel = 2;

width = 60;
depth = 20;
height = 40;

cover_color = 0.6;
base_color = 0.7;

screw_center_inset = 2.5; // 2.5mm
screw_hole_interior = 2.25;

offset = 0; //-10;

module ir_sensor_cutout() {
  rotate([ 90, 0, 0 ]) cylinder(h = 20, r = 50, center = true);
}

module case_back_cover(v = [ 20, 20, 20 ]) {
  color([ cover_color, cover_color, cover_color ]) {
    union() {
      cube([ v.x, v.y, 1 ], true);
      difference() {
        // translate([ 0, -bezel / 2, 0 ])
        // cube([ v.x, v.y + bezel / 2, v.z ], true);

        // translate([ 0, -bezel / 2, 0 ])
        // cube([ v.x - bezel, 20, v.z - bezel ], true);
      }

      v2 = v * 0.5;

      // screw
      $fn = 50;
      translate([ v2.x - 2.5, v2.y - 2.5, 0 ]) difference() {
        cylinder(3, r = 2.5, true);
        cylinder(4, r = screw_hole_interior, true);
      }
      translate([ -v2.x + 2.5, v2.y - 2.5, 0 ]) difference() {
        cylinder(3, r = 2.5, true);
        cylinder(4, r = screw_hole_interior, true);
      }
      translate([ -v2.x + 2.5, -v2.y + 2.5, 0 ]) difference() {
        cylinder(3, r = 2.5, true);
        cylinder(4, r = screw_hole_interior, true);
      }
      translate([ v2.x - 2.5, -v2.y + 2.5, 0 ]) difference() {
        cylinder(3, r = 2.5, true);
        cylinder(4, r = screw_hole_interior, true);
      }
    }
  }
}

module case_center(v = [ 20, 20, 20 ]) {
  color([ base_color, base_color, base_color ]) {
    difference() {
      cube([ v.x + bezel, v.y + bezel, v.z ], true);
      cube([ v.x, v.y, v.z + bezel * 2 ], true);
    }
  }
}

module case (v = [ 20, 20, 20 ]) {
  // translate([ 0, (-depth / 2) - bezel / 2 + offset, 0 ])
  //     case_front_cover(width, height, bezel);
  // case_center(v);
  translate([ 0, 0, v.z / 2 ]) case_back_cover(v);
}

// case_back_cover([ width, 5, depth ]);

case ([ width, height, depth ]);

// cube([10,20,30]);