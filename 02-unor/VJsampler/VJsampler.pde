
import processing.video.*;
int mode;

Movie[] mov;

void setup() {
  size(320, 240);
  background(0);
  // Load and play the video in a loop
  frameRate(25);
  
  mov = new Movie[3];

  mov[0] = new Movie(this, "1.mov");
  mov[1] = new Movie(this, "2.mov");
  mov[2] = new Movie(this, "3.mov");
}


void movieEvent(Movie mov) {
  mov.read();
}
void keyPressed(){
  if(key=='1'){
    plaY(0); 
  }
  else if(key=='2'){
    plaY(1); 
  }
  else if(key=='3'){
    plaY(2); 
  }
  keyPressed = false;

}

void plaY(int which){
  mode = which;
  mov[which].jump(0);
  mov[which].loop(); 
}

void draw() {  
  image(mov[mode], 0, 0,width,height);
}
