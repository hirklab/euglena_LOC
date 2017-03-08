/*
The snapshot function takes a screenshot of the webcam portion of the 
*/

int initMillis = 0;
boolean record = false;
int frameMillis = 0;

void snapshot(){
  
  PImage c = get(0, 15, screenWidth-menu.width, screenHeight-15); //Takes the FOV
  c.save("Image" + str(millis()) + ".jpg"); //Saves the FOV with Image_____.jpg, where _____ is the number of milliseconds elapsed from the program start 
  
  //print(str(millis())+"\n");
}

void recordTimelapse(float lagtime, float maxtime){
  // checks if record state is turned off
  if (record == false){
    initMillis = 0;
    return;
  }
  
  // records the milliseconds elapsed between program start and first frame taken
  if (initMillis == 0){
    initMillis = millis();
  }
  
  // automatically turns off recording if maxtime has elapsed
  if (millis()-initMillis > maxtime*1000){
    record = false;
    return;
  }
  
  // takes snapshot if enough time has elapsed since last frame was taken
  if ((millis()-frameMillis) >= lagtime*1000){
    snapshot();
    frameMillis = millis();
  }
}