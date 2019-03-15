
// This is where your state machines and game logic lives


class Controller {

  Controller() {

  }
  
  void update() {
    
    // STATE MACHINE
    switch (gameState) {
      case "START":
        // clear screen
        display.clear();
        display.setPixel(target.position = (displaySize - 1), target.targetColor);
        display.setPixel(rocketOne.position = 1, rocketOne.rocketColor);
        thrustValue = 0;
        rocketOne.reset();
        
        if (currentFrame % 29 == 0) {
           gameState = "PLAY";
        }
        
        break;
      
      case "PLAY":
        display.clear();
        display.setPixel(target.position, target.targetColor);
        // cycle the target through colors
        target.flip();
        //println(rocketOne.position);
        
        
        // check if rocket has hit ground at GREEN
        if ((rocketOne.position >= (displaySize - 1)) && target.targetColor == color(0,255,0)) {
          rocketOne.score++;
          gameState = "SUCCESS";
        }
        // if rocket hits ground at RED
        if ((rocketOne.position >= (displaySize - 1)) && target.targetColor == color(255,0,0)) {
          rocketOne.score++;
          gameState = "FAIL";
        }
        // check if speed of rocket is slow (regardless of green or red)
        if ((rocketOne.speed >= 17) && (rocketOne.position >= (displaySize - 1))) {
          rocketOne.score++; 
          gameState = "FAIL";
        }
        
        
        // Check if rocket hits the ceiling
        if ((rocketOne.position < 0) || (rocketOne.position == 0)) {
          rocketOne.score++;
          gameState = "FAIL";
        }        
        
        // show my rocket in the right place by adding them to the display buffer
        display.setPixel(rocketOne.position, rocketOne.rocketColor);
         
        rocketOne.move(); 
        
        // check if rocket is out of the bounds
        if (((displaySize - 1) - rocketOne.positionInitial < 5) && (rocketOne.speed > 15)) {
          rocketOne.score++;
          gameState = "FAIL";
        }
             
        
        break;
        

      // Success case when rocket hits the target at the correct time
      case "SUCCESS":
        display.clear();
        if (rocketOne.score >= scoreMax) {
          display.setAllPixels(color(0,255,0));
          gameState = "SCORE";
        }
        else {
          display.setAllPixels(color(0,255,0));
        }

        
        break;
        
      // Fail case when rocket hits the target at the wrong time
      case "FAIL":
        display.clear();
        if (rocketOne.score >= scoreMax) {
          display.setAllPixels(color(255,0,0));
          gameState = "SCORE";
        }
        else {
          display.setAllPixels(color(255,0,0));
        }

        break;
      
      case "SCORE":
        rocketOne.score = 0;
        delay(300);
        display.setAllPixels(color(255,255,255));
      break;

      
      default:
        break;
    }
    
    // Now that we are done populating the buffer, let's show it!
    display.show();
    
  }

}


// Helper function to advance animation frames 
int nextFrame(int _animationSize) {
  if (currentFrame < _animationSize-1) {
    currentFrame++;
  } else {
    currentFrame = 0;
  }
  return currentFrame;
}  



// All the keyboard  input goes here.
// If your game starts getting too complex, you could move the key detection events insde of the player class. 
// It's a more advanced ways of doing of the same thing. Example here: https://forum.processing.org/two/discussion/comment/34602/#Comment_34602
void keyPressed() {
  int keyIndex = -1;

  //println(key);
  
  // Controls the rocket position

  //if (key == 'A' || key == 'a') {
  //  playerOne.move(-1);
  //}

  //if (key == 'D' || key == 'd') {
  //  playerOne.move(1);
  //}


  //if (key == 'J' || key == 'j') {
  //  playerTwo.move(-1);
  //}

  //if (key == 'L' || key == 'l') {
  //  playerTwo.move(1);
  //}

  if (key == 'R' || key == 'r') {
    display.clear();
    gameState = "START";
  }

}
