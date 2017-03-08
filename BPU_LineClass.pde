/*
Draws lines on the projector given two endpoints. Inputs are converted from onscreen coordinates to the projector.
*/

class LineDrawer {
  
  Line lineinprogress;
  
  boolean point1complete;
  
  void reset() {
    lineinprogress = new Line(-1,-1,-1,-1);
    lineinprogress.visible = false;
    point1complete = false;
  }
  
  LineDrawer(){
    this.reset();
  }
  
  void mouseClicked(float x, float y){
    if (!point1complete){
      lineinprogress.x1 = x;
      lineinprogress.y1 = y;
      point1complete = true;
    } else {
      lineinprogress.x2 = x;
      lineinprogress.y2 = y;
      lineinprogress.visible = true;
      lines.add(lineinprogress);

      lineinprogress.draw();
      this.reset();
    }
  }
}

class Line {
  
  float x1, y1, x2, y2;
  int red, green, blue, brushSize;
  boolean visible;
  
  Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.red = rVal;
    this.green = gVal;
    this.blue = bVal;
    this.brushSize = penWidth;
    this.visible = true;
  }
  
  void draw() {
    if (visible) {
      float old_strokeWeight = g.strokeWeight;
      int old_strokeColor = g.strokeColor;
      strokeWeight(brushSize);
      stroke(color(red, green, blue));
      line(convertXCoord(x1), convertYCoord(y1), convertXCoord(x2), convertYCoord(y2));
      strokeWeight(old_strokeWeight);
      stroke(old_strokeColor);

      print(rVal);
      print(",");
      print(gVal);
      print(",");
      print(bVal);
      print("\n");

      print(red);
      print(",");
      print(green);
      print(",");
      print(blue);
      print("\n");
    }
  }
}
    
    