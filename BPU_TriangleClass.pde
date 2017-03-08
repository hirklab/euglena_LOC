/*
Draws lines on the projector given three vertices. Inputs are converted from onscreen coordinates to the projector.
*/

class TriangleDrawer {

    Triangle triangleinprogress;

    boolean point1complete;
    boolean point2complete;

    void reset() {
        triangleinprogress = new Triangle(-1,-1,0,0,1,1);
        triangleinprogress.visible = false;
        point1complete = false;
        point2complete = false;

    }

    TriangleDrawer(){
        this.reset();
    }

    void mouseClicked(float x, float y){
        if (!point1complete){
            triangleinprogress.point1x = x;
            triangleinprogress.point1y = y;
            point1complete = true;

        } else if (!point2complete) {
            triangleinprogress.point2x = x;
            triangleinprogress.point2y = y;
            point2complete = true;

        } else {
            triangleinprogress.point3x = x;
            triangleinprogress.point3y = y;
            triangleinprogress.visible = true;
            triangles.add(triangleinprogress);

            triangleinprogress.draw();
            this.reset();
        }
    }
}

class Triangle {

    float point1x, point1y, point2x, point2y, point3x, point3y;
    int red, green, blue, brushSize;
    boolean visible;

    Triangle(float point1x, float point1y, float point2x, float point2y, float point3x, float point3y) {
        this.point1x = point1x;
        this.point1y = point1y;
        this.point2x = point2x;
        this.point2y = point2y;
        this.point3x = point3x;
        this.point3y = point3y;
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
            noFill();

            triangle(convertXCoord(point1x), convertYCoord(point1y), convertXCoord(point2x), convertYCoord(point2y),
                     convertXCoord(point3x), convertYCoord(point3y));
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