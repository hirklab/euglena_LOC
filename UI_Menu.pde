class Menu {
    final int width = 325; // Width of toolbar on left side of display

    Button resetButton, calibrateButton, commitButton, lineButton, freehandButton, eraserButton, goButton;
    Textfield redField, greenField, blueField, backgroundField, penwidthField, lagField, totaltimeField, speedField;
    DropdownList shapesList, animateList, presetsList, gamesList;

    PApplet parent;

    ControlP5 cp5;

    Group g1, g2, g3;

    Menu(PApplet applet){

        parent = applet;

        cp5 = new ControlP5(applet);

        g1 = cp5.addGroup("Textfields");
        g2 = cp5.addGroup("Dropdown2");
        g3 = cp5.addGroup("Dropdown1");


        resetButton = cp5.addButton("Reset")
                .setPosition(displayWidth - width + 20, 200)
                .setSize(75, 35)
                .moveTo(g1);
        calibrateButton = cp5.addButton("Calibrate")
                .setPosition(displayWidth - width + 120, 200)
                .setSize(75, 35)
                .moveTo(g1);
        commitButton = cp5.addButton("Commit")
                .setPosition(displayWidth - width + 220, 200)
                .setSize(75, 35)
                .moveTo(g1);

        redField = cp5.addTextfield("Red (0-255)")
                .setPosition(displayWidth - width + 20, 275)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);
        greenField = cp5.addTextfield("Green (0-255)")
                .setPosition(displayWidth - width + 120, 275)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);
        blueField = cp5.addTextfield("Blue (0-255)")
                .setPosition(displayWidth - width + 220, 275)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);
        backgroundField = cp5.addTextfield("Background (0-255)")
                .setPosition(displayWidth - width + 20, 325)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);
        penwidthField = cp5.addTextfield("Pen Width")
                .setPosition(displayWidth - width + 120, 325)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);

        speedField = cp5.addTextfield("Speed")
                .setPosition(displayWidth - width + 20, 400)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);
        lagField = cp5.addTextfield("Timelapse lag")
                .setPosition(displayWidth - width + 120, 400)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);
        totaltimeField = cp5.addTextfield("Total time")
                .setPosition(displayWidth - width + 220, 400)
                .setSize(75, 35)
                .setAutoClear(false)
                .moveTo(g1);




        lineButton = cp5.addButton("Line")
                .setPosition(displayWidth - width + 20, 550)
                .setSize(60, 35)
                .moveTo(g1);
        freehandButton = cp5.addButton("Freehand")
                .setPosition(displayWidth - width + 85, 550)
                .setSize(60, 35)
                .moveTo(g1);
        eraserButton = cp5.addButton("Eraser")
                .setPosition(displayWidth - width + 150, 550)
                .setSize(60, 35)
                .moveTo(g1);

        shapesList = cp5.addDropdownList("Shapes")
                .setPosition(displayWidth - width + 220, 550)
                .setSize(80, 100)
                .setBarHeight(35)
                .addItem("Ellipse", "Ellipse")
                .addItem("Rectangle", "Rectangle")
                .addItem("Triangle", "Triangle")
                .addItem("None", "Default")
                .close()
                .moveTo(g1);

        animateList = cp5.addDropdownList("Animate")
                .setPosition(displayWidth - width + 20, 625)
                .setSize(80, 100)
                .setBarHeight(35)
                .addItem("Shrink", "Shrink")
                .addItem("Expand", "Expand")
                .addItem("Translate", "Translate")
                .addItem("Rotate", "Rotate")
                .addItem("None", "Default")
                .close()
                .moveTo(g3);

        presetsList = cp5.addDropdownList("Presets")
                .setPosition(displayWidth - width + 120, 625)
                .setSize(80, 100)
                .setBarHeight(35)
                .addItem("ClrScrn left", "Clear screen left")
                .addItem("ClrScrn right", "Clear screen right")
                .addItem("ClrScrn up", "Clear screen up")
                .addItem("ClrScrn down", "Clear screen down")
                
                .addItem("Flow left", "Flow left")
                .addItem("Flow right", "Flow right")
                .addItem("Flow up", "Flow up")
                .addItem("Flow down", "Flow down")
                
                .addItem("All LEDs on", "All LEDs on")
                
                .addItem("Slow compress", "Slow compress")
                .addItem("Fast compress (L)", "Fast compress left")
                .addItem("Fast compress (R)", "Fast compress right")
                .addItem("Fast compress (U)", "Fast compress up")
                .addItem("Fast compress (D)", "Fast compress down")

                //.addItem("Contain", "Contain")
                //.addItem("Split", "Split")
                //.addItem("Merge", "Merge")
                //.addItem("Slow move", "Slow move")
                //.addItem("Fast move", "Fast move")
                
                .addItem("Experiment 1", "Experiment 1")
                .addItem("Experiment 2", "Experiment 2")
                .addItem("Experiment 3", "Experiment 3")
                .addItem("Experiment 4", "Experiment 4")
                .addItem("Experiment 5", "Experiment 5")
                .addItem("Experiment 6", "Experiment 6")
                .addItem("Experiment 7", "Experiment 7")      
                .addItem("Experiment 8", "Experiment 8")
                .addItem("Experiment 9", "Experiment 9")

                .close()
                .moveTo(g2);

