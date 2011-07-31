float[][] xy;
float x,y;
float tol = 0.01;
int counter = 0;
float speed = 0.9117;
int bw[] = {0,255};

int num = 40;

void setup(){
  size(400,400,P3D);
  background(0);
  setXYs(num);

  tri = new float[3][2];
  //print("x = "+xy[0][0]+"   y = "+xy[0][1]);
}

float _x,_y;
float[][] tri;
int triCnt;

void draw(){
  compute();
  //background(0);
  //fill(255);
  stroke(255,45);
  //line(x,y,_x,_y);
  _x=x;
  _y=y;

  if(counter%3==0){
    //println("bang"+frameCount);
    fill(color(random(255),random(255),random(255)),25);
    triangle(tri[0][0],tri[0][1],tri[1][0],tri[1][1],tri[2][0],tri[2][1]);
    tri = new float[3][2];
       
  }

}

void compute(){
  x+=(xy[counter][0]-x)*speed;
  y+=(xy[counter][1]-y)*speed;

  if(abs(x-xy[counter][0])<tol&&abs(y-xy[counter][1])<tol){
    counter++;
    tri[counter%3][0] = x;
    tri[counter%3][1] = y;
  }

  if(counter>=xy.length){
    counter = 0;
  }
}

void setXYs(int _n){

  xy=new float[_n][2];
  for(int i = 0;i<xy.length;i++){
    for(int q = 0;q<xy[i].length;q++){
      if(q==0){
        xy[i][q] = random(width);
      }
      else{
        xy[i][q] = random(height);
      }
    }
  }
}

