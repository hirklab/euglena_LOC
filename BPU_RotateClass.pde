/*
Given two corners of a rectangular region, the rectangular region rotates at a given speed (in radians/s)
*/

class Rotate {
    RotateWindow rotateinprogress;

    boolean centercomplete;

    void reset() {
        rotateinprogress = new RotateWindow(-1,-1,0,0);
        centercomplete = false;
    }

    Rotate(){
        centercomplete = false;
    }

    void mouseClicked(float x, float y){
        if (!centercomplete){
            rotateinprogress.centerx = x;
            rotateinprogress.centery = y;
            centercomplete = true;
        } else {
            rotateinprogress.radius = sqrt(pow(x - rotateinprogress.centerx, 2) + pow(y - rotateinprogress.centery, 2));
            rotateinprogress.speed = speed;
            rotateinprogress.millisInit = millis();
            rotateinprogress.saveRotateRegion();
            rotatewindows.add(rotateinprogress);
            this.reset();
        }
    }
}

class RotateWindow {
    float centerx, centery, radius, speed;
    int timeElapsed, millisInit;
    PImage rotateRegion;

    RotateWindow(float centerx, float centery, float radius, float speed) {
        this.centerx = centerx;
        this.centery = centery;
        this.radius = radius;
        this.speed = speed;
    }

    void saveRotateRegion() {
        this.rotateRegion = get(int(convertXCoord(centerx - radius)), int(convertYCoord(centery - radius)),
                                int(convertXDistance(2*radius)),int(convertYDistance(2*radius)));
    }

    void draw() {

        timeElapsed = millis() - millisInit;

        noFill();
        noStroke();
        rectMode(CENTER);
        rect(convertXCoord(centerx), convertYCoord(centery),
                convertXDistance(radius), convertYDistance(radius));

        pushMatrix();
        translate(convertXCoord(centerx), convertYCoord(centery));

        rotate(radians(speed*timeElapsed/1000));

        imageMode(CENTER);
        image(rotateRegion, 0, 0, convertXDistance(2*radius), convertYDistance(2*radius));

        popMatrix();
    }
}