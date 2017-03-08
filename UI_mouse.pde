/* Listens for user dragging mouse and draws points of appropriate
color and width on the screen */
void mouseDragged() { 
  if(mouseX < displayWidth-menu.width){ // Determines if mouse is in drawing area
    stroke(color(rVal, gVal, bVal));            // Sets pent to current color
    strokeWeight(penWidth);               // Sets pen to current Width

    point(convertXCoord(mouseX), convertYCoord(mouseY)); // Moves points on to second monitor with correct sizing
  }
}

void mouseClicked(){
  if (mouseX < displayWidth-menu.width){
    switch(drawtype) {

      case 'e' :
        ellipseDrawer.mouseClicked(mouseX, mouseY);
        break;
    
      case 'l' :
        lineDrawer.mouseClicked(mouseX, mouseY);
        break;

      case 'r' :
        rectangleDrawer.mouseClicked(mouseX, mouseY);
        break;

      case 't' :
        triangleDrawer.mouseClicked(mouseX, mouseY);
        break;

      case 's' :
        shrink.mouseClicked(mouseX, mouseY);
        break;

      case 'x' :
        expand.mouseClicked(mouseX, mouseY);
        break;

      case 'm' :
        translate.mouseClicked(mouseX, mouseY);
        break;

      case 'c' :
        rotate.mouseClicked(mouseX, mouseY);
        break;
        
      case 'q' :
        slowConcentrateConstructor.mouseClicked(mouseX, mouseY);
        break;

      case 'p' :
        fastConcentrateConstructor.mouseClicked(mouseX, mouseY);
        break;
    }
  }
}

/*Uses keys to create uniform movement in the Euglena by turniing LEDs on 
and off with standard directional keys. It also allows calibration of 
the projector field of view */

void keyPressed() {
  if (key == CODED) {
    // Calibration of projector field of view
    calibrator.buttonPressed(keyCode);

    switch(keyCode) {
      //case 112:            // F1 key
      //  if (startSession == 8) {           // Level 2
      //    if(gamePin == 5) {
      //      gamePin = 10;                  // Euglena move left
      //      arduino.digitalWrite(right, Arduino.LOW);
      //    } else {
      //      gamePin = 5;                   // Euglena move right
      //      arduino.digitalWrite(left, Arduino.LOW);
      //    }
      //  }
      //  break;

      case CONTROL:
        exampleCV.toggleDisplayed();
        break;

      default:
        break;
    }
  } else { 
    
    // Control LED with standard directional keys
    switch(key) { 
      case 'd':
        ardPin = right;  // Forces Euglena right
        rightArrow = 204;
        arduino.digitalWrite(ardPin, Arduino.HIGH);
        break;
      case 'w':
        ardPin = up;  // Forces Euglena up
        upArrow = 204;
        arduino.digitalWrite(ardPin, Arduino.HIGH);
        break;
      case 's':
        ardPin = down;  // Forces Euglena down
        downArrow = 204;
        arduino.digitalWrite(ardPin, Arduino.HIGH);
        break;
      case 'a':
        ardPin = left;  //Forces Euglena left
        leftArrow = 204;
        arduino.digitalWrite(ardPin, Arduino.HIGH);
        break;
        
      case 'f':
        ardPin = pump;
        arduino.digitalWrite(ardPin, Arduino.HIGH);
        break;
        
      default: // Turn off last light
        arduino.digitalWrite(ardPin, Arduino.LOW);
        leftArrow = rightArrow = upArrow = downArrow = 0;
        break;
      
      case ENTER: // Takes a snapshot of the FOV
        snapshot();
        break;
        
      case 'r': // Toggles between recording timelapse and not recording
        record = !record;


    }
  }  
}

/* Turns off LED's that have been turned on while the app is running*/
void keyReleased() {
  switch(key) {
    case 'd':
      ardPin = right;   
      rightArrow = 0;
      arduino.digitalWrite(ardPin, Arduino.LOW);
      break;
    case 'w':
      ardPin = up;
      upArrow = 0;
      arduino.digitalWrite(ardPin, Arduino.LOW);
      break;
    case 's':
      ardPin = down;
      downArrow = 0;
      arduino.digitalWrite(ardPin, Arduino.LOW);
      break;
    case 'a':
      ardPin = left;
      leftArrow = 0;
      arduino.digitalWrite(ardPin, Arduino.LOW);
      break;

    case 'c':
      fullcount.counting = !fullcount.counting;
      break;

    case 'm':
      euglenaMonitor.toggleMonitoring();
      break;

    default :
      arduino.digitalWrite(ardPin, Arduino.LOW);
      leftArrow = rightArrow = upArrow = downArrow = 0;
      break;
  }
}