//        goButton = cp5.addButton("Go")
//                .setPosition(displayWidth - width + 20, 750)
//                .setSize(70, 20)
//                .moveTo(g1);

        gamesList = cp5.addDropdownList("Games")
                .setPosition(displayWidth - width + 220, 625)
                .setSize(80, 100)
                .setBarHeight(35)
                .addItem("Level 1", "Level 1")
                .addItem("Level 2", "Level 2")
                .addItem("Level 3", "Level 3")
                .close()
                .moveTo(g2);
    }

    void draw() {
        drawBackground();
        drawArrows();
    }

    void drawArrows() {
        strokeWeight(8);

        stroke(color(255, 255, 255 - rightArrow));
        drawArrow(displayWidth - width + 175, 80, 30, 0);

        stroke(color(255, 255, 255 - downArrow));
        drawArrow(displayWidth - width + 155, 100, 30, 90);

        stroke(color(255, 255, 255 - leftArrow));
        drawArrow(displayWidth - width + 135, 80, 30, 180);

        stroke(color(255, 255, 255 - upArrow));
        drawArrow(displayWidth - width + 155, 60, 30, 270);
    }

    void drawBackground() {
        rectMode(CORNER);

        noStroke();
        fill(0);
        rect(displayWidth - width, 0, width, displayHeight);
    }

    void controlEvent (ControlEvent theEvent) {
        if (theEvent.isFrom(shapesList)) {
            switch(int(shapesList.getValue())) {
                case 0:
                    ellipseDrawer.reset();
                    drawtype = 'e';
                    break;
                case 1:
                    rectangleDrawer.reset();
                    drawtype = 'r';
                    break;
                case 2:
                    triangleDrawer.reset();
                    drawtype = 't';
                    break;
            }
        }

        if (theEvent.isFrom(animateList)){
            switch(int(animateList.getValue())) {
                case 0:
                    shrink.reset();
                    drawtype = 's';
                    break;
                case 1:
                    expand.reset();
                    drawtype = 'x';
                    break;
                case 2:
                    translate.reset();
                    drawtype = 'm';
                    break;
                case 3:
                    rotate.reset();
                    drawtype = 'c';
                    break;
            }
        }

        if (theEvent.isFrom(presetsList)){
            switch(int(presetsList.getValue())) {
                case 0: // clearScreenLeft
                    clearScreenLeft = new ClearScreen(parent, 0.1, Direction.LEFT);
                    break;
                case 1: // clearScreenRight
                    clearScreenRight = new ClearScreen(parent, 0.1, Direction.RIGHT);
                    break;
                case 2: // clearScreenUp
                    clearScreenUp = new ClearScreen(parent, 0.1, Direction.UP);
                    break;
                case 3: // clearScreenDown
                    clearScreenDown = new ClearScreen(parent, 0.1, Direction.DOWN);
                    break;
                    
                case 4: // Flow left
                    arduino.digitalWrite(right, Arduino.HIGH);
                    rightArrow = 204;
                    break;
                case 5: // Flow right
                    arduino.digitalWrite(left, Arduino.HIGH);
                    leftArrow = 204;
                    break;
                case 6: // Flow up
                    arduino.digitalWrite(down, Arduino.HIGH);
                    downArrow = 204;
                    break;
                case 7: // Flow down
                    arduino.digitalWrite(up, Arduino.HIGH);
                    upArrow = 204;
                    break;
                    
                case 8: // All LEDs on
                    arduino.digitalWrite(right, Arduino.HIGH);
                    arduino.digitalWrite(left, Arduino.HIGH);
                    arduino.digitalWrite(up, Arduino.HIGH);
                    arduino.digitalWrite(down, Arduino.HIGH);
                    rightArrow = leftArrow = upArrow = downArrow = 204;
                    break;
                    
                case 9: // Slow compress
                    slowConcentrateCenter = new SlowConcentrator((displayWidth-width)/2, centerY, displayHeight/2);
                    slowconcentrators.add(slowConcentrateCenter);
                    slowConcentrateCenter.millisInit = millis();
                    
                    //slowConcentrateConstructor.reset();
                    //drawtype = 'q';
                    break;
                case 10: // Fast compress left
                    fastConcentrateLeft = new FastConcentrator(3*(displayWidth-width)/4, centerY, 800);
                    fastConcentrateLeft.ledDirection = Direction.LEFT;
                    fastConcentrateLeft.millisInit = millis();
                    fastConcentrateLeft.draw();

//                    fastConcentrateConstructor.reset(Direction.LEFT);
//                    drawtype = 'p';
                    break;
                case 11: // Fast compress right
                    fastConcentrateRight = new FastConcentrator((displayWidth-width)/4, centerY, 800);
                    fastConcentrateRight.ledDirection = Direction.RIGHT;
                    fastConcentrateRight.millisInit = millis();
                    fastConcentrateRight.draw();
//                    fastConcentrateConstructor.reset(Direction.RIGHT);
//                    drawtype = 'p';
                    break;
                case 12: // Fast compress up
//                    fastConcentrateConstructor.reset(Direction.UP);
//                    drawtype = 'p';
                    break;
                case 13: // Fast compress down
//                    fastConcentrateConstructor.reset(Direction.DOWN);
//                    drawtype = 'p';
                    break;   
                    
                case 14: //Experiment 1
                    exp1();
                    break;
                    
                case 15: //Experiment 2
                    exp2();
                    break;
                    
                case 16: //Experiment 3
                    exp3();
                    break;
                    
                case 17: //Experiment 4
                    exp4();
                    break;
                    
                case 18: //Experiment 5
                    exp5();
                    break;
                    
                case 19: //Experiment 6
                    exp6();
                    break; 
                    
                case 20: //Experiment 7
                    exp7();
                    break;    

                case 21: //Experiment 8
                    exp8BG = true;
                    expTimeInit = millis();
                    break;
                    
                case 22: //Experiment 9
                    exp9();
                    expTimeInit = millis();
                    lastDrawMillis = millis();
                    break;
            }
        }
    }
}

