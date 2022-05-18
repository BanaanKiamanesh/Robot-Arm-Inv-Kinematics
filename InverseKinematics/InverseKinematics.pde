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
  if (mouseX < width / 2)
    arm.plt.updateRot();

  else arm.updateRot();
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

  else if (key == 'z') {
    arm.rotX = 0;
    arm.rotY = 0;
    arm.plt.rotX = 0;
    arm.plt.rotY = 0;
  }
}
