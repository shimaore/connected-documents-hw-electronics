// All measures are centimeters because the Wings3D model uses those units.

pad = 1.05;

difference() {
  import("frifri proto object.stl");
  // The cylinder must be at least 2.45cm into the object for the motor to fit in. Also set the diameter to slightly larger than needed to account for shape/resolution of printing.
  cylinder(h = 2.5, r = 0.35*pad, $fs=0.002);
}