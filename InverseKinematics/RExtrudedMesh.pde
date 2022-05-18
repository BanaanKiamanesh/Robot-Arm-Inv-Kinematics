class RExtrudedMesh
{
  float depth = 10;
  RPoint[][] points;
  RMesh m;

  //////////////////////////////////////////////////////////////////// Constructor
  RExtrudedMesh(RShape grp, float d)
  {
    depth = d;
    m = grp.toMesh();
    points = grp.getPointsInPaths();
  }


  //////////////////////////////////////////////////////////////////// Draw The Whole Text
  void draw()
  {
    // Draw front
    for (int i=0; i<m.countStrips(); i++) {
      beginShape(TRIANGLE_STRIP);
      for (int j=0; j<m.strips[i].vertices.length; j++) {
        vertex(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, 0);
      }
      endShape(CLOSE);
    }

    // Draw back
    for (int i=0; i<m.countStrips(); i++) {
      beginShape(TRIANGLE_STRIP);
      for (int j=0; j<m.strips[i].vertices.length; j++) {
        vertex(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, -depth);
      }
      endShape(CLOSE);
    }

    // Draw side (from outline points)
    for (int i=0; i<points.length; i++) {
      beginShape(TRIANGLE_STRIP);
      for (int j=0; j<points[i].length-1; j++)
      {
        vertex(points[i][j].x, points[i][j].y, 0);
        vertex(points[i][j].x, points[i][j].y, -depth);
        vertex(points[i][j+1].x, points[i][j+1].y, -depth);
        vertex(points[i][j].x, points[i][j].y, 0);
        vertex(points[i][j+1].x, points[i][j+1].y, 0);
      }
      vertex(points[i][0].x, points[i][0].y, 0);
      endShape(CLOSE);
    }
  }
}
