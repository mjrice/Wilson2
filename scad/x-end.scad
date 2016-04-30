// Wilson II X Ends
// By M. Rice
// GNU GPL v3
// Adapted from design by Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <configuration.scad>

rod_distance = 50;       // vertical distance between X axis smooth rods (was 45mm on original prusa i3 xends)
pushfit_d = 10.2;        // slightly larger than the rods themselves to accomodate extrusion
bearing_diameter = 19;   // 19=LM10UU 15=LM8UU
bearing_cut_extra = 0.1; // extra cut for linear bearings so they are not too tight.
thinwall = 3;            // thickness of the wall that holds in the linear bearings
height = rod_distance+15;// height of the x ends
m3_hole_r = 1.8;

center_z = 30.25 -1;
tensioner_size_z = 12;

bearing_size = bearing_diameter + 2 * thinwall;

// MODULE -------------------------------------
module vertical_bearing_base(){
 translate(v=[-2-bearing_size/4,0,height/2]) cube(size = [4+bearing_size/2,bearing_size,height], center = true);
 cylinder(h = height, r=bearing_size/2, $fn = 90);
}

// MODULE -------------------------------------
module vertical_bearing_holes(){
  #translate(v=[0,0,-4]) cylinder(h = height+3, r=bearing_diameter/2 + bearing_cut_extra, $fn = 60);
  translate(v=[0,0,height-4]) cylinder(h=10,r=bearing_diameter/2-1,$fn=60);
  
  // the slit cut along the vertical bearing holder for some flex
  rotate(a=[0,0,80]) translate(v=[8,0,27]) cube(size = [10,5 ,height+13], center = true);

  translate([0,0,-1]) cylinder(h=9,r1=bearing_diameter/2+thinwall/2+1,r2=4,$fn=60);

}

// MODULE -------------------------------------
module x_end_base(){
  // Main block
  height = rod_distance + 15;
  translate(v=[-15,-10,height/2]) cube(size = [17,45,height], center = true);

  // Bearing holder
  vertical_bearing_base();	

  // thing to hold the brass nut
  translate(v=[-3.5,-22,4]) cube(size=[7.8,20,8],center=true);

  translate(v=[5.5,-24,4]) cylinder(h=8,r=12.5,$fn=50,center=true);
              
  // post for actuating z rack
z_post_h = 14;
  translate(v=[-14,-27.5,height+z_post_h/2]) { 
  difference() {
    cube(size=[15,10,z_post_h],center=true);
    //rotate([90,0,0]) cylinder(h=20,r=m3_hole_r,$fn=50,center=true);
  }

}

}

