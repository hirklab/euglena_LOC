/*
Draws ellipses on the projector given a center point, width, and height. Inputs are converted from onscreen coordinates to the projector.
*/

class EllipseDrawer {

    Ellipse ellipseinprogress;

    boolean centerpointcomplete;
    boolean widthcomplete;

    void reset() {
        ellipseinprogress = new Ellipse(-1,-1,0,0);
        ellipseinprogress.visible = false;
        centerpointcomplete = false;
        widthcomplete = false;

    }

    EllipseDrawer(){
        this.reset();
    }

    void mouseClicked(float x, float y){
        if (!centerpointcomplete){
            ellipseinprogress.centerx = x;
            ellipseinprogress.centery = y;
            centerpointcomplete = true;

        } else if (!widthcomplete) {
            ellipseinprogress.width = abs(ellipseinprogress.centerx - x) * 2;
            widthcomplete = true;

        } else {
            ellipseinprogress.height = abs(ellipseinprogress.centery - y) * 2;
            ellipseinprogress.visible = true;
            ellipses.add(ellipseinprogress);

            ellipseinprogress.draw();
            this.reset();
        }
    }
}

class Ellipse {

    float centerx, centery, width, height;
    int red, green, blue, brushSize;
    boolean visible;

    Ellipse(float centerx, float centery, float width, float height) {
        this.centerx = centerx;
        this.centery = centery;
        this.width = width;
        this.height = height;
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

            ellipseMode(CENTER);
            strokeWeight(brushSize);
            stroke(color(red, green, blue));
            noFill();

            ellipse(convertXCoord(centerx), convertYCoord(centery), convertXDistance(width), convertYDistance(height));
            strokeWeight(old_strokeWeight);
            stroke(old_strokeColor);

            /*
            print(rVal);
            print(",");
            print(gVal);
            print(",");
            print(bVal);
            print("\n");
            */

            /*
            print(convertXCoord(centerx));
            print("\n");
            print(convertYCoord(centery));
            print("\n");
            print(convertXDistance(width));
            print("\n");
            print(convertYDistance(height));
            print("\n");
            */
        }
    }
}