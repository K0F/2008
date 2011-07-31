//import processing.opengl.*;


Net net[];
int num = 50;


public void setup(){
  size(400,400,P3D);



  net = new Net[num];

  for(int i = 0; i < num;i++){
    net[i] = new Net((int)random(2,20),i); 
  }

  background(0);
  fill(255,55);
  noStroke();

  println("done!");
}


public void draw(){
  fade(5);
  for(int i = 0; i < num;i++){
    net[i].run(); 
  }



}

void fade(int _f){
  fill(0,_f);
  rect(0,0,width,height); 
}

class Net{
  float x,y,tx,ty,speed = 5.0f;
  int id,nu;
  float nois = 50.0f;
  Sub sub[];

  Net(int _nu, int _id){
    id=_id;
    nu = _nu;
    sub = new Sub[nu];

    for(int i = 0;i<nu;i++){
      sub[i] = new Sub(id,i); 
    }
  }

  void run(){
    compute(); 
    //draw();


    for(int i = 0;i<nu;i++){
      if(i!=0){
        stroke(255,15);
        line(sub[i].x,sub[i].y,sub[i-1].x,sub[i-1].y);
        noStroke();
      }
      sub[i].run(); 
    }
  }

  void draw(){
    rect(x,y,2,2);
  }

  void compute(){

    if(id!=0){
      tx+=(net[id-1].x+random(-nois,nois)-tx)/speed; 
      ty+=(net[id-1].y+random(-nois,nois)-ty)/speed; 

    } 
    else {
      tx+=(mouseX-tx)/speed; 
      ty+=(mouseY-ty)/speed;  
    }

    x += ( tx - x ) / speed;
    y += ( ty - y ) / speed;
  }


}

class Sub{
  float x,y,tx,ty,speed = 8.0f;
  int id,par;
  float nois = 5.0f;

  Sub(int _par,int _id){
    id=_id;
    par=_par;
  }

  void run(){
    compute();
    draw(); 
  }

  void draw(){
    // rect(x,y,1,1);
  }

  void compute(){

    if(id!=0){
      tx+=(net[par].sub[id-1].x+random(-nois,nois)-tx)/speed; 
      ty+=(net[par].sub[id-1].y+random(-nois,nois)-ty)/speed; 

    } 
    else {
      tx+=(net[par].x-tx)/speed; 
      ty+=(net[par].y-ty)/speed;  
    }

    x += ( tx - x ) / speed;
    y += ( ty - y ) / speed;
  }


}
