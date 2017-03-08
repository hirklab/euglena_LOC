class FastConcentrateConstructor{

    FastConcentrator fastConcentrateInProgress;

    boolean centerComplete;

    FastConcentrateConstructor(){
        this.reset(Direction.LEFT);
    }

    void reset(Direction ledDirection){
        fastConcentrateInProgress = new FastConcentrator(-1, -1, 0);
        fastConcentrateInProgress.visible = false;
        fastConcentrateInProgress.ledDirection = ledDirection;
        centerComplete = false;
    }

    void mouseClicked(float x, float y){
        if (!centerComplete) {
            fastConcentrateInProgress.centerX = x;
            fastConcentrateInProgress.centerY = y;
            centerComplete = true;
        } else {
            fastConcentrateInProgress.armLength = sqrt(sq(x - fastConcentrateInProgress.centerX)
                    + sq(y - fastConcentrateInProgress.centerY));

            fastConcentrateInProgress.millisInit = millis();
            fastConcentrateInProgress.visible = true;
            fastconcentrators.add(fastConcentrateInProgress);

            fastConcentrateInProgress.draw();
            this.reset(fastConcentrateInProgress.ledDirection);
        }
    }
}

class FastConcentrator{

    final int maxMillis = 300000;
    final int angle = 45;

    float centerX, centerY, armLength;
    int millisInit, lastMillis, timeElapsed, lastTimeElapsed;
    boolean visible;

    Direction ledDirection;

    FastConcentrator(float centerX, float centerY, float armLength){
        this.centerX = centerX;
        this.centerY = centerY;
        this.armLength = armLength;
        this.visible = true;
    }

    void draw(){
        timeElapsed = millis() - millisInit;
        lastTimeElapsed = lastMillis - millisInit;

        if(timeElapsed > maxMillis){
            visible = false;
            // possibly define function isDone; if done, deletes from ArrayList
        }

        if(!visible) {
            return;
        }

        if (ledDirection == Direction.LEFT) {
            arduino.digitalWrite(left, Arduino.HIGH);
            leftArrow = 204;
            arduino.digitalWrite(right, Arduino.LOW);
            rightArrow = 0;
            arduino.digitalWrite(up, Arduino.LOW);
            upArrow = 0;
            arduino.digitalWrite(down, Arduino.LOW);
            downArrow = 0;

            noFill();
            strokeWeight(20);  // Controls thickness of blue border
            stroke(color(0, 0, 255));

            beginShape();
            vertex(convertXCoord(centerX - armLength * cos(angle * PI / 360)),
                    convertYCoord(centerY + armLength * sin(angle * PI / 360)));
            vertex(convertXCoord(centerX), convertYCoord(centerY));
            vertex(convertXCoord(centerX - armLength * cos(angle * PI / 360)),
                    convertYCoord(centerY - armLength * sin(angle * PI / 360)));
            endShape();
        }

        if (ledDirection == Direction.RIGHT) {
            arduino.digitalWrite(left, Arduino.LOW);
            leftArrow = 0;
            arduino.digitalWrite(right, Arduino.HIGH);
            rightArrow = 204;
            arduino.digitalWrite(up, Arduino.LOW);
            upArrow = 0;
            arduino.digitalWrite(down, Arduino.LOW);
            downArrow = 0;

            noFill();
            strokeWeight(20);  // Controls thickness of blue border
            stroke(color(0, 0, 255));

            beginShape();
            vertex(convertXCoord(centerX + armLength * cos(angle * PI / 360)),
                    convertYCoord(centerY + armLength * sin(angle * PI / 360)));
            vertex(convertXCoord(centerX), convertYCoord(centerY));
            vertex(convertXCoord(centerX + armLength * cos(angle * PI / 360)),
                    convertYCoord(centerY - armLength * sin(angle * PI / 360)));
            endShape();
        }

        if (ledDirection == Direction.UP) {
            arduino.digitalWrite(left, Arduino.LOW);
            leftArrow = 0;
            arduino.digitalWrite(right, Arduino.LOW);
            rightArrow = 0;
            arduino.digitalWrite(up, Arduino.HIGH);
            upArrow = 204;
            arduino.digitalWrite(down, Arduino.LOW);
            downArrow = 0;

            noFill();
            strokeWeight(30);  // Controls thickness of blue border
            stroke(color(0, 0, 255));

            beginShape();
            vertex(convertXCoord(centerX - armLength * sin(angle * PI / 360)),
                    convertYCoord(centerY - armLength * cos(angle * PI / 360)));
            vertex(convertXCoord(centerX), convertYCoord(centerY));
            vertex(convertXCoord(centerX + armLength * sin(angle * PI / 360)),
                    convertYCoord(centerY - armLength * cos(angle * PI / 360)));
            endShape();
        }

        if (ledDirection == Direction.DOWN) {
            arduino.digitalWrite(left, Arduino.LOW);
            leftArrow = 0;
            arduino.digitalWrite(right, Arduino.LOW);
            rightArrow = 0;
            arduino.digitalWrite(up, Arduino.LOW);
            upArrow = 0;
            arduino.digitalWrite(down, Arduino.HIGH);
            downArrow = 204;

            noFill();
            strokeWeight(30);  // Controls thickness of blue border
            stroke(color(0, 0, 255));

            beginShape();
            vertex(convertXCoord(centerX - armLength * sin(angle * PI / 360)),
                    convertYCoord(centerY + armLength * cos(angle * PI / 360)));
            vertex(convertXCoord(centerX), convertYCoord(centerY));
            vertex(convertXCoord(centerX + armLength * sin(angle * PI / 360)),
                    convertYCoord(centerY + armLength * cos(angle * PI / 360)));
            endShape();
        }
            lastMillis = millis();
    }
}