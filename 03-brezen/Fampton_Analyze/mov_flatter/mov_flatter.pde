import processing.opengl.*;

//Apparatus_sum.mov
import processing.video.*;

Analyzer an;

void setup() {
  size(30*10, 240);
  background(0); 
  textFont(loadFont("ArialMT-9.vlw"));
  an = new Analyzer(this);
  //frame.setLocation(0,50);

}

void draw(){
  an.run(); 
   for(int i = 0;i<height;i+=an.heig){
     stroke(0);
     line(0,i,width,i); 
    }
}


class Analyzer{
  Movie piece;
  int[] pixs;
  int coef = 4;
  int w,h,shiftX = 0,shiftY = 0;
  color c;
  int q;
  int heig = 10;

  Analyzer(PApplet _parent){
    piece = new Movie(_parent, "Apparatus_sum.mov");
    w = piece.width;
    h = piece.height;
    pixs = new int[piece.width*piece.height+1];
    piece.play(); 
  }

  void run(){
    //background(0);
    load(); 
    draw(50,50,false);
  }

  void load(){
    loadPixels();
    piece.pixels = piece.pixels;
  }

  void draw(float _x,float _y,boolean show){
    pushMatrix();
    translate(_x,_y);

    for(int x = 0;x<piece.width;x+=coef){
      for(int y = 0;y<piece.height;y+=coef){
        q = ((piece.pixels[y*piece.height+x]));
        c = lerpColor(color(q),c,0.5);
        if(show){
          line(x/coef,y/coef,x/coef+1,y/coef);
        }
      }
    } 
    popMatrix();
    shiftX++;
    if(shiftX>width){
      shiftX=0;
      shiftY+=heig;      
    }
    stroke(c);
    line(shiftX,shiftY,shiftX,shiftY+10);   
   
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
