class AGroup{
  int nu = 1000;
  int id;
  A a[];
  float rot = 0.0;
  AGroup(int _id,int _nu){
    id=_id;   
  nu=_nu;    
    reset();
  }

  void reset(){
   
    a = new A[nu];
    
    for(int i = 0;i<nu;i++){     
      a[i] = new A(random(40,80.0),random(1.11,1.950),i,id);
        
    } 

  }

  void run(){
  //loo(0);
   // filter(BLUR);
    loo(1);

  }

  void loo(int mode){
    if(mode==0){
      pushMatrix();
      translate(0,0,-width*2);

      pushMatrix();
      rot+=0.001;
      translate(width/2.0,width/2.0,-width/2.0);
      rotateY(rot);
      stroke(0,55);
      if(id==0){
       // box(width*2);
      }
      for(int i = 0;i<nu;i++){
        a[i].draw();
      }  
      translate(-width/2.0,-width/2.0,width/2.0);
      popMatrix();

      popMatrix();  
    }
    else if(mode==1){

      pushMatrix();
      translate(0,0,-width*2);

      pushMatrix();
      rot+=0.01;
      translate(width/2.0,width/2.0,-width/2.0);
      rotateY(rot);
      stroke(0,25);
      if(id==0){
        //box(width*2);
      }
      for(int i = 0;i<nu;i++){    
        a[i].compute();        
        a[i].draw();
        
      }  
      translate(-width/2.0,-width/2.0,width/2.0);
      popMatrix();
      popMatrix();  

    }

  }


}
