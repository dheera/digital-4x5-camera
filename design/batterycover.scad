L=170;
W=86;
T=1.5;
ML=150;
MW=66;
MH=23;

DL=107;
DW=68.5;
DH=14;

BW=75;
BH=55;


difference() {
    union() {
            translate([BW/2+T,0,0])
            cube_center([2*T,BH+4*T,T]);
            minkowski() {
                cube_center([BW+2-0.2,BH-0.2,0.0001]);
                rotate([0,0,45])
                cylinder($fn=4,h=T,d1=2*T,d2=0.0001);
            }
            
        }
    translate([BW/2-6,0,T/2])
    cube_center([2,15,5]);    
    translate([BW/2-10,0,T/2])
    cube_center([2,15,5]);
    translate([BW/2-14,0,T/2])
    cube_center([2,15,5]);
 
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