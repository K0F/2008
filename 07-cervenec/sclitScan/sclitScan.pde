// Simple Real-Time Slit-Scan Program.
// Written for Processing version 123.
// Golan Levin, December 2006.
//
// This demonstration depends on the canvas height being equal 
// to the video capture height. If you would prefer otherwise, 
// consider using the image copy() function rather than the 
// direct pixel-accessing approach I have used here. -- GL 

// Load a camera using Processing's QT library.
import processing.video.*;
Capture myVideo;


int video_width     = 320;
int video_height    = 240;
int video_slice_x   = video_width/2;
int window_width    = 1000;
int window_height   = video_height;

int draw_position_x = window_width - 1; 
boolean b_newFrame  = false;  // fresh-frame flag

//--------------------------------------------
void setup(){
  //println(myVideo.list());
  size(window_width, window_height,P3D);
  myVideo = new Capture(this, video_width, video_height);
  //frameRate(30);

  background(0,0,0);
}

//--------------------------------------------
public void captureEvent(Capture c) {
  c.read();
  b_newFrame = true;
}

//--------------------------------------------
void draw() {
  if (b_newFrame) {

    // Copy a column of pixels from the middle of the video 
    // To a location moving slowly across the canvas.
    loadPixels();
    for (int y=0; y<window_height; y++){
      int setPixelIndex = y*window_width + draw_position_x;
      int getPixelIndex = y*video_width  + video_slice_x;
      pixels[setPixelIndex] = myVideo.pixels[getPixelIndex];
    }
    updatePixels();

    // Wrap the position back to the beginning if necessary.
    draw_position_x = (draw_position_x - 1);
    if (draw_position_x < 0) {
      draw_position_x = window_width - 1;
    }
    b_newFrame = false;
  }
}

void stop(){
  myVideo.stop();
  super.stop(); 

}
