#include <NewSoftSerial.h>
NewSoftSerial bt(4,3);

void setup() {
  // Setup for writing to the SD card
  Serial.begin(115200);
  bt.begin(115200);
}

int intensity = 0;
int read_distance() {
  int intensity = analogRead(1);
  return intensity;
}

void loop() {
  intensity = read_distance();
  float dist = (intensity - 868) / -47.0497;

  Serial.print(intensity, DEC);
  Serial.print(", ");
  Serial.println(dist, DEC);

  bt.print(intensity, DEC);
  bt.print(", ");
  bt.println(dist, DEC);
  delay(1000);
}
