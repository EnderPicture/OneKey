import processing.serial.*;    // Importing the serial library to communicate with the Arduino 

Serial myPort;      // Initializing a vairable named 'myPort' for serial communication

float background_color ;   // Variable for changing the background color\\\

int clickMaxTime = 600;
int clockOtherMaxTime = 150;
int lastClick = 0;

boolean down = false;

int shift = 0;

int textSize = 50;

int lastDown = 0;

long counter = 0;

boolean clickedOverOnce = false;

String[] charList = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","\n",".",","," "};
String[] charListView = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","ENTER",".",",","SPACE"};

void setup ( ) {

  size (500,  1500);     // Size of the serial window, you can increase or decrease as you want

  myPort = new Serial (this, "COM3",  115200); // Set the com port and the baud rate according to the Arduino IDE
  
  myPort.bufferUntil ( '\n' );   // Receiving the data from the Arduino IDE
  
  textAlign(CENTER);

} 

void draw() {
  background(0);
  counter++;
  
  if (down && millis() - lastDown > clockOtherMaxTime && !clickedOverOnce) {
    shift++;
    clickedOverOnce = true;
  }
  
  if (down && millis() - lastDown > clickMaxTime && counter % 3 == 0) {
    shift++;
  }
  
  textSize(textSize);
  for (int c = 0; c < charList.length; c++) {
    if (c == 0) {
      fill(255,0,0);
    } else {
      fill(255,255,255);
    }
      
    int charCode = c+shift >= charList.length ? c+shift-charList.length : c+shift;
    text(charListView[charCode],width/2,c*textSize+textSize);
  }
  
  if (shift >= charList.length) {
    shift = 0;
  }
}
void serialEvent  (Serial myPort) {

  String code = myPort.readStringUntil ( '\n' );
  char event = code.charAt(0);
  if (event == 'p') {
    down = true;
    lastDown = millis();
    clickedOverOnce = false;
  } else if (event == 'r') {
    down = false;
    if ( millis() - lastDown < clockOtherMaxTime ) {
      String[] list = {charList[shift]};
      saveStrings("key.txt", list);
    }
  }
  
  
  
  
} 
