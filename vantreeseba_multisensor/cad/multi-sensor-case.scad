use <../../_openscad_libs/threads.scad>

ld2450 = 44*15; //dimensions

length=40;
width=60;
thickness=30;

board_thickness=1.5;
screw_hole_radius=2.5/2;
screw_hole_offset=2.5;

backing_plate_mounting_hole_height=5;
backing_plate_mounting_hole_radius1=15;
backing_plate_mounting_hole_radius2=20;


ball_radius = 4;
rod_radius=2;
rod_length = 30;


pir_offset_from_top=21;
pir_offset_from_side=20;
pir_radius = 7;

wt=2;
$fn=30;

module board(length=length, width=width, thickness=board_thickness) {
  bho = screw_hole_offset;
  bhr = screw_hole_radius;
  sl = 6.5; //screw length.
  union() {
    cube([length, width, thickness]);
        
    // TL
    translate([bho, bho, -sl])
    cylinder(sl,bhr,bhr);
    // TR
    translate([bho, width-bho, -sl])
    cylinder(sl,bhr,bhr);
    // BL
    translate([length-bho, bho, -sl])
    cylinder(sl,bhr,bhr);
    // BR
    translate([length-bho, width-bho, -sl])
    cylinder(sl,bhr,bhr);
  }
}


module case_bottom(){
  bho1 = screw_hole_offset + wt;
  bho2 = screw_hole_offset - wt;
  
  difference(){
    union(){
      cube([length+wt+wt, width + 6, 2]);
      
      //end
      translate([-wt,-wt,0])
      difference() {
        cube([length+wt*4, wt, thickness+wt]);
        for(z = [1:3]){
          for(x = [0:5]) {
            translate([x*8+wt*2,wt,z*8])
            rotate([90,0,0])
            #cylinder(5,2.5,2.5);
          }
        }
      }
      
      //far end
      translate([-wt,width+6,0])
      difference() {
        cube([length+wt*4, wt, thickness+wt]);
        translate([length/2+wt*2,1,16])
        cube([14,12,4], center=true);
        
        translate([length/2+wt*2,1,18])
        rotate([90,0,0])
        scale([1,0.5,1])
        cylinder(5,7,7, center=true);
        
        for(z = [1:3]){
          for(x = [0:5]) {
            if(z == 2 && (x == 2 || x == 3)) {
            } else {
              translate([x*8+wt*2,wt,z*8])
              rotate([90,0,0])
              #cylinder(5,2.5,2.5);
            }
          }
        }
      }
      
      translate([bho1, bho1, 4])
      cube(screw_hole_radius*4, center=true);
      // TR
      translate([bho1, width-bho2, 4])
      cube(screw_hole_radius*4, center=true);
      // BL
      translate([length-bho2, bho1, 4])
      cube(screw_hole_radius*4, center=true);
      // BR
      translate([length-bho2, width-bho2, 4])
      cube(screw_hole_radius*4, center=true);
    }
    
    translate([length/2 + wt, width/2 + wt, 0])
    #cylinder(
      wt, 
      backing_plate_mounting_hole_radius1, 
      backing_plate_mounting_hole_radius2);
  }
}

module backing_plate_mount_insert() {
  union() {
    cylinder(
      wt,
      backing_plate_mounting_hole_radius1,
      backing_plate_mounting_hole_radius2
    );
        
    h=10;
    translate([0,0,0])
    rotate([180,0,0])
    ScrewThread(
      20, 
      h,
      pitch = 5,
      tooth_angle=45,
      tooth_height=4,
      tip_height=0,
      tip_min_fract=0
    );
    translate([0,0,-(20-ball_radius)])
    difference(){
      cylinder(ball_radius*2, 16/2, 16/2);
      
      translate([0,0,ball_radius/3])
      sphere(ball_radius);
      
      translate([0,0,-1])
      cube([20,rod_radius*2,ball_radius*2],center=true);
      
      rotate([0,0,90])
      translate([0,0,-1])
      cube([20,rod_radius*2,ball_radius*2],center=true);
    }
  }
}

module backing_plate_mount_screw() {
    h=10;
  
    difference() {
      ScrewHole(
        20, 
        h,
        pitch = 5,
        tooth_angle=45,
        tooth_height=4
      )
      cylinder(h, 20, 20);
      
      translate([0,0,-1])
      cylinder(5, 17, 10);
    }
}

module case_cover_ir() {
  translate([-wt,0,-wt])
  difference() {
    cube([length+wt+wt+wt+wt, width + 6, thickness+wt+wt]);
    translate([wt,-1,wt])
    cube([length+wt+wt, width+(6)+2, thickness]);
    translate([wt*2,-1,-wt])
    cube([length, width+(6)+2, thickness]);
    
    translate([
      pir_offset_from_side +wt, 
      pir_offset_from_top +wt,
      thickness])
    #cylinder(5, pir_radius, pir_radius);
  }
}

module case_cover_radar() {
  translate([-wt,0,-wt])
  difference() {
    cube([length+wt+wt+wt+wt, width + 6, thickness+wt+wt]);
    translate([wt,-1,wt])
    cube([length+wt+wt, width+(6)+2, thickness]);
    translate([wt*2,-1,-wt])
    cube([length, width+(6)+2, thickness]);
    
    
  }
}

module stand() {
  base_length = 30;
  base_width = 60;


  LEN = (base_length + wt);
  WID = (base_width + wt);
  
  module base() {
    translate([wt,wt,wt])
    hull() {
      for(x=[0:1]){
        for(y=[0:1]){
          translate([x*(base_length-wt), y*(base_width-wt),0])
          sphere(2);
        }
      }
    }
  }
  
  module rod() {
    translate([LEN/2, WID/3, 0])
    cylinder(rod_length-3, rod_radius*4, rod_radius);
    translate([LEN/2, WID/3, rod_length-3])
    cylinder(3, rod_radius, rod_radius);
    
    translate([LEN/2, WID/3, rod_length+ball_radius/1.2])
    sphere(ball_radius);
  }
  
  difference(){
    base();
    sho = 6;
    xoffset = LEN - (sho+sho);
    yoffset = (base_width+wt) - (sho+sho);
    
    //screw holes
   translate([sho,sho,0])
   for(x=[0:1]) for(y=[0:1]){
      translate([x*xoffset, y*yoffset ,0])
      cylinder(5, 3, 3);
    }
  }
  
  rod();
}


/*
difference(){
  case_bottom();
  translate([wt, wt, 6.5])
  board();
}
*/
//case_cover_ir();
case_cover_radar();

//translate([length/2 + wt, width/2 + wt, -1])
//backing_plate_mount_insert();
// backing_plate_mount_screw();
//translate([-6,-6,-(29+ball_radius/4)])
//stand();
