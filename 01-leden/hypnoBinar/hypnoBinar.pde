import processing.opengl.*;

boolean pozice[][];
int w=100,h=100;
float X,Y;
int cnt = 0;

int zoom = 4;

void setup(){
  size(w*zoom,h*zoom,OPENGL);
  pozice = new boolean[w][h];
  for(int x=0;x<w;x++){
    for(int y=0;y<h;y++){
      
      int q = (int)random(100);
      if(q>50){
        pozice[x][y] = true;
      }
      else{
        pozice[x][y] = false;
      }
    }
  } 
  noStroke();
}

void draw(){
  background(155);
  cnt++;
  cnt=cnt%(pozice.length-1);
  for(int x=0;x<w;x++){
     X = map(x,0,w,0,width);
    for(int y=0;y<h;y++){
      int qes = (int)random(1000);
      if(qes<500){
      pozice[x][y]=!pozice[constrain(x-1,0,pozice.length-1)][y];
      }
      if(qes>500){
        pozice[x][y]=!pozice[x][constrain(y+1,0,pozice[x].length-1)];
      }
      if(pozice[x][y]){
       fill(255); 
      }else{
       fill(0); 
      }
       Y = map(y,0,h,0,height);
      rect(X,Y,zoom,zoom);
      

    }
  }


}
