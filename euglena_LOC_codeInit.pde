/* Development Version
Created By: Seung Ah Lee
Modified by: Karina Samuel-Gama
Modified by: Amy Lam

This program runs patterned light stimuli. Users choose between different stimuli which
are projected through the projector and displayed onto Euglena. A webcam records the 
projections overlayed with the view of the Euglena.
Current Functionality
- Screen calibration. Users can line up the 4 colored dots with the 4 corners of the screen 
  using the directional keys and home, end, page up, and page down
- Allows free draw. Users can change colors and pen width to interact with the euglena.
  Users can also activate the four LEDs using 'a' 'w' 'd' 's'. In free draw users can also 
  see the computer tracking the top right corner of the screen by hitting CTRL
- Users can input LED sequences and see the reaction of the euglena. This allows for the 
  user to easily draw while the sequence is running. [The code can also be saved for future
  functionality]
- The User can also save LED sequences and paint drawings for future uses. The data is only saved 
  in the current instance of the program. NEED to integrate the program with remote database

___________________________________________________________
|                           |                             |
|                           |         Projection          |
|     Display Screen        |          Off Screen doodle  |
|     visible on laptop     |         appears here        |
|                           |                             |
|                           |                             |
|___________________________|_____________________________|
*/

import org.firmata.*;
import gab.opencv.*;
import processing.video.*;
import processing.serial.*;
import cc.arduino.*;
import controlP5.*;

Capture cam;          // One camera object needed to display euglena 
Arduino arduino;      // One arduino to control the LEDs
ControlP5 cp5;        // Library to create nicer GUI
OpenCV opencv;        // One opencv object needed per region of interest with unique dimension
OpenCV opencv2;
OpenCV opencv3;
OpenCV opencv4;
OpenCV opencv5;     

/* CONSTANTS */




/* Global Variables */
///////////////// Miscellaneaous Variables
int penWidth = 15;     // Default width of pen
int ardPin = 5;        // LED of interest

int count;
int expTimeInit;
int lastDrawMillis;

///////////////////////// Color Variables
int iColor=0;//current color

int rVal = 0;
int bVal = 0;
int gVal = 0;
int bgVal = 0;
float rbgValMod = 1;
float gbgValMod = 1;
float bbgValMod = 1;

int rightArrow = 0;
int downArrow = 0;
int leftArrow = 0;
int upArrow = 0;

float lagTime = 1;
int totalTime = 15000;

int presetProg;




float speed;

int screenWidth;
int screenHeight;
int totalCount = 1;
float percentDensity;
int densityTSTime;
int densityROITime;
int displayDensityTime;
int densitySession = 0;
int gameScreenWidth = 600;
int gameScreenHeight = 600;

static float densityThreshold = 6;
boolean densityMeasured = false;
boolean counting = false;

FloatList fadeXCoord = new FloatList();       // Stores x-coordinate of each point
FloatList fadeYCoord = new FloatList();

DropdownList presetsList;

ArrayList<Line> lines = new ArrayList<Line>();
ArrayList<Ellipse> ellipses = new ArrayList<Ellipse>();
ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();
ArrayList<Triangle> triangles = new ArrayList<Triangle>();

ArrayList<ShrinkWindow> shrinkwindows = new ArrayList<ShrinkWindow>();
ArrayList<ExpandWindow> expandwindows = new ArrayList<ExpandWindow>();
ArrayList<TranslateWindow> translatewindows = new ArrayList<TranslateWindow>();
ArrayList<RotateWindow> rotatewindows = new ArrayList<RotateWindow>();

ArrayList<SlowConcentrator> slowconcentrators = new ArrayList<SlowConcentrator>();
ArrayList<FastConcentrator> fastconcentrators = new ArrayList<FastConcentrator>();

EllipseDrawer ellipseDrawer = new EllipseDrawer();
LineDrawer lineDrawer = new LineDrawer();
RectangleDrawer rectangleDrawer = new RectangleDrawer();
TriangleDrawer triangleDrawer = new TriangleDrawer();

Shrink shrink = new Shrink();
Expand expand = new Expand();
Translate translate = new Translate();
Rotate rotate = new Rotate();

Calibrator calibrator = new Calibrator();
Menu menu;

EuglenaCounter fullcount;
ShowExampleCounter exampleCV;
EuglenaSystemStateMonitor euglenaMonitor;

ClearScreen clearScreenLeft;
ClearScreen clearScreenRight;
ClearScreen clearScreenUp;
ClearScreen clearScreenDown;

SlowConcentrateConstructor slowConcentrateConstructor = new SlowConcentrateConstructor();
FastConcentrateConstructor fastConcentrateConstructor = new FastConcentrateConstructor();

FastConcentrator fastConcentrateLeft;
FastConcentrator fastConcentrateRight;
FastConcentrator fastConcentrateUp;
FastConcentrator fastConcentrateDown;

