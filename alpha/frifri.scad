
mm = 1;
cm = 10;
roundout = 0.05;

electronics_y = -18;
motor_y = -1.5;
keep_centered = 0;

module objet_complet() {
  difference() {
    // The Wings3D model uses centimeters as units while OpenSCAD uses millimeters.
    // %
    scale(v=[cm,cm,cm]) import("frifri.stl");

    // The cylinder must be at least 24.5mm into the object for the motor to fit in.
    // Also set the diameter to slightly larger than needed to account for 
    // shape/resolution of printing.
    // #
    union() {
      // Hole for the motor.
      translate([keep_centered,motor_y,1.9*cm])
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
      translate([keep_centered,electronics_y+30,10*mm])
      scale([17,60,6])
      cube (size = 1, center = true);

      // Connections between the electronics hole and the motor wires hole.
      translate([keep_centered,41,12.0])
      cylinder(h = 4*mm, r = (0.6*2+0.9/2)*mm, $fn=100);

      // Ringy hole to put a security "pull" wire.
      translate([keep_centered,38,18])
      rotate([0,0,0])
      union () {
        // Torus
        rotate_extrude(convexity = 10, $fn = 100)
        translate([5, 0, 0])
        circle(r = 1, $fn = 100);

        rotate([0,0,180])
        translate([-4.0,4.5,0])

        scale([8,3.5,2.2])
        translate([0.5,0,0])
        intersection() {
          rotate([45,0,0])
          cube (size = 1, center = true);
          translate([0,-1,0])
          cube (size = 2, center = true);
        }
      }

    }
  };
};


// Object printout
// Stéphane@RobotSeed a recommandé de couper en deux et de prévoir des emboîtements.
cut_size = 60;
module cut(position,offset) {
  translate([keep_centered,position-cut_size/2-offset,cut_size/2-roundout])
  scale([cut_size,cut_size,cut_size])
  cube (size = 1, center = true);
};

module cut_a(offset) { cut(electronics_y,offset); };
module cut_b(offset) { cut(motor_y,offset); };

module ergot(position,size,offset) {
  translate([offset,position+size/2-roundout,17])
  scale([size,size,size])
  cube (size = 1, center = true);
}

//projection(cut = true) translate([0,0,-20*mm])

module piece_1() {
  intersection() {
    objet_complet();
    cut_a(roundout);
  }
}

module piece_2() {
  union() {
    intersection() {
      difference() {
        objet_complet();
        cut_a(-roundout);
      }
      cut_b(roundout);
    }
    ergot(motor_y,2-roundout,-4.7);
    ergot(motor_y,2-roundout,+4.7);
  }
}

module piece_3() {
  // intersection() {
  difference() {
    objet_complet();
    cut_b(-roundout);
    ergot(motor_y,2+roundout,-4.7);
    ergot(motor_y,2+roundout,+4.7);
  }
  // cut(34.95,0); }
}

// Put piece 1 onto the ground.
translate([0,0,electronics_y-roundout])
rotate([-90,0,0])
piece_1();

// Put piece 2 onto the ground.
translate([0,0,-electronics_y-roundout])
rotate([90,0,0])
piece_2();

// Put piece 3 onto the ground.
translate([25,10,-motor_y-roundout])
rotate([90,0,0])
piece_3();
