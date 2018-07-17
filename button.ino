int oldButton;
void setup() {
  Serial.begin(115200);

  pinMode(8, INPUT);
}

void loop() {
  tick++;
  int button = digitalRead(8);
  if (button == HIGH && oldButton == LOW) {
    Serial.println("p");
  } else if (button == LOW && oldButton == HIGH) {
    Serial.println("r");
  }
  
  oldButton = button;
  delay(10);
}


