class ClearScreen {

    int maxTime, timeInitial,
            roiCornerX, roiCornerY, roiWidth, roiHeight;
    float euglenaCountInitial, euglenaReduction, targetReduction;
    Direction flowDirection;
    PApplet parent;


    EuglenaCounter clearScreenCount;

    /* Identify Euglena in a certain portion of the camera feed */

    void reset() {
        timeInitial = millis();
        clearScreenCount = new EuglenaCounter(parent, 500, 200, 700, 600, 1000);
        clearScreenCount.counting = true;
        euglenaCountInitial = 0;
    }

    ClearScreen(PApplet parent, float targetReduction, Direction flowDirection){
        this.targetReduction = targetReduction;
        this.flowDirection = flowDirection;
        this.parent = parent;
        this.maxTime = 1000 * 600;
        this.reset();
    }

    boolean draw(){
        clearScreenCount.update();
      
        if (!clearScreenCount.firstAverageReady) {
            return false;
        }
        if (euglenaCountInitial == 0){
            euglenaCountInitial = clearScreenCount.previousAverage;
            return false;          
        }


        boolean exceededMaxTime = (millis()-timeInitial >= maxTime);
        boolean metTargetReduction = (clearScreenCount.previousAverage/euglenaCountInitial < targetReduction);

        if (exceededMaxTime || metTargetReduction) {

            arduino.digitalWrite(left, Arduino.LOW);
            leftArrow = 0;
            arduino.digitalWrite(right, Arduino.LOW);
            rightArrow = 0;
            arduino.digitalWrite(up, Arduino.LOW);
            upArrow = 0;
            arduino.digitalWrite(down, Arduino.LOW);
            downArrow = 0;

            noFill();
            strokeWeight(15);
            stroke(color(0, 0, 255));

            beginShape();
//                vertex(convertXCoord(1200), convertYCoord(200));
//                vertex(convertXCoord(500), convertYCoord(200));
//                vertex(convertXCoord(500), convertYCoord(800));
//                vertex(convertXCoord(1200), convertYCoord(800));
                vertex(convertXCoord(displayWidth-240), convertYCoord(20));
                vertex(convertXCoord(20), convertYCoord(20));
                vertex(convertXCoord(20), convertYCoord(displayHeight-40));
                vertex(convertXCoord(displayWidth-240), convertYCoord(displayHeight-40));
            endShape(CLOSE);

            textSize(32);
            text("Cleared ratio: " + clearScreenCount.previousAverage/euglenaCountInitial, 50, 50);
            return true;
            
        } else {
            if (flowDirection == Direction.RIGHT){

                arduino.digitalWrite(left, Arduino.HIGH);
                leftArrow = 204;
                arduino.digitalWrite(right, Arduino.LOW);
                rightArrow = 0;
                arduino.digitalWrite(up, Arduino.LOW);
                upArrow = 0;
                arduino.digitalWrite(down, Arduino.LOW);
                downArrow = 0;

                noFill();
                strokeWeight(20);
                stroke(color(0, 0, 255));
                beginShape();
                    vertex(convertXCoord(displayWidth-240), convertYCoord(20));
                    vertex(convertXCoord(20), convertYCoord(20));
                    vertex(convertXCoord(20), convertYCoord(displayHeight-40));
                    vertex(convertXCoord(displayWidth-240), convertYCoord(displayHeight-40));
                endShape();
            }

            if (flowDirection == Direction.LEFT){

                arduino.digitalWrite(left, Arduino.LOW);
                leftArrow = 0;
                arduino.digitalWrite(right, Arduino.HIGH);
                rightArrow = 204;
                arduino.digitalWrite(up, Arduino.LOW);
                upArrow = 0;
                arduino.digitalWrite(down, Arduino.LOW);
                downArrow = 0;

                noFill();
                strokeWeight(15);
                stroke(color(0, 0, 255));
                beginShape();
                    vertex(convertXCoord(20), convertYCoord(20));
                    vertex(convertXCoord(displayWidth-240), convertYCoord(20));
                    vertex(convertXCoord(displayWidth-240), convertYCoord(displayHeight-40));
                    vertex(convertXCoord(20), convertYCoord(displayHeight-40));
                endShape();
            }

            if (flowDirection == Direction.DOWN){

                arduino.digitalWrite(left, Arduino.LOW);
                leftArrow = 0;
                arduino.digitalWrite(right, Arduino.LOW);
                rightArrow = 0;
                arduino.digitalWrite(up, Arduino.HIGH);
                upArrow = 204;
                arduino.digitalWrite(down, Arduino.LOW);
                downArrow = 0;

                noFill();
                strokeWeight(15);
                stroke(color(0, 0, 255));
                beginShape();
                    vertex(convertXCoord(20), convertYCoord(displayHeight-40));
                    vertex(convertXCoord(20), convertYCoord(20));
                    vertex(convertXCoord(displayWidth-240), convertYCoord(20));
                    vertex(convertXCoord(displayWidth-240), convertYCoord(displayHeight-40));
                endShape();
            }

            if (flowDirection == Direction.UP){

                arduino.digitalWrite(left, Arduino.LOW);
                leftArrow = 0;
                arduino.digitalWrite(right, Arduino.LOW);
                rightArrow = 0;
                arduino.digitalWrite(up, Arduino.LOW);
                upArrow = 0;
                arduino.digitalWrite(down, Arduino.HIGH);
                downArrow = 204;

                noFill();
                strokeWeight(15);
                stroke(color(0, 0, 255));
                beginShape();
//                    vertex(convertXCoord(500), convertYCoord(200));
//                    vertex(convertXCoord(500), convertYCoord(800));
//                    vertex(convertXCoord(1200), convertYCoord(800));
//                    vertex(convertXCoord(1200), convertYCoord(200));
                    vertex(convertXCoord(20), convertYCoord(20));
                    vertex(convertXCoord(20), convertYCoord(displayHeight-40));
                    vertex(convertXCoord(displayWidth-240), convertYCoord(displayHeight-40));
                    vertex(convertXCoord(displayWidth-240), convertYCoord(20));
                endShape();
            }

            textSize(32);
            text("Cleared ratio: " + clearScreenCount.previousAverage/euglenaCountInitial, 50, 50);
            return false;


        }


    }

}