$fn = $preview ? 16 : 48;

section_radius = 90;
section_corner_radius=5;
section_height = 35;
section_wall_thickness = 3;
section_fillet = 20;
screw_radius=1.7;

module speaker() {
    z_minus=-6;
    speaker_screw_radius = screw_radius;

    union() {
        translate([0,0,10]) 
        cube([53,53,20], center=true);
        linear_extrude(height=27, scale=0.8)
        circle(26);
        translate([0,0,-10]) 
        linear_extrude(15)
        circle(26);
    }


    translate([22,22,z_minus]) 
    cylinder(h=10, r=speaker_screw_radius);
    translate([22,-22,z_minus]) 
    cylinder(h=10, r=speaker_screw_radius);
    translate([-22,22,z_minus]) 
    cylinder(h=10, r=speaker_screw_radius);
    translate([-22,-22,z_minus]) 
    cylinder(h=10, r=speaker_screw_radius);
}

module fillet(r) {
   offset(r = -r) {
     offset(delta = r) {
       children();
     }
   }
}

// 0.96in I2C IIC 12864 128X64 Pixel OLED LCD
module oled_screen() {
    screw_radius = 1.1;
    screw_dist = (25.5/2)-screw_radius*1.5;

    // difference(){
        union() {
            cube(size  = [25.5, 26, 1.75], center=true);
            translate([0,0,4-1.75]) 
            cube(size  = [25,16.5, 4], center=true);
        // }

    //screw_holes
    // union() {
        screws = [
            [screw_dist, screw_dist],
            [-screw_dist, screw_dist],
            [-screw_dist, -screw_dist],
            [screw_dist, -screw_dist],
        ];

        size = 10;

        for (a = [0:len(screws) - 1]) {
            point=screws[a];
            
            translate([point[0],point[1],0])
            cylinder(r=screw_radius,h=10, center=true); 
        }
    // }
    }
}

module section(
    section_height=section_height,
    section_radius=section_radius, 
    section_corner_radius=section_corner_radius, 
    section_wall_thickness=section_wall_thickness,
    section_fillet=section_fillet
) {
    difference() {
        union(){
            s = (section_radius/(section_radius-section_wall_thickness-1.5));

            translate([0,0,-2]) 
            linear_extrude(height=2, scale = s)
            fillet(-section_fillet+s)
            square(section_radius-section_wall_thickness-1, center=true);
            linear_extrude(section_height)
            fillet(-section_fillet)
            square(section_radius, center=true);
        }
        
        union() {
            translate([0,0,0]) 
            linear_extrude(section_height+1)
            fillet(-section_fillet)
            square(section_radius-section_wall_thickness, center=true);
            translate([0,0,section_height-2.5]) 
            linear_extrude(height=3, scale =(section_radius/(section_radius-section_wall_thickness-1)))
            fillet(-section_fillet)
            square(section_radius-section_wall_thickness-1, center=true);
        }
    }
}

module section_legs(
    section_radius=section_radius
) {
    leg_dist = (section_radius-section_wall_thickness)/PI;
    legs = [
        [leg_dist, leg_dist],
        [-leg_dist, leg_dist],
        [-leg_dist, -leg_dist],
        [leg_dist, -leg_dist],
    ];

    difference() {
        for (a = [ 0 : len(legs) - 1 ]) {
            point=legs[a];

            translate([point[0],point[1],-10])
            cylinder(r=6.5,h=10);
        }

        translate([0,0,-5]) 
        rotate([0,180,45]) 
        section_screws();
    }
}

module section_joint(size = 10) {
    translate([-sin(45)*size/2, -sin(45)*size/2, -size/2])
    linear_extrude(height = size) 
    scale(size) 
    polygon(points=[[0,0],[0,1],[1.5,0]]);
}

module section_screws(
    section_radius=section_radius,
    section_wall_thickness=section_wall_thickness,
    head_height=5,
    head_radius=5.7/2,
    screw_radius=screw_radius,
    screw_length=15
) {
    screw_dist = (section_radius-section_wall_thickness)/PI;
    screws = [
        [screw_dist, screw_dist],
        [-screw_dist, screw_dist],
        [-screw_dist, -screw_dist],
        [screw_dist, -screw_dist],
    ];

    size = 10;

    rotate([0,0,45])
    // translate([0,0,35])
    for (a = [0:len(screws) - 1]) {
        point=screws[a];
        
        translate([point[0],point[1],0])
        cylinder(r=head_radius,h=head_height); 
        translate([point[0],point[1],-10])
        cylinder(r=screw_radius,h=screw_length); 
    }
}

