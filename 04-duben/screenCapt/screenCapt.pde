import java.io.*;
import javax.imageio.*;
import java.awt.*;
import java.awt.image.*;

PGraphics buff;
float X,Y,XX,YY;

Robot robot;
BufferedImage img;

void setup(){
  size(200,200);

  Toolkit toolkit = Toolkit.getDefaultToolkit();
  Dimension screenSize = toolkit.getScreenSize();
  Rectangle screenRect = new Rectangle(screenSize);
  // create screen shot
  try{
    robot = new Robot();
  }
  catch(java.awt.AWTException e){
    println(e);
  }
  
  for(int x = 0;x<width;x++){
    for(int y = 0;y<height;y++){
    stroke(color(robot.getPixelColor(x,y).getRGB()));
    point(x,y);
    }
  }

  img = robot.createScreenCapture(screenRect);
  
  
  /*
  // save captured image to PNG file
  try{
    ImageIO.write(img, "png", new File(sketchPath+"/test.png"));
  }
  catch(java.io.IOException e){
    println(e); 
  }*/

}

void draw(){
 robot.mouseMove((int)(cos(frameCount/100.0)*100)+screen.width/2,(int)(sin(frameCount/100.0)*100)+screen.height/2);   
 
  
}




