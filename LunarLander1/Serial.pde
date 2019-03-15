// Connecting the Processing to Arduino
import processing.serial.*;

Serial myPort;
// variable that is passed from processing to arduino
String val;
int thrustValueArd;

import cc.arduino.*;

Arduino arduino;

void getValue() {
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    if (val != null) {
      val = val.trim();
      if (val.equals("0")) {
        thrustValueArd = 0;
      }
      if (val.equals("1")) {
        thrustValueArd = 1;
      }
      if (val.equals("2")) {
        thrustValueArd = 2;
      }
      if (val.equals("3")) {
        thrustValueArd = 3;
      }
    }
    
    
    
    
    //if (val != null || val != "N/A") {
    //  //if (int(Integer.parseInt(val.trim())) == 1) {
    //  //  thrustValueArd = int(Integer.parseInt(val.trim()));
    //  //}
    //  thrustValueArd = int(Integer.parseInt(val.trim()));
    //  //else {
    //  //  thrustValueArd = 0;
    //  //}
    //}
    //if (val == null) {
    //  thrustValueArd = 0;
    //}
    println(thrustValueArd);
    //println(thrustValueArd);
  }
  //println(int((val.trim())));
}


void resetValue() {
  if (currentFrame == (numFrames - 1)) {
    thrustValueArd = 0;
  }
}

//void startSerial() {
  
//  // Prints out the available serial ports.
//  println(Arduino.list());
  
//  // Modify this line, by changing the "[9]" to the index of the serial
//  // port corresponding to your Arduino board (as it appears in the list
//  // printed by the line above).
//  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
//  // Set the Arduino digital pins as inputs.
//  for (int i = 0; i <= 13; i++) {
//    arduino.pinMode(i, Arduino.INPUT);
//  }
//  // Reads initial state of outputA
//  aLastState = arduino.digitalRead(4);
//}
