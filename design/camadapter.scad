H=21;

difference() {
    cube([38,38,6], center=true);
    
    for(s=[-1,1]) for(t=[-1,1])
    translate([-10*s,-10*t,0]) {
        cylinder(d=3.2,h=10, $fn=32, center=true);
        
        translate([0,0,3-1.7])
        cylinder(d1=3.2, d2=6.2,h=1.7, $fn=32);
    }
    
    cube([14,14,10], center=true);
}

for(s=[-1,1]) for(t=[-1,1])
translate([-15*s,-15*t,0])
difference() {
cylinder(d1=8,d2=5,h=H, $fn=64);
cylinder(d=2.5,h=H, $fn=32);
}