module ignore() {}

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
    translate([0,0,-6]) linear_extrude(6)  children();
}

module paint() {
    // wildflower prarie
    //color([201, 206, 225]/255) children();
    
    //white snail
    //color([241, 243, 241]/255) children();
    
    // meetinghouse blue
    //color([118, 156, 171]/255) children();
    
    // sea foam mist
    color([203, 220, 223]/255) children();
}

module paint_trim() {
    color([255, 255, 255]/255) children();
}

module kitchen() {
    color([194,190,182]/255) children();
}

module wood_floor() {
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
    polygon([bl,br,tr,tl]);
}

trim_height = 3.5;
trim_depth = 0.5;

module trim_shape() {
    linear_extrude(trim_depth) difference() {
        offset(delta=trim_height) children();
        children();
    }
}

module trim_line( start, end ) {
    delta = end - start;
    up = [ -delta[1], delta[0] ] / norm( delta );
    bl = start;
    br = end;
    tr = end + up * trim_height;
    tl = start + up * trim_height;
    linear_extrude( trim_depth ) polygon( [bl, br, tr, tl] );
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
    paint() wall() difference() {
        polygon([bl, br, tr, mr, ml, tl ]);
        union() {
            translate([9.5,13]) window1();
            translate([br[0]-9.5,13,0]) scale([-1,1]) window1();
        }
    }
    
    paint_trim() trim_shape() {
        translate([9.5,13]) window1();
        translate([br[0]-9.5,13,0]) scale([-1,1]) window1();
    }
    paint_trim() trim_line( bl, br );

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
    plaster() translate([0,0,76]) linear_extrude(6) polygon( [tl+[0,1], tr+[0,1], tr + roof_offset, peak, tl + roof_offset ] );
}

left_wall_width = 166;
module left_wall() {
    bl = [0,0];
    br = bl + [left_wall_width,0];
    tr = br + [0,96];
    tl = bl + [0,96];
    paint() wall() polygon([bl, br, tr, tl]);
    paint_trim() trim_line( bl, br );
}

module right_wall() {
    bl = [0,0];
    br = bl + [117,0];
    tr = br + [0,96];
    tl = bl + [0,96];
    paint() wall() polygon([bl, br, tr, tl]);
    paint_trim() trim_line( bl, br );
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
    paint() wall() polygon([bl, ll, ul, ur, lr, br, tr, tl]);
    paint_trim() trim_line( bl, ll );
    paint_trim() trim_line( lr, br );
}

module kitchen_patio() {
    bl = [0,0];
    br = bl + [140,0];
    tr = br + [0,96];
    tl = bl + [0,96];
    kitchen() wall() polygon( [bl, br, tr, tl] );
    paint_trim() trim_line( bl, br );
}

module kitchen_patio_position() {
    translate([176,-117,0]) rotate([90,0,0]) children();
}

kitchen_wall_width = 83;
module kitchen_wall() {
    bl = [0,0];
    br = bl + [kitchen_wall_width,0];
    tr = br + [0,96];
    tl = bl + [0,96];
    kitchen() wall() polygon( [bl, br, tr, tl] );
    paint_trim() trim_line( bl, br );
}

module kitchen_wall_position() {
    translate([161,-166-kitchen_wall_width,0]) rotate([0,0,90]) rotate([90,0,0]) children();
}

module fireplace_wall_position() {
    rotate([90,0,0]) children();
}

module left_wall_position() {
    rotate([0,0,90])
    rotate([90,0,0])
    translate([-left_wall_width,0,0])
    children();    
}

module right_wall_position() {
    translate([fireplace_wall_width,0,0])
    rotate([0,0,-90])
    rotate([90,0,0])
    children();
}

module back_wall_position() {
    translate([back_wall_width,-left_wall_width,0])
    rotate([0,0,180])
    rotate([90,0,0])
    children();
}

//fireplace_wall();

wood_floor() translate([0,-400,-1]) cube([300,400,1]); //floor
plaster() translate([0,-300-76,96]) cube([300,300,6]); // ceiling

// kitchen
kitchen_patio_position() kitchen_patio();
kitchen_wall_position() kitchen_wall();

// living room
fireplace_wall_position() fireplace_wall();
left_wall_position() left_wall();
right_wall_position() right_wall();
back_wall_position() back_wall();
