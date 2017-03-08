class EuglenaCounter {

    int roiX, roiY, roiWidth, roiHeight, lastMillis, avgTime;
    float previousAverage;
    boolean firstAverageReady, counting;

    OpenCV opencv;
    IntList counts;

    EuglenaCounter(PApplet parent, int roiX, int roiY, int roiWidth, int roiHeight, int avgTime) {
        this.counts = new IntList();
        this.roiX = roiX;
        this.roiY = roiY;
        this.roiWidth = roiWidth;
        this.roiHeight = roiHeight;
        this.avgTime = avgTime;

        this.opencv = new OpenCV(parent, roiWidth, roiHeight);
        this.opencv.startBackgroundSubtraction(7, 3, .35);

        this.reset();
    }

    void reset() {
        this.lastMillis = millis();
        this.counts.clear();
        this.firstAverageReady = false;
        this.previousAverage = -1;
    }

    void update() {
        if (!counting) {
            return;
        }

        PImage roiFrame = get(roiX, roiY, roiWidth, roiHeight); // Get pixels of interest and saves as image for valid image path
        this.opencv.loadImage(roiFrame);   // Input proper pixels into cv processing
        this.opencv.updateBackground();    //Necessary for background subtraction
        this.opencv.useGray();             //Create grayscale image
        this.opencv.dilate();              //Clean up image
        this.opencv.erode();
        this.opencv.blur(3);

        int count = opencv.findContours().size(); // Count number of outlines
        this.counts.append(count);

        int interval = millis() - this.lastMillis;

        if (interval > this.avgTime) {
            this.lastMillis = millis();
            this.previousAverage = 0;
            for (int c : this.counts) {
                this.previousAverage = this.previousAverage + c;
            }
            this.previousAverage = this.previousAverage / this.counts.size();
            this.firstAverageReady = true;
            this.counts.clear();

        }
    }

    float getPreviousAverage() {
        return this.previousAverage;
    }

    PImage getImage() {
        return this.opencv.getOutput();
    }

    ArrayList<Contour> getContours() {
        return this.opencv.findContours();
    }

    void print() {
        if (counting && firstAverageReady) {
            textSize(32);
            text("Euglena count: " + this.previousAverage, 50, 50);
        }
    }
}

class ShowExampleCounter {

    boolean displayed;
    final int roiCornerX = 610;
    final int roiCornerY = 290;
    final int roiWidth = 500;
    final int roiHeight = 500;

    EuglenaCounter counter;

    ShowExampleCounter(PApplet parent) {
        this.counter = new EuglenaCounter(parent, this.roiCornerX, this.roiCornerY, this.roiWidth, this.roiHeight, 500);
        this.displayed = false;
    }

    void display() {
      
      counter.update();

        rectMode(CORNER);
        stroke(100);
        noFill();
        rect(this.roiCornerX, this.roiCornerY, this.roiWidth, this.roiHeight);

        noFill();
        stroke(255, 0, 0);
        strokeWeight(3);

        for (Contour contour : counter.getContours()) {  // Loop over the outlines of moving objects
            beginShape();
            for (PVector p : contour.getPoints()) {
                vertex(p.x + this.roiCornerX, p.y + this.roiCornerY);
            }
            endShape(PConstants.CLOSE);                         // Draws outlines of moving objects
        }

        image(counter.getImage(), this.roiCornerX + this.roiWidth, this.roiCornerY, this.roiWidth, this.roiHeight);
        // Displays backend cv
        
        if(counter.firstAverageReady) {
          textSize(32);
          text("Count: " + counter.getPreviousAverage(), 300, 200);    // COunts number of euglena in region of interest
        }

    }

    void toggleDisplayed(){
        this.displayed = !this.displayed;
        this.counter.counting = !this.counter.counting;
    }

}

class EuglenaSystemStateMonitor {

    final int roiCornerX = 610;
    final int roiCornerY = 290;
    final int roiWidth = 500;
    final int roiHeight = 500;
    final int avgTime = 500;

