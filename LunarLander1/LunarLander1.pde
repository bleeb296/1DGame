
/* /////////////////////////////////////

  4.043 Design Studio: Advanced Interactions
  February  26, 2019
  Benjamin Lee

Note:
- Don't forget to install gif library provided


*/ /////////////////////////////////////

import gifAnimation.*;                      // library for playing animated gifs

final static int displaySize = 200;          // how many pixels are visible in the game
final static int displayPixelSize = 5;     // how big should they look on screen


DisplayBuffer display = new DisplayBuffer(displaySize);    // aggregates our final visual output

// Create Rocket - White Rocket
Rocket rocketOne = new Rocket(color(255,255,255), displaySize);
// Add target with indicated speed
Target target = new Target(color(255,255,0), displaySize);              // and one target for players to catch.

//Player playerOne = new Player(color(255,0,0), displaySize);             // Adding 2 players to the game
//Player playerTwo = new Player(color(0,255,0), displaySize);
//Player playerThree = new Player(color(100,100,100), displaySize); // Add third player to this game

Score score = new Score(color(0,0,0));   // Used to display winner's color                  
int scoreMax = 3;                        // Maximum number of points before game ends

Controller controller = new Controller();   // this is where the state machine and software logic lives
String gameState = "START";

PImage[] animation;


int currentFrame = 0;
int appFramerate = 30;
int numFrames =  30;

int clock;

void settings() {
  
  size(40*displayPixelSize, (displaySize*displayPixelSize));    // dynamically sets canvas size
  
  //// configure all serial input things
  //startSerial();

}

void setup() {

    
  frameRate(appFramerate);     //  important to lock the framerate, so animations are smooth
  
  animation = Gif.getPImages(this, "Animation.gif");
  
  // Set the COM Port
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600); 
  myPort.bufferUntil('\n');
}


void draw() { 

  // Not used, but you might find helpful to count frames for animations or synchronization
  currentFrame = (currentFrame+1) % numFrames; 
  //println(currentFrame);
  
  //// get serial input and decide what  to do
  //getSerial();
  getValue();
  
  // resets rocket thrust from arduino to 0
  resetValue();
  
  //// This will reset the thrust value to 0 so that the whichever direction the user rotates, the thrust will go away...
  //if (currentFrame %  29 == 0) {
  //  rocketOne.resetThrustValue();
  //  println(thrustValue);
  //}
  
  // Function to set a clock
  if ((currentFrame > 9) && (currentFrame < 19)) {
    clock = 1;
  }
  else {
    clock = 0;
  }
  
  
  
  // Runs state machine at determined framerate
  controller.update();

}


/// FUNCTIONS FOR THRUST
// Function returns positive values when mouse wheel rotated up
float thrustValue;
void mouseWheel(MouseEvent event) {
  thrustValue = constrain(thrustValue + (event.getCount()), -1, 1);
}
