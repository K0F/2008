import processing.video.*;
import processing.serial.*;

Serial s;

Capture myVideo;

int speed = 120;

int video_width     = 3;
int video_height    = 288;
int video_slice_x   = video_width/2;
int window_width    = 1000;
int window_height   = video_height;

int draw_position_x = window_width - 1; 
boolean b_newFrame  = false;  // fresh-frame flag

void setup(){
  size(window_width, window_height,P3D);
  myVideo = new Capture(this, video_width, video_height);
  //println(Serial.list());
  
  s = new Serial(this,"COM2",9600);  
  s.write(speed);
}

void draw(){
  if (myVideo.available()) {

    // Copy a column of pixels from the middle of the video 
    // To a location moving slowly across the canvas.
    myVideo.loadPixels();
    for (int y=0; y<window_height; y++){
      int setPixelIndex = y*window_width + draw_position_x;
      int getPixelIndex = y*video_width  + video_slice_x;
      pixels[setPixelIndex] = myVideo.pixels[getPixelIndex];
    }
    //updatePixels();

    // Wrap the position back to the beginning if necessary.
    draw_position_x = (draw_position_x - 1);
    if (draw_position_x < 0) {
      draw_position_x = window_width - 1;
    }
    b_newFrame = false;
  }
}

public void captureEvent(Capture c) {
  c.read();
  b_newFrame = true;
}

void cyklon(){
 
  if(frameCount%60 == 0){
    s.write((int)('q'));
  }  
}

void stop(){
  myVideo.stop();
  s.write((int)('w'));
  super.stop(); 
}


void keyPressed(){
 if(key=='q'){
  s.write((int)('q'));
 } else if(key=='w'){
   s.write((int)('w'));
 }else if(key=='e'){
   s.write((int)('e'));
 }
 
 keyPressed=false;
  
}

