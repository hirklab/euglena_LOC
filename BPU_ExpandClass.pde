/*
Given two corners of a rectangular region, the rectangular region expands at a given speed (in pixel/s)
*/

class Expand {
    ExpandWindow expandinprogress;

    boolean corner1complete;

    void reset() {
        expandinprogress = new ExpandWindow(-1,-1,0,0,0);
        corner1complete = false;
    }

    Expand(){
        corner1complete = false;
    }

    void mouseClicked(float x, float y){
        if (!corner1complete){
            expandinprogress.corner1x = x;
            expandinprogress.corner1y = y;
            corner1complete = true;
        } else {
            expandinprogress.corner2x = x;
            expandinprogress.corner2y = y;
            expandinprogress.speed = speed;
            expandinprogress.millisInit = millis();
            expandinprogress.saveExpandRegion();
            expandwindows.add(expandinprogress);
            this.reset();
        }
    }
}

class ExpandWindow {
    float corner1x, corner1y, corner2x, corner2y, speed;
    int timeElapsed, millisInit;
    PImage expandRegion;

    ExpandWindow(float corner1x, float corner1y, float corner2x, float corner2y, float speed) {
        this.corner1x = corner1x;
        this.corner1y = corner1y;
        this.corner2x = corner2x;
        this.corner2y = corner2y;
        this.speed = speed;
    }

    float aspectRatio() {
        return abs((corner2x - corner1x) / (corner2y - corner1y));
    }

    float centerx() {
        return (corner1x + corner2x) / 2;
    }

    float centery() {
        return (corner1y + corner2y) / 2;
    }

    void saveExpandRegion() {
        this.expandRegion = get(int(convertXCoord(corner1x)), int(convertYCoord(corner1y)),
                                int(convertXDistance(corner2x - corner1x)),int(convertYDistance(corner2y - corner1y)));
    }

    void draw() {

        timeElapsed = millis() - millisInit;

        if (convertYDistance(corner2y - corner1y) + speed * (timeElapsed / 1000) < convertYDistance(screenHeight)) {

            noFill();
            noStroke();
            rectMode(CORNER);
            rect(convertXCoord(corner1x), convertYCoord(corner1y),
                    convertXDistance(corner2x - corner1x), convertYDistance(corner2y - corner1y));


            imageMode(CENTER);
            image(expandRegion, convertXCoord(this.centerx()), convertYCoord(this.centery()),
                    convertXDistance(corner2x - corner1x) + speed * this.aspectRatio() * (timeElapsed / 1000),
                    convertYDistance(corner2y - corner1y) + speed * (timeElapsed / 1000));
                    


        }
    }
}