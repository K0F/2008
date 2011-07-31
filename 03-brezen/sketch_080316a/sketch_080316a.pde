Point[] p = new Point[0];

void setup(){
  size(400,400); 
 
  background(0);
  noFill();

}

void mousePressed(){
  p = (Point[]) expand (p,p.length+1);
  p[p.length-1] = new Point(mouseX,mouseY);  
}

void draw(){
  background(0);
  beginShape();
  for(int i =0;i<p.length;i++){
    p[i].run();
    stroke(255);
    curveVertex(p[i].x,p[i].y);
    int lev = 0;
    
       
  } 
  endShape();

}

float tr(float x1,float x2){
  return (x1+x2)/2.0;  
}


class Point{
  float x,y;
  Point(float X,float Y) {
    x=X;
    y=Y;
  }

  void run(){
    compute();
    draw(); 

  }

  void compute(){

  }

  void draw(){
    point(x,y);    
  }

  boolean over(float _r){
    if(dist(mouseX,mouseY,x,y)<_r){
      return true;
    } 
    else{
      return false; 
    }
  }
}
