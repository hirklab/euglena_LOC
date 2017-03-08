/////////////////// Program Controls
final long ledDelay = 5000; // Duration of light from LED during LED sequence
final int recordDelay = 0; // Time delay befoe taking next xcoord in case of lag
final int paintSize = 100;  // Number of xcoord taken in limited paint activity
final int ledLimit = 3;     // Number of LEDs in sequence


////////////////////// Game Variables
// Image processing of goal regions in game 
ArrayList<Contour> plusContours;      // Stores outlines of moving objects 
ArrayList<Contour> minusContours;
ArrayList<Contour> euglenaCount;
PImage o1;                            // Backend computer vision to make sure image is being processed correctly
PImage o2;
PImage o3;
PImage goal1;                         // Region of interest
PImage goal2;
PImage gameScreen;
PImage entireScreen;
PImage cvscreen;
// score handling
int plusScore;                        // Equivalent to number of outlines
int minusScore;
int totalScore;
float scoreTime;                      // Temporary variable to ensure score is displayed for proper length of time
float scoreUpdateTime;                // Temporary variable to ensure score changes at even intervals
// Game time handling
float currentGameTime;                // Temporary variable to ensure game runs for proper length of time
float secondCounter;
// screen clearing
float clearScreenTime;                // Temporary variable to ensure screen clearing lasts for proper length of time
boolean cleared = false;              // Keeps track of whether screen has been cleared
// LED control
int gamePin = 10;                     // Used to keep track of activated LED pin serves to limit user control over LED's

//////////////////// Storage Variables
IntList paintLimit = new IntList();             // Stores finite limit of XCoord of points drawn. Once limit is reached "drawing" is stopped       
IntList ledDirections = new IntList();          // Stores a certain number of LED pins in the order they will be turned on
IntList storedColor = new IntList();            // Stores color of each point
FloatList storedXCoord = new FloatList();       // Stores x-coordinate of each point
FloatList storedYCoord = new FloatList();       // Stores y-coordinate of each point
IntList storedPenWidth = new IntList();         // Stores stroke weight of each point
IntList storedLED = new IntList();              // Stores ardPin numbers 
IntList tempLED = new IntList();                // Duplicates storedLED so the intList can be called again and again without losing any data points


//////////////////// Image Processing for doodle exploration
final int roiWidth = 500;     // Width of ROI
final int roiHeight = 500;    // Height of region of interest
final int roiCornerX = 610;
final int roiCornerY = 290;


final int centerY = 540;      // Center Y coordinate
final int centerX = int((displayWidth - 325)/2);      // Center X coordinate

/////////////////// Game Controls
final int goalEntrance = 150;  // 250 Width of entrance of goal
final int goalDepth = 150;     // 100 Depth of goal
final float totalGameTime = 45000;   // Duration of game
final float scoreDelay = 100;     // time to wait before score update so score display doesn't look as jumpy
final float clearTime = 100000;     // Duration of clear function : 1 minute 40 seconds




/////////////////// Game functions






/*   ____  The area of interest is outlined is in blue and  
 -> /      a triangle is used as border to make sure euglena 
    \____  are cleared out. The top coordinates of the top right 
           x and y and width and height can be passed as parameters 
*/
void protoClear(float x, float y, float screenWidth, float screenHeight) {
      noFill();
      stroke(color(0, 0, 220));
      strokeWeight(5);
      beginShape(); 
      vertex(convertXCoord(x + screenWidth), convertYCoord(y));
      vertex(convertXCoord(x), convertYCoord(y));
      vertex(convertXCoord(x - menu.width), convertYCoord((y + y + screenHeight)/2));
      vertex(convertXCoord(x), convertYCoord(y + screenHeight));
      vertex(convertXCoord(x + screenWidth), convertYCoord(y + screenHeight));
      endShape();
      arduino.digitalWrite(left, Arduino.HIGH);
}



/*        
      \__   Draws shape like this and activates arduino so that 
 ->    __|  euglena stream into the opening. The top coordinates of the top right 
      /     x and y and width and height of containment box can be passed as parameters  
            After amount of time or (yet to be implemented) after number of euglena 
            enter the box is closed
*/
float t_temp = 0;
float t = 0;


void protoGather(float x, float y, float boxWidth, float boxHeight) {
      noFill();
      strokeWeight(10);                              // Controls thickness of blue border
      stroke(color(0, 0, 220));
      beginShape();                                  // Draws shape
      vertex(convertXCoord(x - menu.width), displayHeight*calibrator.offsety+displayHeight/calibrator.magy-10);
      vertex(convertXCoord(x), convertYCoord(y));
      vertex(convertXCoord(x + boxWidth), convertYCoord(y));
      vertex(convertXCoord(x + boxWidth), convertYCoord(y + boxHeight));
      vertex(convertXCoord(x), convertYCoord(y + boxHeight));
      vertex(convertXCoord(x - menu.width), displayHeight*calibrator.offsety);
      endShape();
      
      if (t < 180) { 
        arduino.analogWrite(down, 64);       // Turns on arduino light (can make ardPin into a parameter that is passed in)
      } else {
        arduino.analogWrite(down, 0);
      }
      
      t_temp = t_temp + 1;
      //t = t_temp / framerate;
}