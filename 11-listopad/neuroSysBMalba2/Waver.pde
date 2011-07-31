//////////////////////////////////////////
//////////////////////////////////////////

class Waver{
  
  float x,y;
  float tx,ty;
  float speed;
  int id,which;
  float distan;

  Waver(int _id,float _y){
    id=_id;
    tx=x=width/2.0f;
    ty=y=_y;
    speed = 1.0;
  }

  void move(float _avg){
    compute(_avg);
    if(sysShow){
    drw();
    }
  }

  void compute(float _avg){      
        which = constrain(id-1,0,w.length-1);
        //distan = dist(x,y,w[which].x,w[which].y);
        tx+= (w[which].x-tx)/(speed);
        
      /*  which = constrain(id+1,0,w.length-1);
       // distan = dist(x,y,w[which].x,w[which].y);
        tx+= (w[which].x-tx)/(speed);
         */
         
        distan = dist(x,y,mouseX,mouseY);
        distan = constrain(distan,10.1,height);
        if(id==0){
        x+= (_avg-x)/((distan/10.0));  
        }
        x+=(tx-x)/5.0;
  }  
  void drw(){
   float rad = dist(w[which].x,w[which].y,x,y); 
   float radC = map(rad,5.0,height/(w.length+1.0f),0.0,1.0);
  // if(radC>1.0f){radC=1.0f;}else if(radC<0.0f){radC=0.0f;}
   radC = (constrain(radC,0.0f,1.0f));  
   color c = lerpColor(#DD0000,#FFFFFF,radC);
   
   stroke(c,50);
   noFill();
   
   ellipse(x+80,y,rad*2,rad*2);
   
  /* stroke(c,45);
   line(x,y,0,y);
   stroke(c,45);
    line(x,y,width,y);   */
  }
}

//pozn. nic nemenit, vydalenost != velikost