SlowConcentrator slowConcentrateCenter;

PImage randBG;
boolean exp8BG = false;

char drawtype = 'd';
int preset;



///////////////////////// MAIN LOOP

void settings() {
  size(500, 500);
}

void setup() {
  count = 1;
  totalCount = 1;
  background(0);
  
  surface.setSize(displayWidth*3, displayHeight*2);
  
  screenWidth = displayWidth;
  screenHeight = displayHeight;

  ellipseMode(CORNER);
  smooth();
  
  // Capture cam - initialize correct camera
  String[] cameras = Capture.list();
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for(int i = 0; i < cameras.length; i++) {
        println(i, cameras[i]);
      }
      println(cameras[37]); 
      cam = new Capture(this, cameras[69]); //cameras[39] : 1280x1024 fps=10, cameras[37] 1280 X 800 fps=25
      cam.start();
    }
  
  // Arduino - initialize correct arduino
  String[] arduinos = Arduino.list();
    if (arduinos.length == 0) {
      println("There are no arduinos available for use.");
      exit();
    } else {
      println("Available arduinos:");
      for(int i = 0; i < arduinos.length; i++) {
        println(arduinos[i]);
      }
      println(arduinos[0]); 
      arduino = new Arduino(this, arduinos[0], 57600); // arduinos[1] : COM4
      arduino.pinMode(ardPin, Arduino.OUTPUT);
    }

  // Initializes menu
    menu = new Menu(this);
    menu.drawBackground();
    menu.drawArrows();

  //Define EuglenaCounter region for the full screen
  fullcount = new EuglenaCounter(this, 0, 0, screenWidth - menu.width, screenHeight, 500);
  
  exampleCV = new ShowExampleCounter(this);
  euglenaMonitor = new EuglenaSystemStateMonitor(this);

    clearDisplay();
}

/* Runs contionous display of mouse in the background; keeps 
track of what mode app is in and where mouse is on the screen */
void draw() {
  // camera display - webcam feed reads into background of laptop display
  if(cam.available() == true) {
     cam.read();
  }

  imageMode(CORNER);
  image(cam, 0, 0);

  fullcount.update();
  fullcount.print();


 
  if (exampleCV.displayed) {  // Show image tracking when CTRL is pressed
    exampleCV.display();
  }

  if (euglenaMonitor.displayed) {
    euglenaMonitor.update();
  }
  
  recordTimelapse(lagTime, totalTime); //Note: the maximum fps is around 5


  calibrator.draw();
  menu.draw();


  for (int i=0; i < shrinkwindows.size(); i++) {
    shrinkwindows.get(i).draw();
  }
  
  for (int i=0; i < expandwindows.size(); i++) {
    expandwindows.get(i).draw();
  }

  for (int i=0; i < translatewindows.size(); i++) {
    translatewindows.get(i).draw();
  }

  for (int i=0; i < rotatewindows.size(); i++) {
    rotatewindows.get(i).draw();
  }

  if (clearScreenLeft != null){
    boolean done = clearScreenLeft.draw();
    if (done) {
      clearScreenLeft = null;
    }
  }
  
  if (clearScreenRight != null){
    boolean done = clearScreenRight.draw();
    if (done) {
      clearScreenRight = null;
    }
  }
  
  if (clearScreenUp != null){
    boolean done = clearScreenUp.draw();
    if (done) {
      clearScreenUp = null;
    }
  }
  
  if (clearScreenDown != null){
    boolean done = clearScreenDown.draw();
    if (done) {
      clearScreenDown = null;
    }
  }
  
  if (exp8BG == true){
    if (millis() - expTimeInit < 300000){
      rectMode(CORNERS);
      strokeWeight(penWidth);
      stroke(color(rVal, gVal, bVal));
      fill(int(bgVal));

      rect(convertXCoord(displayWidth-200), convertYCoord(displayHeight+20), 
            convertXCoord((displayWidth-200)/2), convertYCoord(-20));
    } else {
      exp8BG = false;
      clearDisplay();
    }
  }
  
  
  if (randBG != null){
    if (millis() - expTimeInit < 300000 && millis() - lastDrawMillis > speed * 1000){
      randBG.loadPixels();
      for (int i = 0; i < randBG.pixels.length; i++) {
        float rand = random(1);
        color c = color(rand*bgVal);
        randBG.pixels[i] = c;
      }
    randBG.updatePixels();
    image(randBG, convertXCoord(0), convertYCoord(0));
    } else if (millis() - expTimeInit > 300000){
      randBG = null;
      clearDisplay();
    }
  }
  
  for (int i=0; i < slowconcentrators.size(); i++) {
    slowconcentrators.get(i).draw();
  }

  for (int i=0; i < fastconcentrators.size(); i++) {
    fastconcentrators.get(i).draw();
  }

}