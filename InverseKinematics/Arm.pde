class Arm {
  // Shape Imports
  PShape base, shoulder, upArm, loArm, end;

  // Maximum Arm Length
  int MAX_ARM_LENGTH = 120;

  // End Effector Positions
  float posX, posY, posZ;
  float tmpX, tmpY, tmpZ;

  // Canvas and Link Rotation Params
  float rotX = 0, rotY = 0;
  float alpha, beta, gamma;

  // Time Specs
  float F = 50;
  float T = 70;
  float millisOld, gTime, gSpeed = 4;

  // Shape Size Params
  float paramX = 0, paramZ = 0;

  // Rotation Mode
  String mode = "Rand";

  // Shape Path Effects Spheres
  float[] Xsphere = new float[50];
  float[] Ysphere = new float[50];
  float[] Zsphere = new float[50];

  // Time Passed between rendered Frames
  double dt = 0; 

  Plot plt;

  //////////////////////////////////////////////////////////////////// Constructor
  Arm() {
    // Import 3D Objects
    this.base = loadShape("r5.obj");
    this.shoulder = loadShape("r1.obj");
    this.upArm = loadShape("r2.obj");
    this.loArm = loadShape("r3.obj");
    this.end = loadShape("r4.obj");

    // Disable Style
    this.shoulder.disableStyle();
    this.upArm.disableStyle();
    this.loArm.disableStyle();

    this.genRandomPos();
    this.posX = this.tmpX;
    this.posY = this.tmpY;
    this.posZ = this.tmpZ;

    this.plt = new Plot();

    println("End Effector Position: X = ", posX, "Y = ", posY);
  }

  //////////////////////////////////////////////////////////////////// Update the Robot in the Graphical Canvas 
  void update() {

    this.plt.update();

    this.pose();
    lights();
    directionalLight(51, 102, 126, -1, 0, 0);

    noStroke();
    translate(width * 0.7, height/2);
    rotateX(this.rotX);
    rotateY(-this.rotY);
    scale(-4);

    this.drawPath(5);

    this.setPose(this.gamma, this.alpha, this.beta);

    if (this.mode != "Rand") {
      this.tmpY = 50;          // Draw End Effector Shapes in a Fixed Y 
      this.paramX = map(mouseX, 0, width, 5, 120);
      this.paramZ = map(mouseY, 0, height, 5, 120);
    }

    this.dt = 1 / frameRate;  // Time Taken Between Each Frame

    // Print the Current End Effector Pos in the Terminal
    println("End Effector Position: X = ", posX, "Y = ", posY);
  }

  //////////////////////////////////////////////////////////////////// Generate a Random Pos for the End Effector 
  void genRandomPos() {
    float r = random(MAX_ARM_LENGTH * 0.25, MAX_ARM_LENGTH * 0.95);
    float theta = random(0, 2 * PI);
    float phi = random(PI / 8, PI / 2);

    this.tmpX = r * cos(theta) * cos(phi);
    this.tmpY = r * sin(theta) * cos(phi);
    this.tmpZ = -r * sin(phi);
  }

  //////////////////////////////////////////////////////////////////// Calculate the Inv Kinematics
  void InvKinematics() {
    float X = posX;
    float Y = posY;
    float Z = posZ;
    float L = sqrt(Y*Y + X*X);
    float R = sqrt(Z*Z + L*L);

    this.alpha = PI/2 - (atan2(L, Z) + acos((this.T * this.T - this.F * this.F - R*R)/(-2 * this.F * R)));
    this.beta = -PI + acos((R*R - this.T * this.T - this.F * this.F)/(-2 * this.F * this.T));
    this.gamma = atan2(Y, X);
  }

  //////////////////////////////////////////////////////////////////// Generate time for the Sine and Cos Waves in [0, 4]s Interval
  void setTime() {
    this.gTime += ((float)millis()/1000 - this.millisOld) * (this.gSpeed/4);

    if (this.gTime >= 4) 
      this.gTime = 0;

    this.millisOld = (float)millis()/1000;
  }

  //////////////////////////////////////////////////////////////////// Navigate the Inv Kinematics based on the Mode
  void pose() {
    this.InvKinematics();
    this.setTime();

    if (mode == "Ellipse") {
      this.tmpX = cos(this.gTime * PI) * this.paramX;
      this.tmpZ = sin(this.gTime * PI) * this.paramZ;
    } 

    if (this.mode == "Line") {
      this.tmpX = sin(this.gTime * PI) * this.paramX;
      this.tmpZ = sin(this.gTime * PI) * this.paramZ;
    } 

    if (this.mode == "Inf") {
      this.tmpX = sin(this.gTime * PI / 2) * this.paramX;
      this.tmpZ = sin(this.gTime * PI) * this.paramZ;
    } 

    if (this.mode == "Rand") 
      if (this.gTime % 1 == 0)
        this.genRandomPos();

    // Path Smoothing for the End Effector Movement
    this.posX += (this.tmpX - this.posX) * this.dt;
    this.posY += (this.tmpY - this.posY) * this.dt;
    this.posZ += (this.tmpZ - this.posZ) * this.dt;
  }

  //////////////////////////////////////////////////////////////////// Set Update Maneuvre Mode
  void setMode(String mode) {
    this.mode = mode;
  }

  //////////////////////////////////////////////////////////////////// Update Canvas View Angle
  void updateRot() {
    this.rotY -= (mouseX - pmouseX) * this.dt;
    this.rotX -= (mouseY - pmouseY) * this.dt;
  }

  //////////////////////////////////////////////////////////////////// Apply the Kinematics and Draw it on the Canvas!
  void setPose(float gamma, float alpha, float beta) {

    fill(#709AE0);
    translate(0, -40, 0); 
    shape(this.base);

    translate(0, 4, 0);
    rotateY(gamma);
    shape(this.shoulder);

    translate(0, 25, 0);
    rotateY(PI);
    rotateX(alpha);
    shape(this.upArm);

    translate(0, 0, 50);
    rotateY(PI);
    rotateX(beta);
    shape(this.loArm);

    translate(0, 0, -50);
    rotateY(PI);
    shape(this.end);
  }

  //////////////////////////////////////////////////////////////////// Draw the Path With the Disappearing Spheres 
  void drawPath(float size) {
    // size: Ball size is recommended to be in the interval of [1 to 10]

    for (int i = 0; i< this.Xsphere.length - 1; i++) {
      this.Xsphere[i] = this.Xsphere[i + 1];
      this.Ysphere[i] = this.Ysphere[i + 1];
      this.Zsphere[i] = this.Zsphere[i + 1];
    }

    this.Xsphere[this.Xsphere.length - 1] = this.posX;
    this.Ysphere[this.Ysphere.length - 1] = this.posY;
    this.Zsphere[this.Zsphere.length - 1] = this.posZ;

    // Add the New Point into the Plot
    this.plt.drawPoints(posX, posY - 11, posZ);

    for (int i = 0; i < this.Xsphere.length; i++) {
      pushMatrix();
      translate(-this.Ysphere[i], -this.Zsphere[i]-11, -this.Xsphere[i]);
      fill(#D003FF, 25);
      sphere(size);
      popMatrix();
    }
  }
}
