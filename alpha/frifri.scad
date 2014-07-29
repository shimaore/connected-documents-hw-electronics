
mm = 1;
cm = 10;


//projection(cut = true) translate([0,0,-20*mm])

module objet_complet() {
difference() {
  // The Wings3D model uses centimeters as units while OpenSCAD uses millimeters.
  %
  scale(v=[cm,cm,cm]) import("frifri.stl");

  // The cylinder must be at least 24.5mm into the object for the motor to fit in.
  // Also set the diameter to slightly larger than needed to account for 
  // shape/resolution of printing.
  #
  union() {
    // Hole for the motor.
    translate([0,-0.15*cm,1.9*cm])
    rotate([90,0,0])
    // Cylinder is created at origin towards +Z.
    // Note: diameter (specs) is 7mm.
    cylinder(h = 24.5*mm*2.0, r = (7/2+0.05)*mm, $fn=100);

    // Two transversal holes (diam=1.2mm) for the wires that connect to the motor.
    translate([+0.9,50,15.2])
    rotate([90,0,0])
    cylinder(h = 100*mm, r = 0.6*mm, $fn=100);
    translate([-0.9,50,15.2])
    rotate([90,0,0])
    cylinder(h = 100*mm, r = 0.6*mm, $fn=100);

    // Hole for electronics.
    translate([0,12,10*mm])
    scale([17,60,6])
    cube (size = 1, center = true);

    // Connections between the electronics hole and the motor wires hole.
    translate([0,41,12.0])
    cylinder(h = 4*mm, r = (0.6*2+0.9/2)*mm, $fn=100);

    // Ringy hole to put a security "pull" wire.
    translate([0,38,18])
    rotate([0,0,0])
    // Torus
    rotate_extrude(convexity = 10, $fn = 100)
    translate([5, 0, 0])
    circle(r = 1, $fn = 100);
  }
};
}

// Object printout
// Stéphane@RobotSeed a recommandé de couper en deux et de prévoir des emboîtements.

