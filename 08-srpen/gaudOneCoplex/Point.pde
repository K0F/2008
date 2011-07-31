
class Point{
  float x,y,z;
  int id;
  
  Point(float _x,float _y,float _z,int _id){
    x=_x;
    y=_y;
    z=_z;
    id=_id;
  }
  
  void draw(int alph){
    //fill(255);
    noFill();
    stroke(255,alph);
    pushMatrix();
    translate(x,y,z);
    box(3);
    popMatrix();
    stroke(255,0,0);
  point(x,y,z);
  }
}
