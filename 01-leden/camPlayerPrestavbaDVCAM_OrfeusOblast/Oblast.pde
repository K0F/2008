
class Oblast{
  float x,y;
  float w,h;
  boolean on = false;
  boolean[] check = new boolean[2];
  boolean lock = false;
  int id;
  
  Oblast(float _x,float _y,float _w,float _h,int _id){
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    id=_id;
  } 

  void run(){
    check[0] = over();
    noStroke();    
    fill(255,0,0,85); 
    
      
    if((check[0])&&(!check[1])){
     println("lock"); 
     if(cp.mute){
      player.send("/o"+id,1); 
       
     }
    }else if((!check[0])&&(check[1])){
      println("unlock");     
    }
    
    if(over()){
     fill(255,0,0,155);
     stroke(255); 
    }
    rect(x,y,w,h);
    check[1] = over();
  }

    boolean over(){
    boolean res = false;
    if(!lock){
      if((player.avgX >= x)&&(player.avgX <= x+w)&&(player.avgY >= y)&&(player.avgY <= y+h)){
        res = true;
      }   
    }


    return res;    
  }





}
