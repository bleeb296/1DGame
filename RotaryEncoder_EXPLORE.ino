/* interrupt routine for Rotary Encoders
   tested with Noble RE0124PVB 17.7FINB-24 http://www.nobleusa.com/pdf/xre.pdf - available at pollin.de
   and a few others, seems pretty universal

   The average rotary encoder has three pins, seen from front: A C B
   Clockwise rotation A(on)->B(on)->A(off)->B(off)
   CounterCW rotation B(on)->A(on)->B(off)->A(off)

   and may be a push switch with another two pins, pulled low at pin 8 in this case
   raf@synapps.de 20120107

*/

// usually the rotary encoders three pins have the ground pin in the middle
enum PinAssignments {
  encoderPinA = 2,   // right
  encoderPinB = 3,   // left
  clearButton = 6    // another two pins
};

volatile unsigned int encoderPos = 0;  // a counter for the dial
unsigned int lastReportedPos = 1;   // change management
static boolean rotating = false;    // debounce management

// interrupt service routine vars
boolean A_set = false;
boolean B_set = false;

void setup() {
  pinMode(encoderPinA, INPUT);
  pinMode(encoderPinB, INPUT);
  pinMode(clearButton, INPUT);
  // turn on pullup resistors
  digitalWrite(encoderPinA, HIGH);
  digitalWrite(encoderPinB, HIGH);
  digitalWrite(clearButton, HIGH);

  // encoder pin on interrupt 0 (pin 2)
  attachInterrupt(0, doEncoderA, CHANGE);
  // encoder pin on interrupt 1 (pin 3)
  attachInterrupt(1, doEncoderB, CHANGE);

  Serial.begin(9600);  // output
}

int startPos;
int endPos;
int diffPos;
int val;

// main loop, work is done by interrupt service routines, this one only prints stuff
void loop() {
  rotating = true;  // reset the debouncer

  if (lastReportedPos != encoderPos) {
  // recording = true;
    //Serial.print("Index:");
    //Serial.println(encoderPos, DEC);
    lastReportedPos = encoderPos;
  }
  if (lastReportedPos <= encoderPos) {
    startPos = encoderPos;
    encoderPos = 0;  
  }
  if (lastReportedPos >= encoderPos) {
    endPos = encoderPos;
    diffPos = startPos - endPos;
    //Serial.print("DIFF IS ");
    //Serial.println(diffPos);
    delay(100);
    // slow block
    if ((diffPos > 0) && (diffPos < 5)) {
      val = 0;
    }
    if ((diffPos > 5) && (diffPos < 15)) {
      val = 1;
    }
    if ((diffPos > 15) && (diffPos < 30)) {
      val = 2;
    }
    if ((diffPos > 30)) {
      val = 3;
    }
    Serial.println(val);
    val = 0;
  }
  
  if (digitalRead(clearButton) == LOW )  {
    encoderPos = 0;
  }

}

// Interrupt on A changing state
void doEncoderA() {
  // debounce
  if ( rotating ) delay (1);  // wait a little until the bouncing is done

  // Test transition, did things really change?
  if ( digitalRead(encoderPinA) != A_set ) { // debounce once more
    A_set = !A_set;

    // adjust counter + if A leads B
    if ( A_set && !B_set )
      encoderPos += 1;


    rotating = false;  // no more debouncing until loop() hits again
  }
}

// Interrupt on B changing state, same as A above
void doEncoderB() {
  if ( rotating ) delay (1);
  if ( digitalRead(encoderPinB) != B_set ) {
    B_set = !B_set;
    //  adjust counter - 1 if B leads A
    if ( B_set && !A_set )
      encoderPos -= 1;


    rotating = false;
  }
}
