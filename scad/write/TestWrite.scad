use <write.scad>

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
//------------------------Examples ----------------------------------------------------

   	use <write.scad> // Dont forget to include this line and the files
	//example1: Uses all declarations.. 
		translate([20,15,0])
		write("Example 1",t=4,h=5.75,center=true);

	//example2: Quick and easy
		write("That was easy!",h=12);

	//example3: move and rotate(front) (remember to translate..then rotate)
		translate([0,0,10]) 
		rotate(90,[1,0,0])  // rotate around the x axis
		write("Rotate +X 90 (front)",t=2);

	//example4: move and rotate(left side) 
		translate([0,0,20]) 
		rotate(90,[1,0,0])   // rotate around the x axis
		rotate(90,[0,-1,0])  // rotate around the y axis
		write("Rotate +X 90 and -Y 90 (left side)");

	//example5: move and rotate(right side) 
		translate([0,0,30]) 
		rotate(90,[1,0,0])   // rotate around the x axis
		rotate(90,[0,1,0])  // rotate around the y axis
		write("Rotate +X 90 and +Y 90 (right side)");	

	//example6: move and rotate(back) 
		translate([0,0,40]) 
		rotate(90,[1,0,0])   // rotate around the x axis
		rotate(180,[0,1,0])  // rotate around the y axis
		write("Rotate +X 90 and +Y 180 (back)");	


********************************************************
*/

translate([0,30,0])
write("abcdefghijklmn",t=10.5,h=10,center=true);translate([0,0,0])
translate([0,15,0])
write("opqrstuvwxyz",t=9,h=9,center=true);
translate([0,0,0])
write("~!@#$%^&*()_-+=",t=7.5,h=8,center=true);
translate([0,-15,0])
write(",./<>?;'`:[]{}|",t=6,h=7,center=true);
translate([0,-30,0])
write("ABCDEFGHIJKLMN",t=4.5,h=6,center=true);translate([0,0,0])
translate([0,-45,0])
write("OPQRSTUVWXYZ",t=3,h=5,center=true);
translate([0,-60,0])
write("\"",t=1.5,h=4,center=true);


