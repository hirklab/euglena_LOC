void translateCircle(float speed){
  
  if ((screenWidth - menu.width)/calibrator.magx - t > 60){
    clearDisplay();
    fill(0,0,0);
    strokeWeight(10);                              // Controls thickness of line
    stroke(color(0, 0, 255));
    ellipseMode(CENTER);
    
    ellipse(convertXCoord(centerX), convertYCoord(centerY), 
            (screenWidth - menu.width)/calibrator.magx - t, (screenWidth - menu.width)/calibrator.magx - t);
            
    t = t + speed*1;
    
  } else {
    
    if (convertXCoord(centerX) - t2 > convertXCoord(250)){
      clearDisplay();
      fill(0,0,0);
      strokeWeight(10);                              // Controls thickness of line
      stroke(color(0, 0, 255));
      ellipseMode(CENTER);
      ellipse(convertXCoord(centerX) - t2, convertYCoord(centerY), 
              (screenWidth - menu.width)/calibrator.magx - t, (screenWidth - menu.width)/calibrator.magx - t);
              
      t2 = t2 + speed*0.1;
    }
  }
}

void exp1(){
  
      clearScreenLeft = null;
      clearDisplay();
  
      arduino.digitalWrite(left, Arduino.HIGH);
      leftArrow = 204;
      
      arduino.digitalWrite(right, Arduino.LOW);
      rightArrow = 0;
      
      stroke(color(0,0,255));
      
      strokeWeight(1);
      line(convertXCoord((displayWidth-200)/2), convertYCoord(0), 
           convertXCoord((displayWidth-200)/2), convertYCoord(displayHeight));
      //line(convertXCoord(100), convertYCoord(0), convertXCoord(100), convertYCoord(displayHeight));
      
      //strokeWeight(2);
      //line(convertXCoord(200), convertYCoord(0), convertXCoord(100), convertYCoord(displayHeight));
      
      //strokeWeight(4);
      //line(convertXCoord(300), convertYCoord(0), convertXCoord(300), convertYCoord(displayHeight));
      
      //strokeWeight(8);
      //line(convertXCoord(450), convertYCoord(0), convertXCoord(450), convertYCoord(displayHeight));
      
      //strokeWeight(16);
      //line(convertXCoord(650), convertYCoord(0), convertXCoord(650), convertYCoord(displayHeight));
      
      //strokeWeight(32);
      //line(convertXCoord(950), convertYCoord(0), convertXCoord(950), convertYCoord(displayHeight));
      
      //strokeWeight(64);
      //line(convertXCoord(1250), convertYCoord(0), convertXCoord(1250), convertYCoord(displayHeight));          
           
}

void exp2(){
  
      arduino.digitalWrite(left, Arduino.HIGH);
      leftArrow = 204;
      
      arduino.digitalWrite(right, Arduino.LOW);
      rightArrow = 0;
      
      stroke(color(0,0,255));
      
      strokeWeight(2);
      line(convertXCoord((displayWidth-200)/2), convertYCoord(0), 
           convertXCoord((displayWidth-200)/2), convertYCoord(screenHeight));
}

void exp3(){
  
      arduino.digitalWrite(left, Arduino.HIGH);
      leftArrow = 204;
      
      arduino.digitalWrite(right, Arduino.LOW);
      rightArrow = 0;
      
      stroke(color(0,0,255));
      
      strokeWeight(4);
      line(convertXCoord((displayWidth-200)/2), convertYCoord(0), 
           convertXCoord((displayWidth-200)/2), convertYCoord(screenHeight));
}

void exp4(){
  
      arduino.digitalWrite(left, Arduino.HIGH);
      leftArrow = 204;
      
      arduino.digitalWrite(right, Arduino.LOW);
      rightArrow = 0;
      
      stroke(color(0,0,255));
      
      strokeWeight(8);
      line(convertXCoord((displayWidth-200)/2), convertYCoord(0), 
           convertXCoord((displayWidth-200)/2), convertYCoord(screenHeight));
}

void exp5(){
  
      arduino.digitalWrite(left, Arduino.HIGH);
      leftArrow = 204;
      
      arduino.digitalWrite(right, Arduino.LOW);
      rightArrow = 0;
      
      stroke(color(0,0,255));
      
      strokeWeight(16);
      line(convertXCoord((displayWidth-200)/2), convertYCoord(0), 
           convertXCoord((displayWidth-200)/2), convertYCoord(screenHeight));
}

void exp6(){
  
      arduino.digitalWrite(left, Arduino.HIGH);
      leftArrow = 204;
      
      arduino.digitalWrite(right, Arduino.LOW);
      rightArrow = 0;
      
      stroke(color(0,0,127));
      
      strokeWeight(32);
      line(convertXCoord((displayWidth-200)/2), convertYCoord(0), 
           convertXCoord((displayWidth-200)/2), convertYCoord(screenHeight));
}

