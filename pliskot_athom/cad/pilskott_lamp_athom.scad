use <../_openscad_libs/threads.scad>


/*[ Slider ]*/
$fn=16; // [16:64]
// Width    Height     Depth
BASE_SIZE = [100, 100, 50];
/*[ Slider ]*/
BASE_FILLET = 5; // [0:50]
BASE_WALL_THICKNESS = 5; // [0:50]
/*[ Slider ]*/
// The height of the cylinder connecting the base and the leds.
SPAR_HEIGHT = 20; // [20:100]
/*[ Slider ]*/
// The height of the cylinder connecting the base and the leds.
LED_SLOT_WIDTH = 20; // [20:100]
/*[ Slider ]*/
// The height of the cylinder connecting the base and the leds.
LED_SLOT_RADIUS = 20; // [20:100]
/*[ Slider ]*/
lamp_straight_height_l=200;// [20:400]
/*[ Slider ]*/
lamp_straight_height_r=100; // [20:400]
/*[ Slider ]*/
led_slot_thickness = 5;// [5:20]
/*[ Slider ]*/
led_slot_depth = 10; // [10:40]

module fillet(r) {
   offset(r = -r) {
     offset(delta = r) {
       children();
     }
   }
}

module base_cover_screws() {
    // Screw holders
    x = BASE_SIZE[0]-BASE_WALL_THICKNESS*2;
    y = BASE_SIZE[1]-BASE_WALL_THICKNESS*2;
    z = 0;
    w = BASE_WALL_THICKNESS*1.33;
    holders = [
        [w,w,z],
        [x+w/2,w,z],
        [x+w/2,y+w/2,z],
        [w,y+w/2,z]
    ];

    for(a=[0:3]) {
        translate(holders[a]) 
        cylinder(h=20, r=2);
        translate(holders[a]-[0,0,2.5]) 
        cylinder(h = 2.5, r = 3.5);
    }
}

module base_cover() {
    difference() {
        translate([0,0,-BASE_WALL_THICKNESS/2])
        linear_extrude(height = BASE_WALL_THICKNESS)
        fillet(r = -BASE_FILLET)
        square([BASE_SIZE[0], BASE_SIZE[1]]);

        base();
    }
}

module base(size=BASE_SIZE) {
    // Screw holders
    x = BASE_SIZE[0]-BASE_WALL_THICKNESS*2;
    y = BASE_SIZE[1]-BASE_WALL_THICKNESS*2;
    z = 3;
    holders = [
        [1,1,z],
        [x-1,1,z],
        [x-1,y-1,z],
        [1,y-1,z]
    ];

    for(a=[0:3]) {
        translate(holders[a]) 
        linear_extrude(height = BASE_SIZE[2]-z)
        fillet(r = -3.5)
        square([10,10]);
    }

    difference() {
        linear_extrude(height = BASE_SIZE[2])
        fillet(r = -BASE_FILLET)
        square([BASE_SIZE[0], BASE_SIZE[1]]);

        translate([BASE_WALL_THICKNESS/2,BASE_WALL_THICKNESS/2,-BASE_WALL_THICKNESS]) 
        linear_extrude(height = BASE_SIZE[2])
        fillet(r = -BASE_FILLET)
        square([BASE_SIZE[0], BASE_SIZE[1]] - [BASE_WALL_THICKNESS, BASE_WALL_THICKNESS]);

        translate([BASE_SIZE[0]/2,BASE_WALL_THICKNESS,20]) 
        rotate([90,00,0]) 
        #cylinder(h = 5, r = 4);
    }
}

module spar_sub() {
    translate([BASE_SIZE[0]/2, BASE_SIZE[1]/2, BASE_SIZE[2] - SPAR_HEIGHT/2]) 
    cylinder(h = SPAR_HEIGHT*2, r = LED_SLOT_WIDTH/2-BASE_WALL_THICKNESS/2);
}

module spar(radius=LED_SLOT_WIDTH, height=SPAR_HEIGHT) {
    difference() {
        translate([BASE_SIZE[0]/2, BASE_SIZE[1]/2, BASE_SIZE[2]]) 
        cylinder(h=SPAR_HEIGHT, r=LED_SLOT_WIDTH/2);
    }
}

module led_slot_circle_sub() {
    center = [BASE_SIZE[0]/2, BASE_SIZE[1]/2, BASE_SIZE[2]];

    // cut out radius
    translate(center + [0,0,SPAR_HEIGHT/2 + LED_SLOT_RADIUS])
    rotate([90,0,0]) 
    cylinder(h = LED_SLOT_WIDTH-led_slot_thickness, r = LED_SLOT_RADIUS-led_slot_thickness, center=true);
}

module led_slot(){
    center = [BASE_SIZE[0]/2, BASE_SIZE[1]/2, BASE_SIZE[2]];
    
    difference() {
        union() {
            translate(center + [0,0,SPAR_HEIGHT/2 + LED_SLOT_RADIUS]) 
            rotate([90,0,0]) 
            cylinder(h = LED_SLOT_WIDTH, r = LED_SLOT_RADIUS, center=true);
        }

        //cut out "slot"
        translate(center + [0,0, SPAR_HEIGHT/2 + LED_SLOT_RADIUS])
        rotate([90,0,0]) 
        cylinder(h = LED_SLOT_WIDTH+5, r = LED_SLOT_RADIUS-led_slot_depth, center=true);

        // cut cylinder in half, to form bottom half circle of lamp
        translate(center + [0,0, SPAR_HEIGHT/2 + LED_SLOT_RADIUS*2])
        cube(size = [LED_SLOT_RADIUS*2,LED_SLOT_RADIUS*2, LED_SLOT_RADIUS*2], center=true);
    }

    arm_outer_size = LED_SLOT_WIDTH;
    arm_inner_size = LED_SLOT_WIDTH-led_slot_thickness;

    // left arm
    difference() {
        translate(center + [LED_SLOT_RADIUS-led_slot_depth/2,0,SPAR_HEIGHT/2 + LED_SLOT_RADIUS + lamp_straight_height_l/2])
        cube(size = [led_slot_depth, arm_outer_size, lamp_straight_height_l], center=true);

        translate(center + [(LED_SLOT_RADIUS-led_slot_depth/2)-led_slot_thickness,0,SPAR_HEIGHT/2 + LED_SLOT_RADIUS + lamp_straight_height_l/2])
        cube(size = [led_slot_depth, arm_inner_size, lamp_straight_height_l+1], center=true);
    }

    // right arm
    difference() {
        translate(center + [-LED_SLOT_RADIUS+led_slot_depth/2,0,SPAR_HEIGHT/2 + LED_SLOT_RADIUS + lamp_straight_height_r/2])
        cube(size = [led_slot_depth, arm_outer_size, lamp_straight_height_r], center=true);
    
        translate(center + [-(LED_SLOT_RADIUS-led_slot_depth/2)+led_slot_thickness,0,SPAR_HEIGHT/2 + LED_SLOT_RADIUS + lamp_straight_height_l/2])
        cube(size = [led_slot_depth, arm_inner_size, lamp_straight_height_l+1], center=true);
    }
}

module lamp() {
    difference() {
        union(){
            base();
            spar();
            led_slot();
        }
        spar_sub();
        led_slot_circle_sub();
        base_cover_screws();
    }
}


// base();
spar();

module ScrewThread(outer_diam=2, height=4, pitch=0, tooth_angle=30, tolerance=0.4, tip_height=0, tooth_height=0, tip_min_fract=0)

// lamp();

// translate([120,0,0]) 
// difference() {
//     base_cover();
//     base_cover_screws();
// }

