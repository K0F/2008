import processing.opengl.*;

import processing.video.*;
import processing.serial.*;

Serial s;

Capture myVideo;

int speed = 255;

int video_width     = 352;
int video_height    = 288;
int video_slice_x   = video_width/2;
int window_width    = video_width;
int window_height   = video_height;

int draw_position_x = window_width - 1; 
boolean b_newFrame  = false;  // fresh-frame flag

void setup(){
  size(window_width, window_height,OPENGL);
  myVideo = new Capture(this, video_width, video_height);
  //println(Serial.list());
  
  s = new Serial(this,"COM2",9600);  
  s.write((int)'w');
}

int counter;

void draw(){
  if(counter%3==0){
   s.write(speed); 
  }
  
  s.write((int)'w');
  
  if (myVideo.available()) {
    myVideo.read();
    image(myVideo,0,0);
    counter++;
    // Copy a column of pixels from the middle of the video 
    // To a location moving slowly across the canvas.
   //image(myVideo,draw_position_x,0);
    // Wrap the position back to the beginning if necessary.
    
  
    }
   
    
  
 // s.write((int)'w');
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
   s.write(speed);
 }
 
 keyPressed=false;
  
}

