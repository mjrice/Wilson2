// include a ruler

use <write/write.scad>

module ruler(length = 150, t=[0,0,0], r=[0,0,0])
{
	mark_width = 0.125;
	mark_depth = 0.05;

	rotate(r) translate(t) union()
	{
		color("black") cube( [mark_depth-0.01, length, 8] );
		for ( i = [1:length-1] )
		{
			if (i % 10 == 0)	// tall one every 10
			{
				translate( [0, i, 0] ) color("white") cube( [mark_depth, mark_width, 7 ] );
				translate( [0, i+(2*mark_width), 6.5] ) rotate([90,0,90]) color("white") write(str(i), t=mark_depth, h=1, font="write/orbitron.dxf");
			}
			else if (i % 5 == 0)	// med. tall one every 5
				translate( [0, i, 0] ) color("white") cube( [mark_depth, mark_width, 5 ] );
			else	// otherwise a short one
				translate( [0, i, 0] ) color("white") cube( [mark_depth, mark_width, 3 ] );
		}
	}
}

module yruler(length = 150)
{
	ruler(length);
}

module xruler(length = 150)
{
	ruler(length, r=[0,0,-90]);
}

module zruler(length = 150)
{
	ruler(length, r=[90,0,-45]);
}

module xyzruler(length = 150)
{
	xruler(length);
	yruler(length);
	zruler(length);
}