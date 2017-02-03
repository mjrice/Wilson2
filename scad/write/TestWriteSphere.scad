use<write.scad>;

// writesphere(text="text",where=[0,0,0],radius=radius of sphere);

//assuming z+ = north
//rotate(angle,[1,0,0]) // will move text north or south
//rotate(angle,[0,1,0]) // will rotate text like a clock hand
//rotate(angle,[0,0,1]) // will move text east or west

//detailed useage is in the WriteScadDoc
//rounded=true makes the face of the letters rounded, but takes longer to render

%sphere(10);
writesphere("Hello World",[0,0,0],10,spin=-45,north=30,east=10);
