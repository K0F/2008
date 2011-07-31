class Node{
  int mat = 3;
  float[][] matix = new float[mat][mat];
  float w,h;
  float x,y,tx,ty;
  float speed = 30.0;
  float wid,heig;
  int tim = 0,lim;

  Node(){
    lim = (int)random(5,42);
    w=h=5;
    x=y=tx=ty=width/2.0;
    wid = w*mat;
    heig=h*mat;
    reset();

  }

  void run(){
    if(!over())tim++;

    if(tim%lim==0){
      lim = (int)random(50,420);
      reset();
    }

    compute();
    draw();
  }

  void compute(){
    if(!over()){
      move();
    }

  }

  void draw(){
    pushMatrix();
    fill(255,85);
    translate(x,y);
    ellipse((int)(w*1.5),(int)(h*1.5),30,30);
    image(shade,-5,-5);
    for(int i = 0;i < matix.length;i++){
      for(int q = 0;q < matix[i].length;q++){

        fill(matix[i][q]); 

        rect((int)i*w,(int)q*h,w,h);
      }
    }
    colors();

    popMatrix();
    //rect(tx,ty,w,h);

  }

  void reset(){
    for(int i = 0;i < matix.length;i++){
      for(int q = 0;q < matix[i].length;q++){
        matix[i][q] = random(255);
      }
    }


  }

  void move(){

    float up = (matix[0][0]+matix[1][0]+matix[2][0])/3.0;
    float left = (matix[0][0]+matix[0][1]+matix[0][2])/3.0;
    float down= (matix[0][2]+matix[1][2]+matix[2][2])/3.0;
    float right = (matix[2][0]+matix[2][1]+matix[2][2])/3.0;

    up = norm(up,0,255);
    left = norm(left,0,255);
    down = norm(down,0,255);
    right = norm(right,0,255);

    tx += ((norm(right-left,-0.5,0.5)*width)-tx)/speed;
    ty += ((norm(down-up,-0.5,0.5)*height)-ty)/speed;

    x+=(tx-x)/speed;
    y+=(ty-y)/speed;

    bordrs();
  }

  void bordrs(){

    if(x>width-mat*w){
      x=tx=width-mat*w;
    }
    if(y>height-mat*h){
      y=ty=height-mat*h;
    }
    if(x<0){
      x=tx=0;
    }
    if(y<0){
      y=ty=0;
    }

  }

  void colors(){
    color c[] = {
      color(matix[0][0],matix[1][0],matix[2][0]),
      color(matix[0][1],matix[1][1],matix[2][1]),
      color(matix[0][2],matix[1][2],matix[2][2])
      };

    color c2[] = {
      color(matix[0][0],matix[0][1],matix[0][2]),
      color(matix[1][0],matix[1][1],matix[1][2]),
      color(matix[2][0],matix[2][1],matix[2][2])
      };


      for(int i = 0;i < mat;i++){        
        //  fill(c[i]);
        // rect(mat*w+w,i*h,width-x,h);
        if(!over()){
          fill(c2[i]);
        }
        else{
          fill(hue(c2[i])); 
        }
        rect((int)(i*w),(int)(mat*h+h),w,height-y);

      }
    // tint(lerpColor(c2[0],lerpColor(c2[1],c2[2],.5),.66));
    //image(high,-4,-4);






  }

  boolean over(){
    boolean answ = false;
    if((mouseX>x)&& (mouseX<x+w*matix.length)&& (mouseY>y)&& (mouseY<y+h*matix[0].length)){
      answ = true;
    }
    return answ;
  }

}
