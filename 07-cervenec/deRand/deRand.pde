import processing.opengl.*;

int rat = 4;
int tol = 80;

void setup(){
  size(400,400,P3D);
  background(0);
  
  for(int x = 0;x<width;x++){
    for(int y = 0;y<height;y++){
      // color c = color(255*(sin((mouseX+x)/(mouseY+1))+1),255*(cos((mouseY+y)/(mouseX+1))+1),15);
    color c = color(random(255),random(255),random(255));   
   
       set(x, y, c);
    
   
      
    } 
  }

}

void draw(){
  for(int x = 0;x<width;x++){
    for(int y = 0;y<height;y++){
      // color c = color(255*(sin((mouseX+x)/(mouseY+1))+1),255*(cos((mouseY+y)/(mouseX+1))+1),15);
    color c = color(random(255),random(255),random(255));   
    if(abs((brightness(c)-brightness(get((width+x+(int)random(-rat,rat))%width,(height+y+(int)random(-rat,rat))%height))))+
    abs(hue(c)-hue(get((width+x+(int)random(-rat,rat))%width,(height+y+(int)random(-rat,rat))%height)))+
    abs(saturation(c)-saturation(get((width+x+(int)random(-rat,rat))%width,(height+y+(int)random(-rat,rat))%height)))<tol){
       set(x, y, c);
    }
   
      
    } 
  } 
  //filter(BLUR);

}
