
pad = 1.05;
mm = 1;
cm = 10;


//projection(cut = true) translate([0,0,-20*mm])
difference() {
  // The Wings3D model uses centimeters as units while OpenSCAD uses millimeters.
  %
  scale(v=[cm,cm,cm]) import("frifri.stl");

  // The cylinder must be at least 24.5mm into the object for the motor to fit in.
  // Also set the diameter to slightly larger than needed to account for 
  // shape/resolution of printing.
#
union() {
  translate([0,+0.75*cm,1.7*cm])
  rotate([75,-5,0])
  // Cylinder is created at origin towards +Z.
  cylinder(h = 24.5*mm*2.0, r = 3.5*mm*pad, $fs=0.001);

  translate([0,20,10*mm])
  scale([12,40,4])
  cube (size = 1, center = true);
}
};
