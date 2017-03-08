/* Draws a black rectangle the size of the second monitor
completely covers whatever was beneath it so that it looks clear */


void clearDisplay() {
  // second monitor
  fill(color(bgVal*rbgValMod, bgVal*gbgValMod, bgVal*bbgValMod));
  noStroke();
  rectMode(CORNER);
  rect(displayWidth,0,displayWidth*4,displayHeight-10);
}