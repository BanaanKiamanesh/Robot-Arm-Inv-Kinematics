class Plot {

  float rotX = 0, rotY = 0;

  // Shape Path Effects Spheres
  float[] Xsphere = new float[200];
  float[] Ysphere = new float[200];
  float[] Zsphere = new float[200];

  Plot() {
    rectMode(CORNER);
  }

  void update() {
    lights();
    translate(width * 0.3, height / 2); 

    pushMatrix();
    rotateY(this.rotY);
    rotateX(this.rotX);

    for (int i = 0; i < this.Xsphere.length; i++) {
      pushMatrix();
      translate(this.Ysphere[i] * 2, this.Zsphere[i] * 2, this.Xsphere[i] * 2);
      fill(#FFFFFF);
      sphere(5);
      popMatrix();
    }

    stroke(255, 150, 150, 80);
    fill(255, 15);
    this.plane();
    this.drawArrow(-15 * 20, 0, 30 * 20, 0);

    stroke(150, 255, 150, 80);
    fill(255, 15);
    rotateX(HALF_PI);
    this.plane();
    this.drawArrow(0, -15 * 20, 30 * 20, 90);

    stroke(150, 150, 255, 80);
    fill(255, 15);
    rotateY(HALF_PI);
    this.plane();
    this.drawArrow(15 * 20, 0, 30 * 20, 180);

    popMatrix();

    translate(-width * 0.3, -height / 2);
  }

  void drawArrow(int cx, int cy, int len, float angle) {
    pushMatrix();
    strokeWeight(10);
    translate(cx, cy);
    rotate(radians(angle));
    line(0, 0, len, 0);
    line(len, 0, len - 20, -20);
    line(len, 0, len - 20, 20);
    popMatrix();
  }

  void plane() {
    strokeWeight(1);
    for (int y = -13; y < 13; y++) 
      for (int x = -13; x < 13; x++)
        rect(20 * x, 20 * y, 20, 20);
  }

  void drawPoints(float posX, float posY, float posZ) {

    for (int i = 0; i< this.Xsphere.length - 1; i++) {
      this.Xsphere[i] = this.Xsphere[i + 1];
      this.Ysphere[i] = this.Ysphere[i + 1];
      this.Zsphere[i] = this.Zsphere[i + 1];
    }

    this.Xsphere[this.Xsphere.length - 1] = posX;
    this.Ysphere[this.Ysphere.length - 1] = posY;
    this.Zsphere[this.Zsphere.length - 1] = posZ;
  }


  void updateRot() {
    this.rotY -= (mouseX - pmouseX) * arm.dt;
    this.rotX -= (mouseY - pmouseY) * arm.dt;
  }
}
