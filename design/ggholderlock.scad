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

difference() {
    union() {
        cube_center([GGL+6,GGW+6,5]);
        
        for(t=[-1,1]) for(s=[-1,1])
        translate([t*(GGL/2+7),s*(GGW/2-7),0])
        difference() {
            cube_center([10,10,5]);
            cylinder(d=3.2,h=6,$fn=32);
            translate([0,0,3])
            cylinder(d1=3.2,d2=7,h=2,$fn=32);
        }
    }
    translate([0,0,2.5])
    cube_center([GGL,GGW,5]);
    minkowski() {
        cube_center([GGL-6-20,GGW-6-20,2.5]);
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