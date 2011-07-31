import processing.opengl.*;
import processing.core.*;
import fullscreen.*;
import processing.xml.*;
import oscP5.*;
import netP5.*;

/** Earth_On_Heaven_11_05_08 :: Farnham version
 *  @author Marie Polakova Krystof Pesek
 *  @version Farnham 12-05-2008
 *  in this version the calculations of central point and scale are based on all coordinates (GPS track and stationary stars alike) 
 *  enter Fullscreen mode-> UP   escape Fullscreen mode-> DOWN  enter off-screen mode(when using projector) -> RIGHT  escape off-screen mode -> LEFT
 */



EarthOnHeaven eoh;
FullScreen fs;

// overwrite PApplet's init method 
public void init() {
  frame.setUndecorated(true);
  super.init();
}



void setup() {  

  frameRate(25);
  // set the size of the sketch to the screen resolution of the second screen - depends on the projector
  size(800,600,OPENGL);
  //size(1024,768,OPENGL);//keep here ->second most commonly used resolution

  // set the location of the undecorated frame
  frame.setLocation(0,0);
  // create the fullscreen object
  fs = new FullScreen(this); 
  // set resolution to width and height
  fs.setResolution(width,height);
  //hiding cursor
  noCursor();

  //// create icon for application //////////////////////// :: >
  String path = sketchPath("data/icon.gif");
  path.replace('\\','/');
  Image img = getToolkit().getImage(path);
  frame.setIconImage(img);

  //// cast main object here //////////////////////// :: >
  //// (PApplet, IP addresss, Port, globalSpeed) //////////////////////// :: >
  eoh = new EarthOnHeaven(this,"127.0.0.1",12000,10.0);
  background(0);
}


//// main draw loop //////////////////// >
void draw() {
  background(0);    
  eoh.draw();

}

///// enter and exit full screen mode and move the window to the external monitor if wanted
void keyPressed(){
  if(keyCode==UP){
    fs.enter();
  }
  else if (keyCode==DOWN){
    fs.leave();
  } 
  else if (keyCode==RIGHT){
    frame.setLocation(screen.width, 0);
  }
  else if (keyCode==LEFT){
    frame.setLocation(0, 0);
  }

  keyPressed = false;
}
