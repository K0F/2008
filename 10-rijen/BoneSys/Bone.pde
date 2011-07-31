class Bone{
  float pnts[][] = new float[3][2];
  float off = 10.0;
  
  Bone(int id,float x,float y,float X,float Y){
    pnts[0][0] = x;
    pnts[0][1] = y;
    pnts[1][0] = X;
    pnts[1][1] = Y;
    off = dist(x,y,X,Y);
    pnts[2][0] = lerp(x,X,0.66);
    pnts[2][1] = lerp(y,Y,0.66)+off*0.5;
    println("x = "+pnts[0][0]);
    println("y = "+pnts[0][1]);
  }
  
  void draw(){
    stroke(0,155);
    fill(0,60);
    triangle(pnts[0][0],pnts[0][1],pnts[1][0],pnts[1][1],pnts[2][0],pnts[2][1]);
  }
}
