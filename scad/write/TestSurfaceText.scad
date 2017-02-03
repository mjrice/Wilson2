/*
********************************************************
By Harlan Martin
harlan@sutlog.com
January 2012

	1...	The quote " symbol cannot be inserted into a string alone
		Either use \"  or just the single quote' will show as "

	2...	The \ is used for special text characters, so use the bar | to 
		show the back slash \ 
------------------------------------------------------------------------------------
	Usage...

	write("my text",t=3,h=5,center=true);

	(t) (optional) The thickness of the letters in mm. 
		The default is 1mm if not specified

	(h)(optional)  The height of the letters in mm. 
		The default is 8mm if not specified

	(center) (optional) Centers the text at default coordinates.

	Put the files (write.scad) and (letters.dfx) in the 
		working directory with your project
------------------------------------------------------------------------------------------



********************************************************
*/
include <write.scad>

// remember when centered, the text is centered on the [x,y,z] vector
// if you place centered text on the surface,half is inside, half is out
difference(){
	translate([0,0,0])
	cube(20,center=true);

	translate([0,-10,0])
	rotate(90,[1,0,0])
	write("Indented Text",h=2,t=1,center=true);

	translate([0,0,-6])
	rotate(90,[1,0,0])
	write("Cut",h=8,t=30,center=true);
}

translate([0,-10,7])
rotate(90,[1,0,0])
write("Raised Text",h=2,t=1,center=true);
