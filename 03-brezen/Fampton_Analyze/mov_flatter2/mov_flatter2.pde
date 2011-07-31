import processing.opengl.*;

import processing.video.*;

Analyzer an;

void setup() {
  size(30*10, 240);
  background(0); 
  textFont(loadFont("ArialMT-9.vlw"));
  textAlign(RIGHT);
  frameRate(80);
  frame.setTitle("mov_flatter :: kof");
  an = new Analyzer(this);
  //frame.setLocation(0,50);
  Thread t= new Thread();
  analyza();
  
}

void analyza(){
  println("starting analyze job");
  while(!an.ready){
    if((an.percent%10==0)&&(an.percent!=0)){
     println(an.percent+"%"); 
    }
    an.analyze();
  } 
  println("success");
}

void draw(){
  
  for(int i = 0;i<an.render.length;i+=2){
    
   stroke(an.render[i]);
    line(map(i,0,an.render.length,0,mouseX),0,
    map(i,0,an.render.length,0,mouseX),50);   
  }
  for(int i = 0;i<height;i+=an.heig){
    stroke(0);
    line(0,i,width,i); 
  }
}


class Analyzer extends Thread{
  Movie piece;
  int[] pixs;
  int precision = 4;
  int w,h,shiftX = 0,shiftY = 0;
  color c;
  int q;
  int heig = 10;
  color render[];
  
  boolean ready = false;
  int percent = 0;
  
  //////////////////
  int fps = 30;
  int frameGlob = 0;

  Analyzer(PApplet _parent){
    piece = new Movie(_parent, "Apparatus_sum.mov");
    w = piece.width;
    h = piece.height;
    render = new color[(int)(fps*piece.duration())];
    pixs = new int[piece.width*piece.height+1];
    piece.play(); 
  }

  public void run(){     
    draw(50,50,false);
  }



  void draw(float _x,float _y,boolean show){
    pushMatrix();
    translate(_x,_y);

    for(int x = 0;x<piece.width;x+=precision){
      for(int y = 0;y<piece.height;y+=precision){
        q = ((piece.pixels[y*piece.height+x]));
        c = lerpColor((q),c,0.5f);
        if(show){
          line(x/precision,y/precision,x/precision+1,y/precision);
        }
      }
    } 
    popMatrix();
    shiftX++;    
    //render[frameGlob] = (color)c;
    frameGlob+=1;
    if(shiftX>=width){

      fill(0);
      text(frameGlob/fps+" sec",width-2,shiftY+heig-1);
      shiftX=0;
      shiftY+=heig;  

    }
    stroke(c);
    line(shiftX,shiftY,shiftX,shiftY+10);   

  }

  void analyze(){
    piece.read();
    for(int x = 0;x<piece.width;x+=precision){
      for(int y = 0;y<piece.height;y+=precision){
        q = ((piece.pixels[y*piece.height+x]));
        c = lerpColor((q),c,0.5f);        
      }
    }
    
    frameGlob+=1;
    render[frameGlob] = (color)c;
    if(frameGlob>=render.length-1){
      ready = true;
    }   
    percent = (int)(frameGlob/(render.length+1.0));
  }

}

void movieEvent(Movie mov) {
  mov.read();
}

void keyPressed(){
  if(keyCode==ENTER){
    save("renders/result.png");
  } 

}
