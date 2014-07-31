// (c) 2014, Stéphane Alnet

mm = 1;
cm = 10;
roundout = 0.05;

electronics_y = -18*mm;
electronics_length = 50*mm;
holes_length = 60*mm;
motor_x = -3.0;
motor_y = -1.5;
keep_centered = 0;
rod_length = 51*mm;


module contenu() {
  union()
  {
    // 5mm rod that holds the pieces together.
    translate([3.1,rod_length/2,17])
    rotate([90,0,0])
    cylinder(h = rod_length, r = (4.5/2+0.05)*mm, $fn=100);

    // motor.
    translate([motor_x,motor_y,1.9*cm])
    rotate([90,0,0])
    cylinder(h = 27.7*mm, r = (7/2+0.05)*mm, $fn=100);

    // Two transversal holes (diam=1.2mm) for the wires that connect to the motor.
    translate([motor_x+0.9,holes_length/2,15.2])
    rotate([90,0,0])
    cylinder(h = holes_length, r = 0.6*mm, $fn=100);
    translate([motor_x-0.9,holes_length/2,15.2])
    rotate([90,0,0])
    cylinder(h = holes_length, r = 0.6*mm, $fn=100);

    // electronics.
    translate([keep_centered,electronics_y+electronics_length/2,10*mm])
    scale([17.1,electronics_length,6])
    cube (size = 1, center = true);
  }
}

// Wings3D uses X-Z ground plane while OpenSCAD uses X-Y ground plane.
rotate([-90,0,0])
// Edit inside Wings3D using centimeters.
scale([0.1,0.1,0.1])
union() {
  // recenter, resize, then reposition
  // the bottom of the structure is the bottom of the electronics, which is at 10-6 = 4mm
  // the top is the top of the motor, which is at 1.9+7/2
  // this means we offset from origin is (4+1.9+7/2)/2 = 4.7mm
  translate([0,0,4.7*mm])
  // scale([1.2,1.2,1.2])
  translate([0,0,-4.7*mm])
  contenu();
}
