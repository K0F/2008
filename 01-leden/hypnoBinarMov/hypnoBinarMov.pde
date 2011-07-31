import processing.video.*;
import processing.opengl.*;

boolean pozice[][];
//////////////////////////////////// >>
int w=400,h=400;
int shift = 9;
int zoom = 1;

//////////////////////////////////// >>
float X,Y;
int cnt = 0;
int qes;

MovieMaker m;

//////////////////////////////////// >>
void setup(){
  size(w*zoom,h*zoom,OPENGL);
  frame.setTitle("hypnoBinar :: krystof pesek");
  m = new MovieMaker(this, width, height, "out/binar"+shift+"_pixel.mov",25, MovieMaker.JPEG, MovieMaker.HIGH);
  
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
  //background(155);
  cnt++;
  cnt=cnt%(pozice.length-1);
   
  for(int x=0;x<w;x++){
     X = map(x,0,w,0,width);
    
    for(int y=0;y<h;y++){
      qes = (int)random(4);
      if(qes==0){
      pozice[x][y]=!pozice[constrain(x+shift,0,pozice.length-1)][y];
      }
      if(qes==1){
       //  pozice[x][y]=!pozice[constrain(x-1,0,pozice.length-1)][y];
        pozice[x][y]=!pozice[x][constrain(y+shift,0,pozice[x].length-1)];
      }
       if(qes==2){
      pozice[x][y]=!pozice[constrain(x-shift,0,pozice.length-1)][y];
      }
       if(qes==3){
       //  pozice[x][y]=!pozice[constrain(x-1,0,pozice.length-1)][y];
        pozice[x][y]=!pozice[x][constrain(y-shift,0,pozice[x].length-1)];
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

m.addFrame();
}

void keyPressed(){
	if(key==' '){
		save("screen.png");
	} else if(keyCode==ENTER){
		m.finish();
		println("hotovo!");
	}
	keyPressed=false;

}