void exp7(){
  
      //arduino.digitalWrite(left, Arduino.HIGH);
      //leftArrow = 204;
      
      //arduino.digitalWrite(right, Arduino.LOW);
      //rightArrow = 0;
      
      //stroke(color(0,0,255));
      
      //strokeWeight(64);
      //line(convertXCoord((displayWidth-200)/2), convertYCoord(0), 
      //     convertXCoord((displayWidth-200)/2), convertYCoord(screenHeight));
      
      arduino.digitalWrite(down, Arduino.HIGH);
      downArrow = 204;
      
      stroke(color(255,0,0));     
      strokeWeight(20);     
      line(convertXCoord((displayWidth-200)/5), convertYCoord(screenHeight/2), 
           convertXCoord(2*(displayWidth-200)/5), convertYCoord(screenHeight/2));
           
      stroke(color(0,0,255));     
      strokeWeight(20);      
      line(convertXCoord(2*(displayWidth-200)/5), convertYCoord(screenHeight/2), 
           convertXCoord(3*(displayWidth-200)/5), convertYCoord(screenHeight/2));
           
      stroke(color(0,255,0));     
      strokeWeight(20);      
      line(convertXCoord(3*(displayWidth-200)/5), convertYCoord(screenHeight/2), 
           convertXCoord(4*(displayWidth-200)/5), convertYCoord(screenHeight/2));
           
      
}

void exp8(){
  rectMode(CORNERS);
  strokeWeight(penWidth);
  stroke(color(rVal, gVal, bVal));
  fill(int(bgVal*rbgValMod), int(bgVal*gbgValMod), int(bgVal*bbgValMod));

  rect(convertXCoord(displayWidth-200), convertYCoord(displayHeight+20), 
        convertXCoord((displayWidth-200)/2), convertYCoord(-20));
}

void exp9(){
  randBG = createImage(int(convertXDistance(cam.width/1.75)), int(convertYDistance(cam.height)), RGB);
}

/*
Previously implemented programs which we need to redo using classes
  case 2 :           // Starts clear program
    clearScreen();
break;
  case 3 :           // Uses reduced screen raster
//      rectangularStim(64, 5);
//      proto488flashraster(screenWidth - 1500, 400, screenWidth - 6*menu.width, screenHeight - 400);
//      heatup();
//      squareCorridor();
//      LEDtest();
//      colorScreen();
//      clearScreen();
//      circleArrayStim(screenWidth - 1500, 800, 5, 5, 20, 5);
//      angleMove(screenWidth - (displayWidth-750*cos(45*PI/360)-x-menu.width), centerY, 45, 750, 0.01);
//      window(20, 20);
//      separate(0.1);
//      merge(0.1);
//      shrinkingWindow(0.01, 0, 0, 255, 10);
//      translateCircle(0.1);
//      gradientWindow(0,0,0,0,0,15,500);
//      randomLED();
//      lineRotate(50, 0.01);
    break;
  case 4 :           // Create LED sequences or paint backgrounds to be loaded later
    angleGather(screenWidth - 1400, centerY, 45, 750);
//      protoGather(screenWidth - 800, 300, screenWidth - 8*menu.width, screenHeight - 500);
    break;
*/

//class ClearScreen {

//    int timeElapsed, timeCurrent, timeInitial, euglenaCountInitial, euglenaCount,
//            roiCornerX, roiCornerY, roiWidth, roiHeight;
//    float euglenaReduction, targetReduction;

//    opencv = new OpenCV(this, roiWidth, roiHeight);
//    opencv.startBackgroundSubtraction(7, 3, .35);
//    roiFrame = new PImage(roiWidth, roiHeight);
//    break;
//
//    /* Identify Euglena in a certain portion of the camera feed */
//    void countEuglena() {
//        roiFrame = get(roiCornerX, roiCornerY, roiWidth, roiHeight); // Get pixels of interest and saves as image for valid image path
//        opencv.loadImage(roiFrame);   // Input proper pixels into cv processing
//        opencv.updateBackground();    //Necessary for background subtraction
//        opencv.useGray();             //Create grayscale image
//        opencv.dilate();              //Clean up image
//        opencv.erode();
//        opencv.blur(3);
//        dst = opencv.getOutput();     //Save computer vision as separate image path
//        contours = opencv.findContours();  //Find outline of moving objects - euglena
//        euglenaCount = contours.size();           // Count number of outlines
//    }
//
//    void reset() {
//        timeInitial = millis();
//        timeElapsed = 0;
//        identifyEuglena();
//        euglenaCountInitial = euglenaCount;
//    }
//
//    ClearScreen(targetReduction){
//        this.reset();
//    }
//
//    void mouseClicked(float x, float y){
//        if (!point1complete){
//            lineinprogress.x1 = x;
//            lineinprogress.y1 = y;
//            point1complete = true;
//        } else {
//            lineinprogress.x2 = x;
//            lineinprogress.y2 = y;
//            lineinprogress.visible = true;
//            lines.add(lineinprogress);
//
//            lineinprogress.draw();
//            this.reset();
//        }
//    }
//}