/*
OPENSCAD Library file by the DoomMeister
Mounting surround for small DC fans (25 - 120mm)

Data taken from various places around the internet.
http://www.qwikflow.com/dc_fans.html

//Released under the terms of the GNU GPL v3.0
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

//uncomment this for example
fan_mount(size=40,thick=3);

module fan_mount(size=40,thick = 4)
{
if(size == 25)
	{
	_fan_mount(
			fan_size = 25,
			fan_mounting_pitch = 20,
			fan_m_hole_dia = 3,
			holder_thickness = thick
		 );
	}
if(size == 30)
	{
	_fan_mount(
			fan_size = 30,
			fan_mounting_pitch = 24,
			fan_m_hole_dia = 3,
			holder_thickness = thick
		 );
	}

if(size == 40)
	{
	_fan_mount(
			fan_size = 40,
			fan_mounting_pitch = 32,
			fan_m_hole_dia = 3.7,
			holder_thickness = thick
		 );
	}
if(size == 45)
	{
	_fan_mount(
			fan_size = 45,
			fan_mounting_pitch = 37,
			fan_m_hole_dia = 4.3,
			holder_thickness = thick
		 );
	}
if(size == 60)
	{
	_fan_mount(
			fan_size = 60,
			fan_mounting_pitch = 50,
			fan_m_hole_dia = 4.4,
			holder_thickness = thick
		 );
	}
if(size == 80)
	{
	_fan_mount(
			fan_size = 80,
			fan_mounting_pitch = 71.5,
			fan_m_hole_dia = 4.4,
			holder_thickness = thick
		 );
	}

if(size == 120)
	{
	_fan_mount(
			fan_size = 120,
			fan_mounting_pitch = 105,
			fan_m_hole_dia = 4.4,
			holder_thickness = thick
		 );
	}
}


//inner module
module _fan_mount(
			fan_size, //nominsl size of fan
			fan_mounting_pitch, //pitch between mounting holes
			fan_m_hole_dia, //mounting hole diameter
			holder_thickness //user defined thickness
		 )
{

offset1 = (fan_size-(fan_mounting_pitch + fan_m_hole_dia))/2;
offset2 = (fan_size-(fan_mounting_pitch))/2;
offset3 = offset2 + fan_mounting_pitch;
thickness = (fan_size-fan_mounting_pitch)/2;	
			
			//difference()
			//{
			linear_extrude(height = holder_thickness)
			union()
			{	
			difference()
			{
				translate([fan_m_hole_dia/2,fan_m_hole_dia/2,0])
				minkowski()
				{	
					square([fan_size - fan_m_hole_dia,fan_size - fan_m_hole_dia]);
					circle(r= fan_m_hole_dia/2, $fn=20);
				}
			
					translate([offset1,offset1,0])
					square([fan_mounting_pitch + fan_m_hole_dia,fan_mounting_pitch + fan_m_hole_dia]);
				}
				translate([offset2,offset2,0])
				rotate([0,0,0])_corner_hole();
				translate([offset3,offset2,0])
				rotate([0,0,90])_corner_hole();
				translate([offset2,offset3,0])
				rotate([0,0,90])_corner_hole();
				translate([offset3,offset3,0])
				rotate([0,0,0])_corner_hole();
			}

module _corner_hole()
{
				difference(){
					union(){
							difference(){
							square([fan_m_hole_dia + thickness,fan_m_hole_dia + thickness],center=true);
							square([(fan_m_hole_dia + thickness)/2,(fan_m_hole_dia + thickness)/2],center=false);
							translate([-(fan_m_hole_dia + thickness)/2,-(fan_m_hole_dia + thickness)/2])
							square([(fan_m_hole_dia + thickness)/2,(fan_m_hole_dia + thickness)/2],center=false);
							}
					circle(r=(fan_m_hole_dia + thickness)/2, $fn=20);
					}
					circle(r=(fan_m_hole_dia)/2, $fn=20);
				}
}


echo(offset1,offset2,thickness);
}

