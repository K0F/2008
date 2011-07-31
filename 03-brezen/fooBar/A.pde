class A{
  float x = 0;
  float y = 0;
  float dista = 0,dista2 = 0;
  int id;

  A(float _x,float _y,int _id){
    x=_x;
    y=_y;
    id=_id; 
  }

  void draw(){
    compute(1.1);

    dista = measureDistanceTo(mouseX,mouseY);    
    fill(255,dista);  
    text("<< --- "+id,(int)x+10,(int)y+5);  
    rect(x,y,10,10);


    connectToTheOthers();
  }

  void compute(float q){
    for(int i = 1;i<a.length;i++){
      if(i!=id){
        if(measureRealDistanceTo(a[i].x,a[i].y)>100){
          x+=(a[i].x-x)/2000.0;
          y+=(a[i].y-y)/2000.0;
        }else{
          x-=(a[i].x-x)/200.0;
          y-=(a[i].y-y)/200.0;
        }
      }
    }    
  }

  void connectToTheOthers(){
    noFill();
    for(int i = 1;i<a.length;i++){
      if(i!=id){
        dista = measureDistanceTo(a[i].x,a[i].y); 
        dista2 = measureRealDistanceTo(a[i].x,a[i].y);

        stroke(255,dista);    
        line(x,y,a[i].x,a[i].y);
        ellipse(x,y,dista2*2,dista2*2);
      }
    }
    noStroke();
  }

  float measureDistanceTo(float _x,float _y){
    return map(dist(x,y,_x,_y),0,width*1.33,20,0); 
  }

  float measureRealDistanceTo(float _x,float _y){
    return dist(x,y,_x,_y); 
  }

}
