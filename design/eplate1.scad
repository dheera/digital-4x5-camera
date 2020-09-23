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

    translate([0,-3,0])
    cube_center([75,53,10]);
    for(s=[-1,1]) for(t=[-1,1])
    translate([(75/2+5)*s,20*t-3,0])
    cylinder(d=3.2,h=10,$fn=32);
}

translate([0,-3,1.5])
difference () {
    cube_center([78,56,23]);
    cube_center([75,53,23-1.5]);
    cube_center([55,35,100]);
tu  j    cube_center([100,15,8]);
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