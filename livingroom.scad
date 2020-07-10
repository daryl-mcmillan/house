module oak() {
    color([237, 209, 142]/255) children();
}

module marble() {
    color([23, 115, 66]/255) children();
}

module gold() {
    color([153, 145, 0]/255) children();
}

module wall() {
    color([223, 245, 243]/255) translate([0,0,-6]) linear_extrude(6)  children();
}

module laminate() {
    color([110, 69, 34]/255) children();
}

module plaster() {
    color([1,1,1]) children();
}

module window1() {
    bl = [0,0];
    br = bl + [38.5,0];
    tl = bl + [0,50];
    tr = br + [0,69];
    translate([0,0,-10]) linear_extrude( 15 ) polygon([bl,br,tr,tl]);
}

fireplace_wall_width = 176;
module fireplace_wall() {
    width = fireplace_wall_width;
    bl = [0,0];
    br = [width,0];
    tr = br + [0,95];
    tl = bl + [0,95];
    mr = br + [-62,125];
    ml = bl + [62,125];
    
    // wall
    difference() {
        wall() polygon([bl, br, tr, mr, ml, tl ]);
        union() {
            translate([9.5,13]) window1();
            translate([br[0]-9.5,13,0]) scale([-1,1]) window1();
        }
    }
    
    // fireplace
    oak() translate([(width-58)/2,0,0]) cube([58,45,4]);
    oak() translate([ (width-65)/2,45,0 ]) cube([65, 3, 4+3]);
    gold() translate([ (width-48)/2,0,0 ]) cube([48, 40, 4.1]);
    color( "black" ) translate([ (width-40)/2,0,0 ]) cube([40, 36, 4.2]);
    marble() translate([ (width-60.5)/2,0,0]) cube([60.5, 0.1, 12.5]);

    // vaulted ceiling
    peak = (ml+mr)/2 + [0,18];
    roof_offset = [0,6];
    plaster() linear_extrude(76) polygon( [tl, ml, mr, tr, tr+roof_offset, peak, tl+roof_offset]);
    plaster() linear_extrude(76) polygon( [tl, ml, mr, tr, tr+roof_offset, peak, tl+roof_offset]);
    plaster() translate([0,0,76]) linear_extrude(6) polygon( [tl+[0,1], tr+[0,1], peak] );
    ceiling_width = 300;
    plaster() translate([0,0,76]) linear_extrude(300) polygon( [[0,96], [ceiling_width,96], [ceiling_width,102], [0,102]] );
}

left_wall_width = 166;
module left_wall() {
    bl = [0,0];
    br = bl + [left_wall_width,0];
    tr = br + [0,96];
    tl = bl + [0,96];
    wall() polygon([bl, br, tr, tl]);
}

module right_wall() {
    bl = [0,0];
    br = bl + [117,0];
    tr = br + [0,96];
    tl = bl + [0,96];
    wall() polygon([bl, br, tr, tl]);
}


back_wall_width = 161;
module back_wall() {
    bl = [0,0];
    br = bl + [back_wall_width,0];
    tr = br + [0,96];
    tl = bl + [0,96];
    ll = bl + [30,0];
    ul = ll + [0,81];
    lr = br + [-24,0];
    ur = lr + [0,81];
    wall() polygon([bl, ll, ul, ur, lr, br, tr, tl]);
}

laminate() translate([0,-400,-1]) cube([300,400,1]); //floor
rotate([90,0,0]) fireplace_wall();
rotate([0,0,90]) rotate([90,0,0]) translate([-left_wall_width,0,0]) left_wall();
translate([fireplace_wall_width,0,0]) rotate([0,0,-90]) rotate([90,0,0]) right_wall();
translate([back_wall_width,-left_wall_width,0]) rotate([0,0,180]) rotate([90,0,0]) back_wall();