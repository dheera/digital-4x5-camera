GGL=4*25.4+1;
GGW=5*25.4+1.5;
GGT=1/16*25.4+0.5;
OH=5;
F=10;
TT=2.5;

difference() {
    union() {
        cube_center([158,158,TT], r=7);
        cube_center([149.7,149.7,TT+13]);
    }
    
    translate([0,0,3])
    cube_center([149.7-3,149.7-3,50]);
    
    translate([0,0,1.5])
    cube_center([149.7-3-3,149.7-3-3,50]);
    
    cube_center([149.7-3-6,149.7-3-6,50]);
    
    translate([0,5,TT+3+3])
    cube_center([149.7-3,149.7-3,50]);
    
    for(t=[0,1])
    rotate([0,0,t*90])
    for(s=[-1:1])
    translate([s*60,0,TT+13-5])
    rotate([90,0,0,])
    cylinder(d=3.2,h=200,$fn=32,center=true);
    
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