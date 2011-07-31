import processing.opengl.*;

Surfer surf;
PImage[] imgs = new PImage[3];


void setup(){
  imgs[0] = loadImage("stejkanec.png");
  imgs[1] = loadImage("makOne.png");
  imgs[2] = loadImage("makC.png");
  size(imgs[0].width,imgs[0].height,OPENGL);

  surf = new Surfer(imgs[0]);

  image(imgs[0],0,0);
}

void draw(){
  surf.run();
}

void keyPressed(){
 if(keyCode==ENTER){
  save("stejkanec.png");
 } 
 
 
}

class Surfer{ 
  int pix[];
  int xes[],yes[];
  int num;
  PImage img;
  boolean stamp[];
  Bot bot[];

  Surfer(PImage _img){
    img=_img;
    num  = img.pixels.length;
    pix = new int[num];    
    stamp = new boolean[num];

    for(int X = 0;X<img.width;X++){
      for(int Y = 0;Y<img.height;Y++){
        pix[Y*img.width+X] = (int)brightness(img.pixels[Y*img.width+X]);  
        /*stroke(pix[Y*img.width+X]);
         line(X,Y,X+1,Y);*/
      }
    }
    stampify();
  }//construct

  void stampify(){
    int cnt = 0;
    int bright = 0;
    while(cnt<(int)(0.14*(img.width*img.height))){
    xes = new int[num];
    yes = new int[num];
    for(int X = 0;X<img.width;X++){
      for(int Y = 0;Y<img.height;Y++){
        if(pix[Y*img.width+X]<bright){
          stamp[cnt] = true;
          xes[cnt] = X;
          yes[cnt] = Y;
          cnt++;
        }//if 
        else {
          stamp[cnt] = false;
        }//else
      }//for
    }//for
    bright++;
    }
    
    println("found amount of nodes on level: "+bright);
    
    int reduce = 1;
    
    while((int)(cnt/reduce)>500){
     reduce++; 
    }
      
     float[] xesM = new float[(int)(cnt/reduce)];     
     float[] yesM = new float[(int)(cnt/reduce)];
     
    
     int q = 0;
     int ch =0;
     
     while(q<(int)(cnt/reduce)){
       ch = (int)random(num);
       if(stamp[ch]){
         xesM[q] = xes[ch];
         yesM[q] = yes[ch];
         q++;
       }
     }
    
    bot = new Bot[(int)cnt/reduce];
    
    println(cnt+" nodes has been founded" );
    println("reducing to final: "+(int)cnt/reduce);
   
    for(int i = 0;i<(int)cnt/reduce;i++){

      if(stamp[i]) {
        bot[i] = new Bot(xesM[i],yesM[i],i); 
        
       
      }
    }

  }//void

  void run(){
    for(int i = 0;i<bot.length;i++){
      
      bot[i].run();
      
    }

  }


}//class

class Bot{
  float x,y,tx,ty;
  int id;
  float r = 30.0;
  float speed = 50.0;
  float dista = 1;
  float Ys = 0.21;
  
  Bot(float _x,float _y,int _id){
   
    id = _id;
    x = tx = _x;
    y = ty = _y;    
  
  }

  void run(){
    compute();
    update();
    draw();    
  }

  void compute(){
    int closeN = 0;
    for(int i = 0;i<surf.bot.length;i++){
      
      if(i!=id){
        dista = dist(surf.bot[i].x,surf.bot[i].y,x,y);
        if (dista<r){
          tx+=(surf.bot[i].x-tx)/(map(dista,0,r,speed,1));
         // if(surf.bot[i].y>y){
            ty+=Ys;
            if(Ys!=0){
              closeN++;
              r*=0.999;
            Ys*=(map(closeN,0,200,0.99999,0.999));
            }
          //}
        } 
      }
    }
  }

  void update(){
    x+=(tx-x)/speed;
    y+=(ty-y)/speed;
  }

  void draw(){
   // println(x);
    fill(0,15);
    noStroke();
    rect(x,y,2,3);
  }



}
