difference() {
    union() {
        cube_center([78,56,19]);
        cube_center([78+20,56,1.5]);
    }
    cube_center([75,53,19-1.5]);
    for(s=[-1,1]) for(t=[-1,1])
    translate([(75/2+5)*s,20*t,0])
    cylinder(d=3.2,h=10,$fn=32);
    
    cube_center([60,30,100]);
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