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
        cube_center([L,L,T]);
        translate([0,L/2-DW/2-20,T])
        minkowski() {
            cube_center([DL+2*T,DW+2*T,0.0001]);
            rotate([0,0,45])
            cylinder($fn=4,h=DH,d1=10,d2=0.0001);
        }
    }
    
    translate([0,L/2-DW/2-20,T])
    minkowski() {
        cube_center([DL,DW,DH+2]);
    }
    
    translate([0,L/2-DW/2-20,0])
    translate([-DL/2+2+1,0,0])
    cube_center([4,24,10]);
    
    translate([0,L/2-DW/2-20,0])
    for(s=[-24:8:24]) translate([s,0,0])
    cube_center([5,35,10]);
    
    translate([0,L/2-DW/2-20,0])
    for(s=[-1,1]) for(t=[-1,1])
    translate([s*(99/2),t*(62/2),0])
    cylinder(d=3.5,$fn=32,h=10);
    
    for(s=[-1,1]) for(t=[-1,1])
    translate([s*(L/2-35),t*(L/2-5),0])
    cylinder(d=3.5,$fn=32,h=10);
    
    for(s=[-1,1]) for(t=[-1,1])
    translate([t*(L/2-5),s*(L/2-35),0])
    cylinder(d=3.5,$fn=32,h=10);
    
    translate([0,-L/2+BH/2+10,0])
    cube_center([BW,BH,10]);
}


    translate([0,-L/2+BH/2+10,0]) {
        difference() {
            translate([0,0,T])
            cube_center([BW+4*T,BH+4*T,T]);
            cube_center([BW,BH,10]);
            
            translate([BW/2+6,0,0])
            cube_center([10,BH+10,10]);
            
            translate([3,0,T])
            minkowski() {
                cube_center([BW+6,BH,0.0001]);
                rotate([0,0,45])
                cylinder($fn=4,h=T,d1=2*T,d2=0.0001);
            }
        }
    }
    


    translate([1,-L/2+BH/2+10,T]) {
        
            translate([BW/2+T,0,0])
            cube_center([2*T,BH+4*T,T]);
            minkowski() {
                cube_center([BW+2,BH,0.0001]);
                rotate([0,0,45])
                cylinder($fn=4,h=T,d1=2*T,d2=0.0001);
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