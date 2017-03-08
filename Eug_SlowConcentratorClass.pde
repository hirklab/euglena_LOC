class SlowConcentrateConstructor{
  
    SlowConcentrator slowConcentrateInProgress;
    
    boolean centerComplete;
    
    SlowConcentrateConstructor(){
      this.reset();
    }

    void reset(){
        slowConcentrateInProgress = new SlowConcentrator(-1, -1, 0);
        slowConcentrateInProgress.visible = false;
        centerComplete = false;
    }

    void mouseClicked(float x, float y){
        if (!centerComplete) {
            slowConcentrateInProgress.centerX = x;
            slowConcentrateInProgress.centerY = y;
            centerComplete = true;
        } else {
          slowConcentrateInProgress.radius = sqrt(sq(x - slowConcentrateInProgress.centerX) 
                                                + sq(y - slowConcentrateInProgress.centerY));
          
          slowConcentrateInProgress.millisInit = millis();          
          slowConcentrateInProgress.visible = true;
          slowconcentrators.add(slowConcentrateInProgress);
          
          slowConcentrateInProgress.draw();
          this.reset();
        }
    }
}
 
class SlowConcentrator{
    
    //float speed = 1;

    float centerX, centerY, radius;
    int millisInit, lastMillis, timeElapsed, lastTimeElapsed;
    boolean visible;
    
    SlowConcentrator(float centerX, float centerY, float radius){ 
        this.centerX = centerX;
        this.centerY = centerY;
        this.radius = radius;
        this.visible = true;
    }     

    void draw(){
        timeElapsed = millis() - millisInit;
        lastTimeElapsed = lastMillis - millisInit;
        
        if(convertXDistance(radius - speed * (timeElapsed / 1000)) - penWidth/2 < 15){
          //clearDisplay();
          slowconcentrators.clear();
        }
        
        if(visible && convertXDistance(radius - speed * (timeElapsed / 1000)) - penWidth/2 > 15){
          
            ellipseMode(CENTER);
            
            strokeWeight(penWidth + 4);
            stroke(color(0, 0, 0));
            noFill();
            ellipse(convertXCoord(centerX), convertYCoord(centerY), 
                    2*convertXDistance(radius - speed * (timeElapsed / 1000)), 
                    2*convertYDistance(radius - speed * (timeElapsed / 1000)));
           
            
            strokeWeight(penWidth);
            stroke(color(rVal, gVal, bVal));
            noFill();
            
            ellipse(convertXCoord(centerX), convertYCoord(centerY), 
                    2*convertXDistance(radius - speed * (timeElapsed / 1000)), 
                    2*convertYDistance(radius - speed * (timeElapsed / 1000)));
                    
            lastMillis = millis();       

        }
    }
}