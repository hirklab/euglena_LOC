/*
Given two corners of a rectangular region, the rectangular region shrinks at a given speed (in pixel/s)
*/


class Shrink {
    ShrinkWindow shrinkinprogress;

    boolean corner1complete;

    void reset() {
        shrinkinprogress = new ShrinkWindow(-1,-1,0,0,0);
        corner1complete = false;
    }

    Shrink(){
      corner1complete = false;
    }

    void mouseClicked(float x, float y){
        if (!corner1complete){
            shrinkinprogress.corner1x = x;
            shrinkinprogress.corner1y = y;
            corner1complete = true;
        } else {
            shrinkinprogress.corner2x = x;
            shrinkinprogress.corner2y = y;
            shrinkinprogress.speed = speed;
            shrinkinprogress.millisInit = millis();
            shrinkinprogress.saveShrinkRegion();
            shrinkwindows.add(shrinkinprogress);
            this.reset();
        }
    }
}

class ShrinkWindow {
    float corner1x, corner1y, corner2x, corner2y, speed;
    int timeElapsed, millisInit;
    PImage shrinkRegion;

    ShrinkWindow(float corner1x, float corner1y, float corner2x, float corner2y, float speed) {
        this.corner1x = corner1x;
        this.corner1y = corner1y;
        this.corner2x = corner2x;
        this.corner2y = corner2y;
        this.speed = speed;
    }

    float aspectRatio() {
        return abs((corner2x-corner1x)/(corner2y-corner1y));
    }

    float centerx() {
        return (corner1x + corner2x) / 2;
    }

    float centery() {
        return (corner1y + corner2y) / 2;
    }

    void saveShrinkRegion() {
        this.shrinkRegion =  get(int(convertXCoord(corner1x)), int(convertYCoord(corner1y)),
                                 abs(int(convertXDistance(corner2x-corner1x))), abs(int(convertYDistance(corner2y-corner1y))));
    }

    void draw(){

        timeElapsed = millis()-millisInit;
        if(convertXDistance(corner2x-corner1x) - speed * aspectRatio() * (timeElapsed/1000) > 25) {

            noFill();
            noStroke();
            rectMode(CORNER);
            rect(convertXCoord(corner1x), convertYCoord(corner1y),
                    convertXDistance(corner2x - corner1x), convertYDistance(corner2y - corner1y));


            imageMode(CENTER);
            image(shrinkRegion, convertXCoord(this.centerx()), convertYCoord(this.centery()),
                    convertXDistance(corner2x - corner1x) - speed * aspectRatio() * (timeElapsed / 1000),
                    convertYDistance(corner2y - corner1y) - speed * (timeElapsed / 1000));

        }

//
//        print(convertXDistance(corner2x-corner1x) - speed * aspectRatio() * (timeElapsed/1000));
//        print("\n");
//        print(timeElapsed);
//        print("\n");
//        print(aspectRatio);
//        print("\n");

    }



}