module section_joints(
    section_height=section_height, 
    section_radius=section_radius
) {
    leg_dist = (section_radius)/PI;
    legs = [
        [leg_dist, leg_dist],
        [-leg_dist, leg_dist],
        [-leg_dist, -leg_dist],
        [leg_dist, -leg_dist],
    ];

    size = 10;

    rotate([0,0,45])
    translate([0,0,section_height+5])
    for (a = [0:len(legs) - 1]) {
        point=legs[a];
        
        translate([point[0],point[1],-size])
        rotate([0,90,135+(a*90)])
        section_joint(size);   
    }
}

module SPEAKER_SECTION(section_height=section_height) {
    difference() {
        union(){    
            section(section_height=section_height);
            section_joints(section_height=section_height);
        }

        translate([0,0,section_height]) 
        union(){
            section();
            translate([0,0,-5]) 
            section_screws(section_radius, section_wall_thickness);
        }
        
        speaker();
        section_screws(section_radius, section_wall_thickness);
    }
}

module LED_SECTION(section_height=section_height) {
    led_radius = 20;

    difference() {
        union(){    
            section(section_height=section_height);
            section_joints(section_height=section_height);

            // for led section
            linear_extrude(height = section_height-10) 
            circle(r = led_radius);

            // section_legs();
        }

        translate([0,0,section_height]) 
        union(){
            section(section_height=section_height);
            translate([0,0,-5]) 
            section_screws(section_radius, section_wall_thickness);
        }
        
        // speaker();
        
        // for led section
        translate([0,0,-5])
        linear_extrude(height = section_height) 
        circle(r = led_radius-section_wall_thickness);
        section_screws(section_radius, section_wall_thickness);
    }
}

module ESP_SECTION(section_height=section_height) {
    difference() {
        union(){    
            section(section_height=section_height);
            section_joints(section_height=section_height);
        }

        translate([0,0,section_height]) 
        union(){
            section(section_height=section_height);
            translate([0,0,-5]) 
            section_screws(section_radius, section_wall_thickness);
        }
        
        // wire pass hole
        translate([-(section_radius/3.5),0,0]) 
        cube([15,30,20], center=true);

        // USB hole
        translate([-section_radius/1.75,0,10])
        rotate([0,90,0])
        scale([1,1.5,1]) 
        #cylinder(h = 15, r =7.5);
        // #cube([15,30,15], center=true);

        section_screws(section_radius, section_wall_thickness);

        translate([-(section_radius/2-section_wall_thickness-3.5),0,section_height]) 
        #cube([10,15,35], center=true);

        translate([section_radius/2-section_wall_thickness-3.5,0,section_height]) 
        cube([10,15,35], center=true);

        translate([section_radius/2-2.5,0,15]) 
        rotate([90,0,90]) 
        // translate([section_radius/2, 0, 15]) 
        oled_screen();
    }
}

module vent_holes() {
    count = 3/2;
    space = section_radius / (count*3.5);
    for (x = [-count:count]) {
        for (y = [-count:count]) {
            translate([x*space,y*space,0])
            cube(size=[4,4,5], center=true);
        }
    }
}

module lid(){
    difference() {
    union(){
        s = (section_radius/(section_radius-section_wall_thickness-1.5));

        translate([0,0,-2]) 
        linear_extrude(height=2, scale = s)
        fillet(-section_fillet+s)
        square(section_radius-section_wall_thickness-1, center=true);
        linear_extrude(0)
        fillet(-section_fillet)
        square(section_radius, center=true);
    }

    
    vent_holes();
    translate([0,0,-1]) 
    section_screws();
    }
}

// oled_screen();

// translate([-100, 0,0]) 
// section_legs();
// SPEAKER_SECTION(section_height=40);
// translate([200, 0,0]) 
// lid();
// translate([100, 0,0]) 
// LED_SECTION(section_height=30);
ESP_SECTION(section_height=section_height);