PImage shape;

void setup(){
  size(600,800);
  shape = loadImage("a.jpg");
  background(255);
  stroke(100,5);  
  noFill(); 
  for(int x = 0;x<width;x+=8){
    beginShape();    
    for(int y = 0;y<height;y+=8){
    vertex(x,0);    
    vertex(0,y);
   }
    endShape();
  }  
}

