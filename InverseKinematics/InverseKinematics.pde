import geomerative.*;

RFont f;
RShape grp;
RExtrudedMesh em;

Arm arm;

void setup() {
  fullScreen(P3D);

  // Enable smoothing
  smooth(8);

  RG.init(this);

  // RG Specs
  grp = RG.getText("Banaan Kiamanesh", "FreeSansBoldOblique.ttf", 30, CENTER);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(1);

  em = new RExtrudedMesh(grp, 20);

  arm = new Arm();
}

void draw() {
  background(50);

  pushMatrix();
  lights();
  translate(width/2, height * 0.25, 200);
  rotateY(millis()/2000.0);

  fill(255, 100, 0);
  noStroke();
  em.draw();
  popMatrix();
  //translate(-width/2, -height/2, -200);
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
