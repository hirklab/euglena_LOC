float t3;

void merge(float speed){
  

       
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
    
      arc(convertXCoord(centerX) - t2, convertYCoord(centerY),  
          (screenWidth - menu.width)/calibrator.magx - t, (screenWidth - menu.width)/calibrator.magx - t,
          PI/2, 3*PI/2, CHORD);
      arc(convertXCoord(centerX) + t2, convertYCoord(centerY), 
          (screenWidth - menu.width)/calibrator.magx - t, (screenWidth - menu.width)/calibrator.magx - t,
          -PI/2, PI/2, CHORD);
          
      t2 = t2 + speed*0.05;
    
    } else {
      
      if (t2 >= t3){
        clearDisplay();
        fill(0,0,0);
        strokeWeight(10);                              // Controls thickness of line
        stroke(color(0, 0, 255));
        ellipseMode(CENTER);
    
        arc(convertXCoord(centerX) - t2 + t3, convertYCoord(centerY),  
            (screenWidth - menu.width)/calibrator.magx - t, (screenWidth - menu.width)/calibrator.magx - t,
            PI/2, 3*PI/2, CHORD);
        arc(convertXCoord(centerX) + t2 - t3, convertYCoord(centerY), 
            (screenWidth - menu.width)/calibrator.magx - t, (screenWidth - menu.width)/calibrator.magx - t,
            -PI/2, PI/2, CHORD);
          
      t3 = t3 + speed*0.05;  //follow the white rabbit amy ??
      
      } else {
        
        ellipse(convertXCoord(centerX), convertYCoord(centerY), 
                (screenWidth - menu.width)/calibrator.magx - t, (screenWidth - menu.width)/calibrator.magx - t);
                
      }
    }
  } 
}