void drawArrow(int cx, int cy, int len, float angle){
    pushMatrix();
    translate(cx, cy);
    rotate(radians(angle));
    line(0,0,len, 0);
    line(len, 0, len - 8, -8);
    line(len, 0, len - 8, 8);
    popMatrix();
}

/* Adds all features to initial display including toolbar and camera display */




void Commit() {
    rVal = int(menu.redField.getText());
    gVal = int(menu.greenField.getText());
    bVal = int(menu.blueField.getText());
    penWidth = int(menu.penwidthField.getText());
    bgVal = int(menu.backgroundField.getText());
    lagTime = float(menu.lagField.getText());
    totalTime = int(menu.totaltimeField.getText());
    speed = float(menu.speedField.getText());

//    print(rVal);
//    print(",");
//    print(gVal);
//    print(",");
//    print(bVal);
//    print("\n");
//    print(speed);
//    print("\n");
}

void Reset() {


        if (calibrator.active == true){
            calibrator.toggle();
        } else {
            clearDisplay();

            lines.clear();
            ellipses.clear();
            rectangles.clear();
            triangles.clear();

            shrinkwindows.clear();
            expandwindows.clear();
            translatewindows.clear();
            rotatewindows.clear();
            
            // Eliminates all presets
            clearScreenLeft = null;
            clearScreenRight = null;
            clearScreenUp = null;
            clearScreenDown = null;
            
            slowconcentrators.clear();
            fastconcentrators.clear();
            
            arduino.digitalWrite(left, Arduino.LOW);
            arduino.digitalWrite(right, Arduino.LOW);
            arduino.digitalWrite(up, Arduino.LOW);
            arduino.digitalWrite(down, Arduino.LOW);
            
            randBG = null;
            exp8BG = false;

            t = 0;
            t2 = 0;
            t3 = 0;
            t_temp = 0;
        }
}

void Calibrate() {
        surface.setLocation(0,0);
        calibrator.toggle();
}

void Eraser() {
        rVal = 0;
        gVal = 0;
        bVal = 0;
}

void Line() {
        lineDrawer.reset();
        drawtype = 'l';
}