// MODULE -------------------------------------
module x_end_holes(){
 vertical_bearing_holes();
 // Belt hole
 translate(v=[-1,0,0]){
 // Stress relief
 translate(v=[-5.5-10+1.5,-10-1,30]) cube(size = [20,1,28], center = true);
 difference(){
	translate(v=[-5.5-10+1.5,-10,30]) cube(size = [10,46,28], center = true);
	// Nice edges
	translate(v=[-5.5-10+1.5,-10,30+23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
	translate(v=[-5.5-10+1.5,-10,30+23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
	translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
	translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
   }
 }
 
 // Bottom pushfit rod
 translate(v=[-15,-41.5,7.5]) rotate(a=[-90,0,0]) pushfit_rod(pushfit_d,50);
 // Top pushfit rod
 translate(v=[-15,-41.5,rod_distance+7.5]) rotate(a=[-90,0,0]) pushfit_rod(pushfit_d,50);

 // the holes for the brass nut
 translate(v=[5.5,-24,4]) // <-- This is the offset from the smooth rod to the threaded rod (5.5,-24)
     union() { 
               // center post of brass nut
                   cylinder(h=10,r=5.45,$fn=50,center=true);
                   // holes for m3 screws in brass nut
                   #translate(v=[8,0,0]) cylinder(h=12,r=m3_hole_r,$fn=20,center=true);
                   #rotate([0,0,90]) translate(v=[8,0,0]) cylinder(h=12,r=m3_hole_r,$fn=20,center=true);
                   #rotate([0,0,180]) translate(v=[8,0,0]) cylinder(h=12,r=m3_hole_r,$fn=20,center=true);
                   #rotate([0,0,270]) translate(v=[8,0,0]) cylinder(h=12,r=m3_hole_r,$fn=20,center=true);
           }

}

// MODULE -------------------------------------
module pushfit_rod(diameter,length){
 // intentionally making the holes oblong in the Z direction to help with binding of the X axis
 translate([0,-0.2,0])  cylinder(h = length, r=diameter/2, $fn=30);
 translate([0,0.2,0])  cylinder(h = length, r=diameter/2, $fn=30);
}

// X END IDLER -----------------------------------------------------------
idler_offs_z = -1; // negative here means "up" when installed
idler_offs_y = 7;
M4_head_d = 8;

module x_end_idler_base(){
 x_end_base();
}

module x_end_idler_holes(){
 x_end_holes();
 translate([0,idler_offs_y,idler_offs_z]) {
   translate(v=[0,-22,30.25]) { 
    translate(v=[0,0,0])   rotate(a=[0,-90,0]) cylinder(h = 80, r=idler_bearing_inner_d/2+.3, $fn=30);
    translate(v=[6,0,0])   rotate(a=[0,-90,0]) cylinder(h = 12.5, r=M4_head_d/2+.1, $fn=30);
    translate(v=[-22,0,0]) rotate(a=[0,-90,0]) rotate(a=[0,0,30]) cylinder(h = 80, r=idler_bearing_inner_d, $fn=6);   

    // create a notch for the X tensioner, to improve the length of travel available
    translate(v=[-10,-20,1]) #difference() { rotate(a=[45,0,0])  cube(size=[30,22,22],center=true); 
                                             translate(v=[0,14,0]) cube(size=[31,4,8],center=true); }
   }
 }
}
 
// Final part
module x_end_idler(){
 mirror([0,1,0]) union() { 
      difference(){
  x_end_idler_base();
  x_end_idler_holes();
      }

difference() { 
union() { 
  // added ridges to keep the tensioner from pitching
  translate(v=[-10,1,center_z-tensioner_size_z/2 - .5]) rotate([0,0,90]) rotate([45,0,0]) cube(size=[20,1.25,1.25],center=true);
  translate(v=[-10,1,center_z+tensioner_size_z/2 + .5]) rotate([0,0,90]) rotate([45,0,0]) cube(size=[20,1.25,1.25],center=true);
  translate(v=[-20,1,center_z-tensioner_size_z/2 - .5]) rotate([0,0,90]) rotate([45,0,0]) cube(size=[20,1.25,1.25],center=true);
  translate(v=[-20,1,center_z+tensioner_size_z/2 + .5]) rotate([0,0,90]) rotate([45,0,0]) cube(size=[20,1.25,1.25],center=true);
} 
#translate(v=[0,0,-4]) cylinder(h = height+3, r=bearing_diameter/2 + bearing_cut_extra, $fn = 60);
}
}
}

// X END MOTOR ------------------------------------------------------------
offs_adjuster_y = 5.5;
adj_block_x = 12;
adj_block_y = 10;
adj_block_z = 32;
motor_offs_z = 0;
screw_head_r = 3.5;

module adjustomatic() { // small holder for a M3 screw pointing down toward the Z endstop

   difference() {     
       translate(v=[-(15+17/2+adj_block_x/2),offs_adjuster_y,height-adj_block_z/2]) 
          cube(size=[adj_block_x,adj_block_y,adj_block_z],center=true);
       
       translate(v=[-(15+17/2+adj_block_x/2)-5,offs_adjuster_y,height-adj_block_z/2-8]) 
         rotate([0,-30,0]) cube(size=[adj_block_x,adj_block_y+2,adj_block_z],center=true);

       translate(v=[-(15+17/2+adj_block_x/2-1),offs_adjuster_y,height-adj_block_z/2-3]) 
          cube(size=[adj_block_x,adj_block_y-2,adj_block_z-2],center=true);

       translate(v=[-(15+17/2+adj_block_x/2),offs_adjuster_y,height-adj_block_z/2+14]) 
           {
         rotate([0,0,30]) #cylinder(h = 4, r = 7.5/2 , $fn = 6);
         translate([0,0,-20]) #cylinder(h=30,r=m3_hole_r,$fn=16);
}

   }

}

// the endstop mount will be translated by this much (negative values mean it moves away 
// from the motor and toward the X carriage, giving more room for leads and also extra space
// for the auto bedleveling servo housing which is on this side of the extruder):
endstop_sw_offs_adjust = -5;

module pocket_endstop() // endstop holder grafted onto the side toward the rods
{
  translate([-7,-50,0]) 
    union() {
      // angled wall that attaches to the endstop holder
      translate([-1,18,0]) rotate([0,0,-30]) cube(size=[8.5,2,22]);
      // little bit of extra support at the bottom corner 
      translate([-1.5,15.,2]) rotate([0,90,0]) cube(size=[2,3,10]);
      
      difference() {
       translate([-1.5,endstop_sw_offs_adjust,0]) cube(size=[9,20.5,22]);
           
       translate([-2,endstop_sw_offs_adjust,1]) cube(size=[7,21,22]);
       #translate([0,15.5,8]) cube(size=[10,5,20]);

       // screw holes for endstop switch
       translate([-2,7+endstop_sw_offs_adjust,1.5+5.5]) rotate([0,90,0]) cylinder(r=1.5,h=15);
       translate([-2,7+endstop_sw_offs_adjust,1.5+5.5+9.5]) rotate([0,90,0]) cylinder(r=1.5,h=15);
      }
    }
}

module x_end_motor_base(){
   x_end_base();
   // motor arm
   translate(v=[-15,31,26.5+motor_offs_z]) cube(size = [17,44,53], center = true);
   // z stop adjuster
   adjustomatic();
   // x endstop holder
   pocket_endstop();

}

module x_end_motor_holes(){
 x_end_holes();
 // Position to place
 translate(v=[-1,32,30.25+motor_offs_z]){
  // Belt hole
  translate(v=[-14,1,0]) cube(size = [10,46,22], center = true);
  // Motor mounting holes
  translate(v=[20,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=m3_hole_r, $fn=30);
  translate(v=[1,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);
 

  translate(v=[20,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=m3_hole_r, $fn=30);
  translate(v=[1,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);


  translate(v=[20,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=m3_hole_r, $fn=30);
  translate(v=[1,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);


  #translate(v=[20,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=m3_hole_r, $fn=30);
  translate(v=[1,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 12, r=screw_head_r, $fn=30);

  // Material saving cutout 
  translate(v=[-10,12,10]) cube(size = [60,42,42], center = true);

  // Material saving cutout
  translate(v=[-10,40,-30]) rotate(a=[45,0,0])  cube(size = [60,42,42], center = true);
  // Motor shaft cutout
  translate(v=[0,0,0]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=17, $fn=6);

  // zip tie retainer for securing end stop wiring
  translate([-5,-63,16]) difference() { cylinder(r=4.5,h=4,$fn=16);
                                          translate([0,0,-1]) cylinder(r=2.5,h=7,$fn=16);
                                        }

  #translate([-5,-48,34]) rotate([90,0,0]) difference() { cylinder(r=4.5,h=4,$fn=16,center=true);
                                          translate([0,0,-1]) cylinder(r=2.5,h=7,$fn=16,center=true);
                                        }


 }
}

module x_end_motor_sr() {
    difference() { 
       cube(size=[8,12,10]);
       #translate([4,11.5,9]) rotate([0,90,0]) 
               difference() { cylinder(r=4.5,h=4,$fn=16,center=true);
                              translate([0,0,-1]) cylinder(r=2.5,h=7,$fn=16,center=true);
               }

        #translate([9,10.6,10]) rotate([0,45,90]) cube(size=[2,11,2]);
    }
}

// Final part
module x_end_motor(){
 difference(){
  x_end_motor_base();
  x_end_motor_holes();
 }
   // strain relief (zip tie point) below the motor 
   translate([-23.5,9,53]) x_end_motor_sr(); 

}

// Make parts
x_end_idler();
//translate([40,0,0]) rotate([0,0,180]) x_end_motor();







