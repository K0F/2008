//
class AGroup{
  int nu = 50;
  int id;
  A[] a = new A[nu];
  float rot = 0.0f;
  AGroup(int _id){
    id=_id;       
    reset();
  }

  void reset(){
    for(int i = 0;i<nu;i++){     
      a[i] = new A(random(3,(1+i)*100),random(1.11f,10.12f),i,id);
    
    } 

  }

  void run(){
    //loo(0);
    //filter(BLUR);
    loo(1);

  }

  void loo(int mode){
    if(mode==0){
      pushMatrix();
      translate(0,0,-width*2);

      pushMatrix();
      rot+=0.001f;
      translate(width/2.0f,width/2.0f,-width/2.0f);
      rotateY(rot);
      stroke(0,55);
      if(id==0){
        box(width*2);
      }
      for(int i = 0;i<nu;i++){
        a[i].draw();
      }  
      translate(-width/2.0f,-width/2.0f,width/2.0f);
      popMatrix();

      popMatrix();  
    }
    else if(mode==1){

      pushMatrix();
      translate(0,0,-width*2);

      pushMatrix();
      rot+=0.01f;
      translate(width/2.0f,width/2.0f,-width/2.0f);
      rotateY(rot);
      stroke(0,25);
      if(id==0){
      //  box(width*2);
      }
      for(int i = 0;i<nu;i++){    
        a[i].compute();        
        a[i].draw();
        
      }  
      translate(-width/2.0f,-width/2.0f,width/2.0f);
      popMatrix();
      popMatrix();  

    }

  }


}
