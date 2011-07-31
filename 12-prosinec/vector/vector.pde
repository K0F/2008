PVector v1, v2;

void setup() {
	size(400,400);
  smooth();
  noLoop();
  v2 = lineIntersection(10,10,300,300,10,20,15,20); 
  noFill();
}

void draw() {
  //line(v2.x, v2.y, 0,0);
  line(10,10,300,300);
  line(10,20,15,20);
  
  ellipse(v2.x, v2.y, 24, 24);
}

// Line Segment Intersection
PVector segIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
  float bx = x2 - x1;
  float by = y2 - y1;
  float dx = x4 - x3;
  float dy = y4 - y3;
 
  float b_dot_d_perp = bx * dy - by * dx;
 
  if(b_dot_d_perp == 0) return null;
 
  float cx = x3 - x1;
  float cy = y3 - y1;
 
  float t = (cx * dy - cy * dx) / b_dot_d_perp;
  if(t < 0 || t > 1) return null;
 
  float u = (cx * by - cy * bx) / b_dot_d_perp;
  if(u < 0 || u > 1) return null;
 
  return new PVector(x1+t*bx, y1+t*by);
}

// Infinite Line Intersection
PVector lineIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
  float bx = x2 - x1;
  float by = y2 - y1;
  float dx = x4 - x3;
  float dy = y4 - y3;
 
  float b_dot_d_perp = bx*dy - by*dx;
 
  if(b_dot_d_perp == 0) return null;
 
  float cx = x3-x1;
  float cy = y3-y1;
 
  float t = (cx*dy - cy*dx) / b_dot_d_perp;
 
  return new PVector(x1+t*bx, y1+t*by);
}
 

