L=170;
W=86;
T=1.5;

difference() {
    union() {
        cube_center([L,W,T]);
        translate([0,6/2,T])
        difference() {
            cube_center([L-21,W-6-21,5]);
            cube_center([L-21-2*T,W-21-6-2*T,5]);
        }
    }
    
    for(s=[-1,1])
    translate([s*(L/2-5),0,0])
    cylinder(d=3,$fn=32,h=10);
    
    for(s=[-1,1]) for(t=[-1,1])
    translate([s*(L/2-35),t*(W/2-5),0])
    cylinder(d=3,$fn=32,h=10);
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