difference() {
    cube_center([170,68,1.5]);
    translate([170/2-5.25,68/2-5.25,0])
    cube_center([10.5,10.5,2]);
    translate([-(170/2-5.25),68/2-5.25,0])
    cube_center([10.5,10.5,2]);
    
    
    for(s=[-1,1]) {
        translate([s*(170/2-5),68/2-5-15,0])
        cylinder(d=3.5,h=10,$fn=16);
        translate([s*(170/2-5),-68/2+5,0])
        cylinder(d=3.5,h=10,$fn=16);
        translate([s*(170/2-5-15),(68/2-5),0])
        cylinder(d=3.5,h=10,$fn=16);
    }
    
    translate([-28,-5.5,0.0])
    rotate([0,0,180])
    minus_raspberrypi();
    
    translate([41,12,0.0])
    minus_ina219();
    
    

translate([60,9]) {
    for(x=[0:10:10])
        for(y=[-10:10:10])
            translate([x,y,0])
            cylinder(d=2,h=10,$fn=16);
}
}

translate([-28,-5.5,1.5])
rotate([0,0,180])
raspberrypi();

translate([41,12,1.5])
ina219();

translate([55,-20,1.5])
dcdc();

module dcdc() {
    // border(w=52,h=27);
    translate([-20,0,0])
    cylinder(d1=3.5,d2=4.5,h=4,$fn=16);
    translate([20,0,0])
    cylinder(d1=3.5,d2=3.5,h=4,$fn=16);
    
}

module raspberrypi(standoff_height=2.5) {
    //border(w=85,h=56);
    
    translate([-85/2 + 3.5,49/2,0])
    standoff(h=standoff_height, id=2.0);
    
    translate([-85/2 + 3.5,-49/2,0])
    standoff(h=standoff_height, id=2.0);
    
    translate([-85/2 + 3.5 + 58,49/2,0])
    standoff(h=standoff_height, id=2.0);
    
    translate([-85/2 + 3.5 + 58,-49/2,0])
    standoff(h=standoff_height, id=2.0);
    
}

module minus_raspberrypi() {
    translate([-85/2 + 3.5,49/2,0])
    cylinder(d=2.0,h=10,$fn=16);
    
    translate([-85/2 + 3.5,-49/2,0])
    cylinder(d=2.0,h=10,$fn=16);
    
    translate([-85/2 + 3.5 + 58,49/2,0])
    cylinder(d=2.0,h=10,$fn=16);
    
    translate([-85/2 + 3.5 + 58,-49/2,0])
    cylinder(d=2.0,h=10,$fn=16);
    
    translate([-10,0,0])
    cube_center([60,35,5]);
    
    translate([-36,0,0])
    cube_center([36,20,5]);
}

module ina219(standoff_height=4.5) {
    L1=20.25;
    W1=17.25;

    //border(w=L1, h=W1);
    
    for(s=[-1,1]) for(t=[-1,1])
    translate([s*L1/2,t*W1/2,0])
    standoff(h=standoff_height, id=2);
    
}

module minus_ina219() {
    L1=20.25;
    W1=17.25;

    for(s=[-1,1]) for(t=[-1,1])
    translate([s*L1/2,t*W1/2,0])
    cylinder(d=2.0,h=10,$fn=16);
    
}


module border(w=50,h=50) {
    difference() {
        cube([w,h,0.5], center=true);
        cube([w-1,h-1,1], center=true);
    }
}


module standoff(h=4, id=2.5) {
    difference() {
        cylinder(d=id+2.5, h=h, $fn=32);
        cylinder(d=id, h=h+0.2, $fn=32);
    }
}

module cube_center(dims,r=0) {
    if(r==0) {
        translate([-dims[0]/2, -dims[1]/2, 0])
        cube(dims);
    } else {
        
        minkowski() {
            translate([-dims[0]/2+r, -dims[1]/2+r, 0])
            cube([dims[0]-2*r,dims[1]-2*r,dims[2]]);
            cylinder(r=r,h=0.00001,$fn=32);
        }
    }
}