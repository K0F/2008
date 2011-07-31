Skelet s;
float pnt[][] = new float[4][2];

void setup(){
  size(500,500,P3D);
  background(255);
  pnt[0][0] = 0;
  pnt[0][1] = 50;
  pnt[1][0] = width;
  pnt[1][1] = -10;
  pnt[2][0] = lerp(pnt[0][0],pnt[1][0],0.33);
  pnt[2][1] = lerp(pnt[1][0],pnt[1][1],0.33);
  pnt[3][0] = lerp(pnt[0][0],pnt[1][0],0.66);
  pnt[3][1] = lerp(pnt[1][0],pnt[1][1],0.66);
  
    
  s = new Skelet(pnt[0][0],pnt[0][1],pnt[2][0],pnt[2][1],pnt[3][0],pnt[3][1],pnt[1][0],pnt[1][1]);
}

void draw(){
  background(255);
  s.draw();
  //curve(pnt[0][0],pnt[0][1],pnt[2][0],pnt[2][1],pnt[3][0],pnt[3][1],pnt[1][0],pnt[1][1]);
}



