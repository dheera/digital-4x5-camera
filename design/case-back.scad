L=180;
W=180;
H=80;
T=2;
offsetL=30/2;
offsetW=30/2;

difference() {
    cube_center([L,W,H], r=5);
    translate([0,0,2])
    cube_center([L-2*T,W-2*T,H], r=4);
    
}

translate([0,0,2]) {
    translate([0,-offsetW,0]) {
        difference() {
            cube_center([L,30,7]);
            translate([-offsetL,0,0])
            for(s=[-1,1]) for(t=[-1,1])
            translate([s*95/2,t*17/2,0])
            cylinder(d=4.5,h=15,$fn=32);
        }
    }
}

module m3standoff() {
    difference() {
        cylinder(d1=10,d2=7,h=5,$fn=32);
        cylinder(d1=4,d2=4,h=6,$fn=32);
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