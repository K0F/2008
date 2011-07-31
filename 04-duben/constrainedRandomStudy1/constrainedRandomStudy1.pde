import processing.opengl.*;

Ret ret;
int num = 2;

void setup(){
  size(500,200,P3D);
  noStroke();
  ret = new Ret(4); 
  textFont(createFont("Veranda",10));
  
  background(0);

}

void draw(){
  
    update(); 
  



}

void update(){
  num++;
  ret.reset(num);
  ret.run();
  fill(255,0,0);
  text(num,width-50,10);

}

class Ret{
  int looper;
  color[] cols;

  int len = 8;
  int shifta=0;
  int w = (int)(width/len);
  int h = (int)(height/len);
  color[][] c;

  Ret(int _looper){
    looper = _looper;
    reset(looper);
  }

  void reset(int _num){
    looper = _num;

    cols = new color[looper];
    for(int i = 0;i<cols.length;i++){
      cols[i] = color(random(255));      
    }

    c = new color[w][h];
    for(int x = 0;x<c.length;x++){
      for(int y = 0;y<c[x].length;y++){
        c[x][y] = cols[(y*w+x)%(looper-1)];
      }     
    } 
  }

  void run(){
    // shift();
    draw();
  }

  void shift(){
    shifta++;

  }

  void draw(){
    for(int x = 0;x<c.length;x++){
      for(int y = 0;y<c[x].length;y++){
        fill(c[(x+shifta)%c.length][y],5);
        rect(x*len,y*len,w,h);
      }     
    } 

  }

}
