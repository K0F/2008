import processing.opengl.*;
import processing.video.*;

int W=720,H=576;
int img[];
color currColor;
int num;
int time = 10; //seconds
int counter = 0;
Capture in;
MovieMaker out;

void setup(){
  size(W,H,P3D); 
  frameRate(25);
  String nazev = "timeLapse :: by kof :: cfps @ "+time;
  frame.setTitle(nazev);
  
  img = new int[W*H];
  in = new Capture(this, W, H);
  out = new MovieMaker(this,W,H,"out9.mov",25,MovieMaker.JPEG,MovieMaker.BEST);

  textFont(createFont("Arial",9));
  textMode(SCREEN );

  loadPixels();
  capture(255,false);
}

void draw(){

  if (in.available()&&(frameCount%(time*25)==0)) {
    capture(125,false);
  }


}

void capture(int tone,boolean expo){
  in.read();
  in.loadPixels();

  float h=0,l=255,curr;
  if(expo){
  for(int i = 0;i<in.pixels.length;i++){
     
    curr = brightness(color(in.pixels[i]));
    if(h<curr){
      h=curr; 
    }else if(l>curr){
      l=curr; 
    }
   
  }
  }
   println("l = "+l+"  h = "+h);
  
  //in.loadPixels();
  
  for(int x = 0;x<W;x++){
    for(int y = 0;y<H;y++){
      num = y*W+x;
      if(expo){
      curr = brightness(color(in.pixels[num]));//brightness(color(in.pixels[num]));
      stroke(map(curr,l,h,0,255),tone);
      }else{
       currColor=color(in.pixels[num]);
      stroke(currColor,tone); 
      }
      point(x,y);
    }
  }
  
 // updatePixels();
  fill(#FFCC00,150);
  text(hour()+":"+minute()+":"+second(),10,10);
  out.addFrame();
 
  println("captured time "+counter/25.0+" sec.");
  
  counter++; 
}

void keyPressed(){
  if(keyCode==ENTER){
    out.finish();
    println("done!");
    this.exit();
  } 

}
