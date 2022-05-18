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
  {    
    arm.plt.rotY -= (mouseX - pmouseX) * arm.dt;
    arm.plt.rotX -= (mouseY - pmouseY) * arm.dt;
  } else {
    arm.rotY -= (mouseX - pmouseX) * arm.dt;
    arm.rotX -= (mouseY - pmouseY) * arm.dt;
  }
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
    arm.rotX = 0;
    arm.rotY = 0;
  }
}
