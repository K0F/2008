import processing.opengl.*;

import processing.video.*;

Analyzer an;

void setup() {
  size(800, 200);
  background(0); 
  textFont(loadFont("ArialMT-9.vlw"));
  textAlign(RIGHT);
  frame.setTitle("mov_flatter :: kof");
  /*an = new Analyzer(this);
   //frame.setLocation(0,50);  
   analyza();
   */
  an = new Analyzer(this,"Carrots__Peas",28);
  an.start(); //run() - threaded
}


void draw(){
  if(an.ready){
    drawResult();
  }
  else{
    loading();
  }
}
void loading(){
  background(0);
  fill(255);
  text("analyzing movie ... "+((int)(an.percent*10.0)/10.0)+"%",120,25);
  rect(10,30,map(an.percent,0,100,0,width-20),3);  
}

void drawResult(){
  background(0);
  for(int i = 0;i<an.render.length;i++){    
    stroke(an.render[i]);
    float dista = dist(map(i,0,an.render.length,0,width),0,mouseX,0);
    float q = i+map(dista,0,width,5,0);
    line(map(q,0,an.render.length,0,width),0,
    map(q,0,an.render.length,0,width),50);   
  }
  /*
  for(int i = 0;i<height;i+=an.heig){
   stroke(0);
   line(0,i,width,i); 
   }  */
}

class Analyzer extends Thread{
  Movie piece;
  String movName = "";
  String ext = ".mov";
  int fps = 30;
  
  int[] pixs;
  int precision = 4;
  int w,h,shiftX = 0,shiftY = 0;
  color c;
  int q;
  int heig = 10;
  color render[];

  boolean ready = false;
  float percent = 0;

  ////  //////////////////// >
  
  int frameGlob = 0;

  Analyzer(PApplet _parent,String name,int _precision){
    _precision = constrain(_precision,1,100);
    precision=_precision;
    movName = name;
    piece = new Movie(_parent,movName+ext,fps);
    w = piece.width;
    h = piece.height;    
    println("analyzing movie");
    println("/////////////////");
    println("filename: "+movName+ext);
    println("duration: "+piece.duration());
    println("no. of frames:"+(int)(fps*piece.duration()));
    render = new color[(int)(fps*piece.duration())];
    pixs = new int[piece.width*piece.height+1];
    piece.play(); 
  }

  void run(){     
    analyze();
    println("done!");
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
    while(!ready){
      piece.read();
      for(int x = 0;x<piece.width;x+=precision){
        for(int y = 0;y<piece.height;y+=precision){
          q = ((piece.pixels[y*piece.height+x]));
          c = lerpColor((q),c,0.5f);        
        }
      }

      frameGlob+=1;
      render[frameGlob] = (color)c;
      percent = map(frameGlob,0,render.length,0,100.0f);
      if(frameGlob>=render.length-1){
        ready = true;
        saveRaw();
      }   // out

    }
  }

  String[] RawString(){
    String[] a = new String[render.length];   
    for(int i =0;i<render.length;i++){
      a[i] = render[i]+"";
    }
    return a;
  }

  void saveRaw(){
    println(RawString().length +" values stored");
    saveStrings("renderDats/"+movName+".dat",RawString());
    println("saving to: ./renderDats/"+movName+".dat"); 
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
