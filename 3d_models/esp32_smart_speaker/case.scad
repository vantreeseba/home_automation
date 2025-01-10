bezel = 2;
width = 50;
depth = 20;
height = 20;

cover_color = 0.6;
base_color = 0.7;

offset = 0; //-10;

module speaker_cut_out() {
  rotate([ 90, 0, 0 ]) cylinder(h = 20, r = 50, center = true);
}

module case_front_cover(width = 20, height = 20, depth = 20) {
  inset = depth + bezel / 2;

  color([ cover_color, cover_color, cover_color ]) {
    difference() {
      union() {
        cube([ width, depth, height ], true);
        difference() {
          translate([ 0, bezel / 2, 0 ])
              cube([ width - bezel, inset, height - bezel ], true);
          translate([ 0, bezel / 2, 0 ])
              cube([ width - bezel * 2, 20, height - bezel * 2 ], true);
        }
      }

      speaker_cut_out();
    }
  }
}

module case_back_cover(width = 20, height = 20, depth = 20) {
  color([ cover_color, cover_color, cover_color ]) {
    cube([ width, depth, height ], true);
    difference() {
      translate([ 0, -bezel / 2, 0 ])
          cube([ width - bezel, depth + bezel / 2, height - bezel ], true);
      translate([ 0, -bezel / 2, 0 ])
          cube([ width - bezel * 2, 20, height - bezel * 2 ], true);
    }
  }
}

module case_center(width = 20, height = 20, depth = 20) {
  color([ base_color, base_color, base_color ]) {
    difference() {
      cube([ width, depth, height ], true);
      cube([ width - bezel, depth + bezel * 2, height - bezel ], true);
    }
  }
}

module case (width = 20, height = 20, depth = 20) {
  translate([ 0, (-depth / 2) - bezel / 2 + offset, 0 ])
      case_front_cover(width, height, bezel);
  // case_center(width, height, depth);
  // translate([0,(depth/2)+bezel/2- offset,0])
  // case_back_cover(width, height, bezel);
}

case (width, height, depth);