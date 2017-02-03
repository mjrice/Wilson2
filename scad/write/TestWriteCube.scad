/*					

for these examples, assume we have the cube:
translate([10,20,30])
cube(30,center=true);	
-----------------------text  where and size--------------------------------
The values for text=, where= and size= are required, but if the 
values are entered in this order, then the commands are not 
required. These three examples produce the same results.

writecube(text="text", where=[10,20,30], size=[30,30,30]);
writecube("text",[10,20,30], [30,30,30]);
writecube("text",[10,20,30],30); 

text="whatever text you want to write"
where= the center coordinates of the box 
size = size of box. Either [xsize,ysize,zsize] or just size if its square

----------------------------face = ----------------------------------------
By default, writecube will write on the front of the box assuming 
x=left to right, y=front to back, z=bottom to top
to write on another side, use face="top","bottom","back","front",
"left" or "right"

writecube("Howdy!!",[10,20,30],30,face="left");

will print Howdy!! on the center left of the box.

-------------------- left, right, up, down---------------------------------
If you dont want it centered, use left=mm or up=mm or down...
These commands move the text along the plane in the givin
direction (in relation to the unrotated text) in specified milimeters.

writecube("HI!!",[10,20,30],30,face="top",up=5);

will write HI!! 5mm away from you along the top plane of the box

------------------------------- rotate -----------------------------------
You say you dont want the text aligned with the sides?
rotate = angle will fix that for you. It rotates the text clockwise
along the plane of the text.

writecube("Aloha!!",[10,20,30],30,face="front",down=8,rotate=-30);

------------------------- text size and thickness  -----------------------
t=how thick the text will be
h=height of the font or fontsize
if not specified, the text will be 4mm tall (upper case) 
and 1mm thick. (half inside and half outside the cube)

writecube("Hello!!",[10,20,30],30,face="right", t=2,h=4);

will write Hello!! on the right side of the cube with 1mm sticking out
Keep in mind, if a font is 2mm thick, 1mm will be inside the cube
or if its 4mm, 2mm will be inside.


*/

// press f5 to see transparent cube.. remove % from cube otherwise
use<write.scad>

     translate([10,20,30])
% cube(30,center=true);	

writecube("text",[10,20,30],30); 

writecube("Howdy!!",[10,20,30],30,face="left");

writecube("Aloha!!",[10,20,30],30,face="front",down=8,rotate=-30);

writecube("HI!!",[10,20,30],30,face="top",up=5);

writecube("Hello!!",[10,20,30],30,face="right", t=2,h=6);

writecube("Hola!!",[10,20,30],[30,30,30],face="back");

writecube("Salut!!",[10,20,30],[30,30,30],face="bottom");

























