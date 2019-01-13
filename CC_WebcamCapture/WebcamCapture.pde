// Step 1. Import the video library.
import processing.video.*;

//Step 2. Declare a capture object.
Capture video;

// Step 5. Read from the camera when a new image is available!
void captureEvent(Capture video) {
  video.read();
}

void setup() {  
  size(640, 480);
  
  // Step 3. Initialize Capture object.
  video = new Capture(this, 640, 480);
  
  // Step 4. Start the capturing process.
  video.start();
}

// Step 6. Display the image.
void draw() {
  //tint(random(255),random(255),random(255));
  image(video, 0, 0);
  filter(THRESHOLD);
  filter(INVERT);
}
