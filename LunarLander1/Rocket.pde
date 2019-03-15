// This holds rocket information, like color and position.
// It also has some rocket methods for managing how a player moves.
float globalSpeed = 30;
float globalGravity = 0.1;

class Rocket {

  color rocketColor;
  int position = 0;
  int positionInitial;
  int positionFinal;
  float speed = globalSpeed;
  float speedInitial;
  float speedFinal;
  float gravity = globalGravity;
  int score;

  Rocket(color _c, int _displaySize) {
    rocketColor = _c;
    //position = int(0);       // assign player to a random position within the buffer
  }
  // function that resets the position and speed of my rocket
  void reset() {
    position = 1;
    speed = globalSpeed;
  }
  void move() {
    if ((currentFrame + 2) % 2 == 0) {
      
      positionInitial = position;
      position = position + int(0.125 * speed);
      positionFinal = position;
      
      //if ((speed > 0) && (speed < 5)) {
      //  speed = 5;
      //}
      //if ((speed < 0) && (speed > -5)) {
      //  speed = -5;
      //}
      
      // set the initial speed
      speedInitial = speed;
      speed = speed + gravity;
      speed = speed + (-0.75*abs(thrustValueArd) + 0.25*exp(gravity));
      // set the final speed
      speedFinal = speed;
      //println(speed); 
    }
  }
  
  
  //// RESET THRUST VALUE
  //void resetThrustValue () {
  //  thrustValue = 0;
  //}

  //// Move player based on keyboard input
  //void move(int _direction) {
  //  position = position + _direction;
    
  //  if (position == -1) {
  //    position = displaySize - 1;
  //  } else if (position == displaySize) {
  //    position = 0;
  //  }
    
  //}
  // Function to adjust the speed of the falling rocket
  //}  
}
