Arm arm;

void setup() {
  fullScreen(P3D);
  smooth(8);
  arm = new Arm();
}


void draw() {
  background(50);
  arm.update();
}

// Canvas View Rotation Due to Mouse Drag
void mouseDragged() {
  arm.updateRot();
}

// Mode Indication
void keyPressed() {
  if (key == 'l')
    arm.setMode("Line");

  else if (key == 'e')
    arm.setMode("Ellipse");

  else if (key == 'r')
    arm.setMode("Rand");

  else if (key == 'i')
    arm.setMode("Inf");
}
