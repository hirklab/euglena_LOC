/*
Given two corners of a rectangular region, and an endpoint, the rectangular region moves toward the endpoint at a given speed (in pixel/s)
*/

class Translate {
    TranslateWindow translateWindowinprogress;

    boolean corner1complete, corner2complete;

    void reset() {
        translateWindowinprogress = new TranslateWindow(-1,-1,0,0,0,0,0);
        corner1complete = false;
        corner2complete = false;
    }

    Translate(){
        corner1complete = false;
        corner2complete = false;
    }

    void mouseClicked(float x, float y){
        if (!corner1complete){
            translateWindowinprogress.corner1x = x;
            translateWindowinprogress.corner1y = y;
            corner1complete = true;
        } else if (!corner2complete) {
            translateWindowinprogress.corner2x = x;
            translateWindowinprogress.corner2y = y;
            corner2complete = true;
        } else{
            translateWindowinprogress.endpointx = x;
            translateWindowinprogress.endpointy = y;
            translateWindowinprogress.speed = speed;
            translateWindowinprogress.millisInit = millis();
            translateWindowinprogress.saveTranslateRegion();
            translatewindows.add(translateWindowinprogress);
            this.reset();
        }
    }
}

class TranslateWindow {
    float corner1x, corner1y, corner2x, corner2y, endpointx, endpointy, speed;
    int timeElapsed, millisInit;
    PImage translateRegion;

    TranslateWindow(float corner1x, float corner1y, float corner2x, float corner2y,
                    float endpointx, float endpointy, float speed) {
        this.corner1x = corner1x;
        this.corner1y = corner1y;
        this.corner2x = corner2x;
        this.corner2y = corner2y;
        this.endpointx = endpointx;
        this.endpointy = endpointy;
        this.speed = speed;
    }


//    float aspectRatio() {
//        return abs((corner2x - corner1x) / (corner2y - corner1y));
//    }

    float centerx() {
        return (corner1x + corner2x) / 2;
    }

    float centery() {
        return (corner1y + corner2y) / 2;
    }

    float theta() {
        return (atan((endpointy-centery())/(endpointx-centerx())));
    }

    void saveTranslateRegion() {
        this.translateRegion = get(int(convertXCoord(corner1x)), int(convertYCoord(corner1y)),
        int(abs(convertXDistance(corner2x - corner1x))),int(abs(convertYDistance(corner2y - corner1y))));
    }

    void draw() {

        timeElapsed = millis() - millisInit;

        if (timeElapsed*speed/1000*cos(theta())*calibrator.magx <= endpointx - centerx()) {

            noFill();
            noStroke();
            rectMode(CORNERS);
            rect(convertXCoord(corner1x) + timeElapsed*speed/1000*cos(theta()),
                 convertYCoord(corner1y) + timeElapsed*speed/1000*sin(theta()),
                 convertXCoord(corner2x) + timeElapsed*speed/1000*cos(theta()),
                 convertYCoord(corner2y) + timeElapsed*speed/1000*sin(theta()));


            imageMode(CENTER);
            image(translateRegion, convertXCoord(this.centerx()) + timeElapsed*speed/1000*cos(theta()),
                  convertYCoord(this.centery()) + timeElapsed*speed/1000*sin(theta()),
                  convertXDistance(corner2x - corner1x), convertYDistance(corner2y - corner1y));


        }
    }
}