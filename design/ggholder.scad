/* difference() {
    translate([-45,-45])
    import("LensBoard_Toyo-view_blank_v2.stl");
   
    translate([0,0,-10])
    cube_center([130,140,50]);
    
    for(s=[-1:1]) for(t=[-1,1])
    translate([t*70,s*70,0])
    cylinder(d=3.2,h=20,$fn=32, center=true);
} */

GGL=4*25.4+1;
GGW=5*25.4+1.5;
GGT=1/16*25.4+0.5;
OH=5;
F=10;
TT=2.5;

difference() {
    union() {
        cube_center([158,158,TT], r=7);
        minkowski() {
            cube_center([GGL+6,GGW+6,0.0001]);
            rotate([0,0,45])
            cylinder($fn=4,d1=F,d2=0.0001,h=OH+GGT);
        }
        for(t=[-1,1]) for(s=[-1,1])
        translate([t*(GGL/2+7),s*(GGW/2-7),0])
        cube_center([10,10,OH+GGT]);
    }
    
    for(t=[-1,1]) for(s=[-1,1])
    translate([t*(GGL/2+7),s*(GGW/2-7),0])
    cylinder(d=4.8,h=60,$fn=32);
    
    translate([0,0,OH])
    cube_center([GGL, GGW, GGT+5]);
    
    minkowski() {
        translate([0,0,0])
        cube_center([GGL-6-20, GGW-6-20, 0.0001]);
        rotate([0,0,45])
        cylinder($fn=4,d1=F,d2=0.0001,h=OH+GGT);
        cylinder($fn=4,d=20,h=0.0001);
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