// For File IO
#include <SD.h>
File myFile;
int intensity = 0;
int sd_present = true;

// Filename to use
char filename[] = "data.csv";

void setup() {
  // Setup for writing to the SD card
  Serial.begin(115200);
  Serial.print("Initializing SD card...");
  // On the Ethernet Shield, CS is pin 4. It's set as an output by default.
  // Note that even if it's not used as the CS pin, the hardware SS pin 
  // (10 on most Arduino boards, 53 on the Mega) must be left as an output 
  // or the SD library functions will not work. 
   pinMode(10, OUTPUT);
 
  if (!SD.begin(10)) {
    Serial.println("SD card initialization failed!");
    sd_present = false;
    return;
  }

  Serial.println("SD card initialization done.");

  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.
  myFile = SD.open(filename, FILE_WRITE);
 
  // if the file opened okay, write to it:
  if (myFile) {
    myFile.println("Intensity (mV), Distance (approx cm)");
    myFile.close();
    
    Serial.print(filename);
    Serial.println(" open, ready to go.");
  } 
  else {
    Serial.print("There was an error opening ");
    Serial.println(filename);
  }
}

int read_distance() {
  int intensity = analogRead(1);
  return intensity;
}

void loop() {
  if(!sd_present) return;
  intensity = read_distance();
  float dist = (intensity - 868) / -47.0497;

  Serial.print(intensity, DEC);
  Serial.print(", ");
  Serial.println(dist, DEC);

  myFile = SD.open(filename, FILE_WRITE);
  myFile.print(intensity, DEC);
  myFile.print(", ");
  myFile.println(dist, DEC);
  myFile.close();
  delay(500);
}
