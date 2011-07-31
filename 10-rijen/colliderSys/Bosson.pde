
class Bosson{
  int id;
  int lastC;
  float x,y,tx,ty;
  float dir;
  float speed = 10.0;
  float r = 14;
  int cycle;
  color c;
  float distta;
  int chck = 0;
  float tol = r/2.0;

  Bosson(){
    id = ID;
    ID++;
    lastC=id;
    speed = random(45,50);
    cycle = (int)random(10,200);
    dir = random(-PI,PI);
    x = random(width);
    y = random(height);
    tx = id;//random(width);
    ty = 50;//random(height);
  }

  void run(){
    move();
    border(10);
    draw(); 
  }


  void move(){
     
    if(dist(x,y,path[chck][0],path[chck][1])<tol){
      chck++;
      chck=constrain(chck,0,path.length); 
      }

    tx = path[chck][0];
    ty = path[chck][1];

    x+=(tx-x+sin(tx-x/(width+0.0))*distta)/speed;
    y+=(ty-y)/speed;

    distta = (dist(x,y,tx,ty));
    dir = (atan2((ty-y),(tx-x)) );
  }

  void colide(int _id){
    x-=(b[_id].x-x)/40.0;
    y-=(b[_id].y-y)/40.0;
    //tx-=(b[_id].tx-tx)/2.0;
    //ty-=(b[_id].ty-ty)/2.0; 

  }

  void draw(){
    //noStroke();
    fill(c,120);
    pushMatrix();
    translate(x,y);
    pushMatrix();
    rotate(dir+PI/2.0);
    ellipse(0,0,r,r);
    text(id,-5,r+5);
    triangle(0,-2*r,-3,-r,3,-r);
    popMatrix();    
    popMatrix();
    c=color(255);
    stroke(0,200);
    //line(x,y,b[lastC].x,b[lastC].y);
  }

  void border(float kolik){
    tx = constrain(tx,kolik+r/2.0,width-r/2.0-kolik);
    ty = constrain(ty,kolik+r/2.0,height-r/2.0-kolik);


  }
}


