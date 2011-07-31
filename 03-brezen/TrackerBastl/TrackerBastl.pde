import JMyron.*;
import processing.opengl.*;

Tracker t;

void setup(){
  size(320,240,P3D);
  background(0);
  t = new Tracker(this,12);
  textFont(createFont("Arial",9));
}

void draw(){
  background(0);
  t.draw();
}

class Tracker{
  JMyron m;

  int q = 5;
  int numX = width/q;
  int numY = height/q;

  int res;
  int matix[][];

  int img[],img2[];
  int output;

  int Y = height /2;
  int X = width/2;

  int SHX = numX/2,SHY = numY/2;

  Tracker(PApplet _parent,int _res){
    img = new int[numX*numY];
    //img2 = new int[numX*numY];
    res = _res;
    matix = new int[numX/res][numY/res];

    m = new JMyron();
    m.start(numX,numY);
    m.findGlobs(0);
  }

  void draw(){
    img2 = m.image();
    m.update();
    img = m.image();
    noStroke();

    for(int y = 0; y < numY;y+=1){
      for(int x = 0; x < numX;x+=1){
        output =(color)(brightness(img[y*numX+x]));
        stroke(output);
        point(map(x,0,numX,0,width),map(y,0,numY,0,height));
      }
    }

    Y+=followY(6);
    X+=followX(6);
    SHX=X/q;
    SHY=Y/q;

    noFill();
    stroke(0xccFFCC00);
    line(0,Y,width,Y);
    line(X,0,X,height);
    rect(X-numX/res/2*10,Y-numY/res/2*10,numX/res*10,numY/res*10);

    for(int x = 0;x<matix.length;x++){
      for(int y = 0;y<matix[0].length;y++){
        fill(matix[x][y]);
        rect(x*10+5,y*10+5,8,8);
      }
    }

  }

  int followY(int kolik){
    int shiftY[] = new int[kolik*2];
    for(int i = 0;i<shiftY.length;i++){
      shiftY[i] = i-kolik;
    }
    float qa[] = new float[shiftY.length];
    float meter = 1000255;
    int result = -1;

    for(int i = 0;i<shiftY.length;i++){
      qa[i]=0;
      for(int x = 0;x<matix.length;x++){
        for(int y = 0;y<matix[0].length;y++){
          int rem = img2[constrain((y+SHY)*numX+(x+SHX),0,img2.length-1)];
          matix[x][y] = img[constrain((shiftY[i]+y+SHY)*numX+(x+SHX),0,img.length-1)];          
          qa[i] += abs(brightness(matix[x][y])-brightness(rem));   
        }
      }
      if(qa[i]<meter){
        //println(qa[i]+" "+i);
        meter = qa[i];
        result = i;            
      }
    } 

    return result-kolik;
  }

  int followX(int kolik){
    int shiftX[] = new int[kolik*2];
    for(int i = 0;i<shiftX.length;i++){
      shiftX[i] = i-kolik;
    }
    float qa[] = new float[shiftX.length];
    float meter = 1000255;
    int result = -1;

    for(int i = 0;i<shiftX.length;i++){
      qa[i]=0;
      for(int x = 0;x<matix.length;x++){
        for(int y = 0;y<matix[0].length;y++){
         int rem = img2[constrain((y+SHY)*numX+(x+SHX),0,img2.length-1)];
          matix[x][y] = img[constrain((y+SHY)*numX+(shiftX[i]+x+SHX),0,img.length-1)];                
          qa[i] += abs(brightness(matix[x][y])-brightness(rem));   
        }
      }
      if(qa[i]<meter){
        //println(qa[i]+" "+i);
        meter = qa[i];
        result = i;            
      } 
    }    
    return result-kolik;
  }

  boolean changeState(boolean what){
    return !what;
  }
}

void mousePressed(){
  t.SHX=mouseX/t.q; 
  t.SHY=mouseY/t.q;
  t.X=mouseX;
  t.Y=mouseY;  
}