    int lastMillis;
    float averageEuglenaSpeed, averageEuglenaOrientation;
    boolean firstVelocityAverageReady, monitoring, displayed;

    PVector averageEuglenaVelocity;
    ArrayList<PVector> euglenaVelocities;
    ArrayList<PVector> averageEuglenaVelocitiesOverTime;

    OpenCV opencv;

     EuglenaSystemStateMonitor(PApplet parent) {
       
        this.opencv = new OpenCV(parent, roiWidth, roiHeight);
        this.opencv.startBackgroundSubtraction(7, 3, .35);

        this.reset();
    }

    void reset() {
        this.lastMillis = millis();

        this.euglenaVelocities = new ArrayList<PVector>();
        this.averageEuglenaVelocitiesOverTime = new ArrayList<PVector>();

        this.averageEuglenaVelocity = new PVector(0, 0);
        this.averageEuglenaSpeed = 0;
        this.averageEuglenaOrientation = 0;

        this.monitoring = false;
        this.displayed = false;
    }

    void update(){
        if (!monitoring){
            return;
        }

        // Get the optical flow for whole FOV
        PImage roiFrame = get(roiCornerX, roiCornerY, roiWidth, roiHeight);
        this.opencv.loadImage(roiFrame);   // Input proper pixels into cv processing
        this.opencv.updateBackground();    //Necessary for background subtraction
        this.opencv.useGray();             //Create grayscale image
        this.opencv.dilate();              //Clean up image
        this.opencv.erode();
        this.opencv.blur(3);
        this.opencv.calculateOpticalFlow();

        // Find velocity for each Euglena and add to list of all Euglena velocities     
        for (Contour contour : this.opencv.findContours()) { // Loop over the outlines of moving objects
            PVector euglenaMotion = new PVector(0,0);
            for (PVector p : contour.getPoints()) {
                euglenaMotion.add(this.opencv.getFlowAt(int(p.x), int(p.y)));
            }
            euglenaMotion.div(contour.getPoints().size());
            this.euglenaVelocities.add(euglenaMotion);
        }

        // Takes all Euglena velocities and averages
        PVector instantAverageEuglenaVelocity = new PVector(0,0);
        for (PVector v : euglenaVelocities) {
            instantAverageEuglenaVelocity.add(v);
        }
        instantAverageEuglenaVelocity.div(euglenaVelocities.size());
        this.averageEuglenaVelocitiesOverTime.add(instantAverageEuglenaVelocity);

        int interval = millis() - this.lastMillis;

        if (interval >= this.avgTime) {
            this.lastMillis = millis();

            this.averageEuglenaVelocity = new PVector(0, 0);
            for (PVector n : averageEuglenaVelocitiesOverTime) {
                averageEuglenaVelocity.add(n);
            }
            averageEuglenaVelocity.div(averageEuglenaVelocitiesOverTime.size());

            this.firstVelocityAverageReady = true;

            this.euglenaVelocities.clear();
            this.averageEuglenaVelocitiesOverTime.clear();
        }

        if (firstVelocityAverageReady && displayed) {
            
            //opencv.drawOpticalFlow();

            textSize(40);
            text("Average velocity: (" + averageEuglenaVelocity.x + ", " + averageEuglenaVelocity.y + ")", 50, 50);
            text("Average speed: " + averageEuglenaSpeed(), 50, 100);
            text("Average orientation: " + averageEuglenaOrientation() + " radians", 50, 150);
        }
    }


    float averageEuglenaSpeed() {
        return (sqrt(sq(this.averageEuglenaVelocity.x) + sq(this.averageEuglenaVelocity.y)));
    }

    float averageEuglenaOrientation() {
        return (atan(this.averageEuglenaVelocity.y / this.averageEuglenaVelocity.x));
    }

    void toggleMonitoring(){
        this.monitoring = !this.monitoring;
        this.displayed = !this.displayed;
    }
}