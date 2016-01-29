
/* NOTES:
	writecylinder(text="text",where=[0,0,0],radius=20,height=40);
	
	Required Parameters (If supplied in this order, identifier is not required)
		text="text"	 	: Text to be written
		where=[x,y,z]	: coordinates of cylinder
		radius=mm 		: radius of cylinder
		height=mm 		: height of cylinder

	Optional Parameter:
		center=boolean :	use this to specify that cylinder is centered on coordinates
					(default is center=false)
		face="top" : Top of cylinder
		face="bottom": bottom of cylinder
		face="front" :barrel of cylinder (default if not supplied)	

	Optional Parameters: (face is not "top" or "bottom")
		east=degrees : west= degrees: (moves text east or west around z)
		up=mm or down=mm : moves text up or down along Z axis
		rotate=degrees : rotates text around Y axis (spirals around cylinder)
	
	Optional Parameters: (face="top" or face="bottom")
		east=degrees or west=degrees : rotate text east or west around top
		rotate=degrees : (similar to east west but not dependant on text orientation)
		ccw=boolean : If true, writes in a counter clockwise direction. (default=false)
		middle=mm :moves the text ?mm toward center of top or bottom surface 	

*/


use <write.scad>

translate([0,0,0])
%cylinder(r=20,h=40);

writecylinder("rotate=90",[0,0,0],20,40,rotate=90);

writecylinder("rotate = 30,east = 90",[0,0,0],20,40,space=1.2,rotate=30,east=90);

writecylinder("ccw = true",[0,0,0],20,40,face="top",ccw=true);

writecylinder("middle = 8",[0,0,0],20,40,h=3,face="top",middle=8);

writecylinder("face = top",[0,0,0],20,40,face="top");

writecylinder("east=90",[0,0,0],20,40,h=3,face="top",east=90);

writecylinder("west=90",[0,0,0],20,40,h=3,face="top",ccw=true,west=90);

writecylinder("face = bottom",[0,0,0],20,40,face="bottom"); 
































