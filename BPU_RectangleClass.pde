/*
Draws lines on the projector given two corners. Inputs are converted from onscreen coordinates to the projector.
*/

class RectangleDrawer {

    Rectangle rectangleinprogress;

    boolean corner1complete;

    void reset() {
        rectangleinprogress = new Rectangle(-1,-1,0,0);
        rectangleinprogress.visible = false;
        corner1complete = false;

    }

    RectangleDrawer(){
        this.reset();
    }

    void mouseClicked(float x, float y){
        if (!corner1complete){
            rectangleinprogress.corner1x = x;
            rectangleinprogress.corner1y = y;
            corner1complete = true;

        } else {
            rectangleinprogress.corner2x = x;
            rectangleinprogress.corner2y = y;
            rectangleinprogress.visible = true;
            rectangles.add(rectangleinprogress);

            rectangleinprogress.draw();
            this.reset();
        }
    }
}

class Rectangle {

    float corner1x, corner1y, corner2x, corner2y;
    int red, green, blue, brushSize;
    boolean visible;

    Rectangle(float corner1x, float corner1y, float corner2x, float corner2y) {
        this.corner1x = corner1x;
        this.corner1y = corner1y;
        this.corner2x = corner2x;
        this.corner2y = corner2y;
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

            rectMode(CORNERS);
            strokeWeight(brushSize);
            stroke(color(red, green, blue));
            fill(int(bgVal*rbgValMod), int(bgVal*gbgValMod), int(bgVal*bbgValMod));

            rect(convertXCoord(corner1x), convertYCoord(corner1y), convertXCoord(corner2x), convertYCoord(corner2y));
            strokeWeight(old_strokeWeight);
            stroke(old_strokeColor);

            print(rVal);
            print(",");
            print(gVal);
            print(",");
            print(bVal);
            print("\n");


            /*
            print(convertXCoord(corner1x));
            print("\n");
            print(convertYCoord(corner1y));
            print("\n");
            print(convertXCoord(corner2x));
            print("\n");
            print(convertYCoord(corner2y));
            print("\n");
            */
        }
    }
}