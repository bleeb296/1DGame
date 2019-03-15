// This is the target that players need to catch.
// The 'explosion' animation could happen here rather than the state machine.
int flipCounter = 0;
int flipCounterSum = 0;
int targetCounter = 0;

class Target {

  color targetColor;
  int position;
  


  Target(color _c, int _displaySize) {
    //targetColor = _c;
    position = int(_displaySize - 1);
  }
  
   void flip() {
    // Create a new counter that is based on the internal frame rate CLOCK
    if ((currentFrame < int(numFrames / 2))) {
      flipCounter = 1;
    }
    else if ((currentFrame > int(numFrames / 2))) {
      flipCounter = 0;
    }
    if (flipCounter == 1) {
      targetCounter ++;
    }
    if (targetCounter == 30) {
      targetCounter = 0;
    }
    if (targetCounter < 12) {
      targetColor = color(255,0,0);
    }
    else if (targetCounter > 12) {
      targetColor = color(0,255,0);
    }
    //print(flipCounter);
    
    
    
    //if (currentFrame == (numFrames - 1)) {
    //  flipCounterSum ++;
    //}
    //if (flipCounterSum == 9) {
    //  flipCounterSum = 0;
    //}
    //if (flipCounterSum == 9) {
    //  targetColor = color(255,0,0);
    //}
    //if (flipCounterSum == 4) {
    //  targetColor = color(0,255,0);
    //}
    
  }
}
