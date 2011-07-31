int w = 320,h = 320;
float tol = 0.05;
int num = 1000;
int W = 30;
int H = 10;

int counter = 1;
float [][] q;/* = {{random(20,width-20),random(20,height-20)},
{random(20,width-20),random(20,height-20)},
{random(20,width-20),random(20,height-20)},
{random(20,width-20),random(20,height-20)}};*/
float x, y;
float speed = 1.3;
int jump = 1;


void setup(){
  size(w,h,P3D) ;
  
  textFont(createFont("AlBattar",8));
  textMode(SCREEN);
  
  seed(num);
 //q = //new float[4][2];
 println(q[1][0]);
 // smooth();
 background(255);
}


void draw(){
  
  //for(int i =0;i<q.length;i++){
    if(abs(x-q[jump][0])<tol&&abs(y-q[jump][1])<tol){
      fill(0);
      text(jump,q[jump][0]+5,q[jump][1]+8);
      noFill();
      jump++;
      if(jump>=q.length){
        jump=0;
        saveFrame("screen-"+counter+".png");
        counter++;
        seed(num);
        background(255);
      }
    }
  //}
    x+=(q[jump][0]-x)*(speed/10.0);
    y+=(q[jump][1]-y)*(speed/10.0);
    
  
  
  //background(255);
  stroke(0,15);
  noFill();
  rect(x,y,W,H);
}

void keyPressed(){
  if(key == ' '){
    save("frame_"+frameCount+".png");
    seed(num);
    jump=0;
    background(255);
  }
}

void seed(int num){
  num = abs(num);
  q = new float[num][2];
  int maxa;
  
  
  for(int xx = 0;xx<q.length;xx++){
    for(int yy = 0;yy<q[xx].length;yy++){
      if(yy==0){
        maxa = width-W;
      }else{
        maxa = height-H;
      }
      q[xx][yy] = random(0,maxa);
    }
  }
  x=q[0][0];y=q[0][1];
}
