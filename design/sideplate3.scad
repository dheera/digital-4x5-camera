L=170;
W=86;
T=1.5;
ML=40;
MW=40;
MH=23;

difference() {
    union() {
        cube_center([L,W,T]);
        translate([0,-13,0])
        minkowski() {
            cube_center([ML+2*T,MW+2*T,0.0001]);
            rotate([0,0,45])
            cylinder($fn=4,h=MH+2*T,d1=0.0001,d2=0.0001);
        }
    }
    
    translate([0,-13,0])
    minkowski() {
        cube_center([ML,MW,0.0001]);
        rotate([0,0,45])
        cylinder($fn=4,h=MH,d1=0.0001,d2=0.0001);
    }
    
    
    for(s=[-1,1])
    translate([s*(L/2-5),0,0])
    cylinder(d=3,$fn=32,h=10);
    
    for(s=[-1,1]) for(t=[-1,1])
    translate([s*(L/2-35),t*(W/2-5),0])
    cylinder(d=3,$fn=32,h=10);
    
    translate([36,-13,0])
    cube_center([30,MW+2*T,9]);
}

translate([36,-13,0])
difference() {
    cube_center([30,MW+2*T,9]);
    rotate([0,0,-90]) {
    translate([0,-6,0]) {
    cube_center([13,7,10]);
    }
    translate([0,6,0]) {
    for(s=[-1,1])
    translate([17/2*s,0,0]) {
        cylinder(d=4.6,h=4.2,$fn=32);
    }
    cube_center([10.5,5.5,10]);
    translate([0,0,4])
    cube_center([12,7,6]);
    }
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