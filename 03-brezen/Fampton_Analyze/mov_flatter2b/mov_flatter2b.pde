import processing.opengl.*;

//Apparatus_sum.mov
import processing.video.*;

Analyzer an;

void setup() {
  size(30*10, screen.height);
  background(0);
  textFont(loadFont("ArialMT-9.vlw"));
  textAlign(RIGHT);
  frameRate(80);
  frame.setLocation(0,0);
  frame.setTitle("mov_flatter :: kof");
  
  
  
  an = new Analyzer(this,"Cadenzas-I-XIV");
  an.start();
  
  //analyza();
  
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
  an.run();
  /*
  for(int i = 0;i<an.render.length;i+=2){
    
   stroke(an.render[i]);
    line(map(i,0,an.render.length,0,mouseX),0,
    map(i,0,an.render.length,0,mouseX),50);   
  }*/
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
  int page = 1;
  
  boolean ready = false;
  int percent = 0;
  
  //////////////////
  int fps = 30;
  int frameGlob = 0;

  String name = "";
  String ext = ".mov";
  Analyzer(PApplet _parent,String _name){
    name=_name+"";
        
    piece = new Movie(_parent, name+ext+"");
    w = piece.width;
    h = piece.height;
    render = new color[(int)(fps*piece.duration())];
    pixs = new int[piece.width*piece.height+1];
    piece.play(); 
  }

  void run(){     
    draw(50,50,false);
  }



  void draw(float _x,float _y,boolean show){
    pushMatrix();
    translate(_x,_y);

    for(int x = 0;x<piece.width;x+=precision){
      for(int y = 0;y<piece.height;y+=precision){
        q = ((piece.pixels[y*piece.height+x]));
        c = lerpColor(color(q),c,0.5);
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
      if(shiftY>height){
	      saveImg(page);
	      page++;
	      background(0);
	      shiftY=0;
      }
    }
    stroke(c);
    line(shiftX,shiftY,shiftX,shiftY+10);   

  }

  void analyze(){
    piece.read();
    for(int x = 0;x<piece.width;x+=precision){
      for(int y = 0;y<piece.height;y+=precision){
        q = ((piece.pixels[y*piece.height+x]));
        c = lerpColor(color(q),c,0.5);        
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
   saveImg(0);
    
  } 

}

void saveImg(int num){
	save("renders/"+an.name+"_"+num+".png");	
}
