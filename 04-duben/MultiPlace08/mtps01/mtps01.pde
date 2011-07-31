
import oscP5.*;
import netP5.*;
import processing.video.*;

Movie movieloop1;
Movie movieloop2;
Movie moviezoom;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() 
{
  size(320,240);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("192.168.1.108",12000);

  movieloop1 = new Movie(this, "1A"); 
  movieloop1.loop();
  movieloop2 = new Movie(this, "1C"); 
  moviezoom =  new Movie(this, "1B"); 


}


int loop1 = 0;
int loop2 = 0;
int zoom = 0;
int dir = 1; // 1=loop1 2=up 3=down 4=loop2
int rec_start = 0;
float frame = 0;

void draw() {

  background(0);

  if (dir==1) { 
  image(movieloop1, 0, 0); 
  frame = movieloop1.time();
  if (frame>=2.0) { movieloop1.stop(); dir = 2; moviezoom.jump(0.1); moviezoom.play(); }
  }


  if (dir==2) 
  { 
  image(moviezoom, 0, 0); 
  frame = moviezoom.time();
  if (frame>=2.0) { moviezoom.stop(); dir = 4; movieloop2.jump(0.1); movieloop2.loop(); }
  }

  if (dir==4) 
  { 
  image(movieloop2, 0, 0); 
  frame = movieloop2.time();
  if (frame>=2.0) { movieloop2.stop(); dir = 1; movieloop1.jump(0.1); movieloop1.loop(); }
  }

}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void oscEvent(OscMessage theOscMessage) 
{
 // rec_start = theOscMessage.get(0).intValue();
}
