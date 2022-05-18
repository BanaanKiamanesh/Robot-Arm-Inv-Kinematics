class Plot {

  float rotX = -PI/12, rotY = -PI/12;

  // Shape Path Effects Spheres
  float[] Xsphere = new float[200];
  float[] Ysphere = new float[200];
  float[] Zsphere = new float[200];

  Plot() {
    rectMode(CENTER);
  }

  void update() {
    lights();
    translate(width * 0.3, height / 2); 

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

    stroke(150, 255, 150, 80);
    fill(255, 15);
    rotateX(HALF_PI);
    this.plane();

    stroke(150, 150, 255, 80);
    fill(255, 15);
    rotateY(HALF_PI);
    this.plane();

    rotateY(-HALF_PI);
    rotateX(-HALF_PI);

    rotateX(-this.rotX);
    rotateY(-this.rotY);

    translate(-width * 0.3, -height / 2);
  }

  void plane() {
    for (int y = -12; y < 13; y++) 
      for (int x = -12; x < 13; x++)
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
}
