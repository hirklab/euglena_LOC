/* Calibrator aligns the Processing screen with the corner, and also contains the conversion between screen pixel to projected pixel */

class Calibrator {

    boolean active;
    PImage drawnScreen;

    /////////////////////// proj img screen alignment
    float offsetx, offsety, magx, magy, rot;

    void reset() {
        magx = 5.6;  // reduction factor in X
        magy = 5.6  ;  // reduction factor in Y
        offsetx = 1.515 ;  // starts projector screen at distance from right most edge
        offsety = 0.360;   // distance from topmost edge
        rot = 0; //rotation of projection starts at 0 degrees
    }

    Calibrator(){
        this.reset();
        this.active = false;
    }

    void toggle() {
        if (this.active) {
            this.deactivate();
        } else {
            this.activate();
        }
    }

    void activate() {
        this.active = true;
        this.drawnScreen = get(displayWidth, 0, displayWidth, displayHeight);
    }

    void deactivate() {
        clearDisplay();
        set(displayWidth, 0, this.drawnScreen);
        this.active = false;
    }

    void buttonPressed(int keyCode){
        if (!this.active) {
            return;
        }

        // Calibration of projector field of view
        switch(keyCode) {
            case UP:
                offsety = offsety - .001; //Moves projections up in app view
                break;
            case DOWN:
                offsety = offsety + .001; //Moves projections down
                break;
            case LEFT:
                offsetx = offsetx - .001; // Moves projections left
                break;
            case RIGHT:
                offsetx = offsetx + .001; // Moves projections right
                break;
            case 36:
                magx = magx + .05; // HOME button reduces width of projections
                break;
            case 35:
                magx = magx - .05; // END button increases width of projections
                break;
            case 33:
                magy = magy + .05; // PAGE UP button reduces height of projections
                break;
            case 34:
                magy = magy - .05; // PAGE DOWN button increases height of projections
                break;
            case SHIFT:
                println("x-offset: " + offsetx + " | y-offset: " + offsety);
                println("x-magnification: " + magx + " | y-magnification: " + magy);
            default:
                break;
        }
    }

    void draw() {
        if (!this.active) {
            return;
        }

        clearDisplay();

        float x0 = displayWidth * offsetx;
        float y0 = displayHeight * offsety;
        float dx = (displayWidth - menu.width)/magx;
        float dy = displayHeight/magy;

        // Hello World on 2nd Monitor
        noStroke();
        textSize(50);
        fill(color(0,90,0));
        text("hello,", x0+20, y0+60);
        fill(color(0,0,90));
        text("world!", x0+20, y0+110);

        // Four dots used for calibration (may need to change code so that it better matches the math used to convert other points)
        fill(color(0,0,190));
        ellipse(x0, y0,5,5);
        fill(color(190,0,0));
        ellipse(x0, y0+dy-10,5,5);
        fill(255);
        ellipse(x0+dx-5, y0+dy-10,5,5);
        fill(color(0,190,0));
        ellipse(x0+dx-5, y0,5,5);
    }
}

void controlEvent(ControlEvent theEvent) {
    menu.controlEvent(theEvent);
}

/* Translates x coordinate of point from user screen to projection screeen */
float convertXCoord(float x) {
  return (x / calibrator.magx + displayWidth * calibrator.offsetx);
}

/* Translates y coordinate of point from user screen to projection screen */
float convertYCoord(float y) {
  return (y / calibrator.magy + displayHeight * calibrator.offsety);
}

/* Translates x distances on screen to projector*/
float convertXDistance(float x) {
  return (x / calibrator.magx);
}

/* Translates y distances on screen to projector*/
float convertYDistance(float y) {
  return (y / calibrator.magy);
}