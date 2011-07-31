
class Collider{
  Bosson[] q;
  int a,b;

  Collider(Bosson[] cr){
    q=cr;
  }
  
  void run(){
   check();    
  }

  void check(){
   a=b=-1;
    for(int w=0;w<q.length;w++){
      for(int i=0;i<q.length;i++){
        if(dist(q[i].x,q[i].y,q[w].x,q[w].y)<(q[i].r/2.0+q[w].r/2.0)&&w!=i){
          a=i;
          b=w;
          q[a].tx += (q[b].tx-q[a].tx)*.01;
          q[b].tx += (q[a].tx-q[b].tx)*.01;
          q[a].ty += (q[b].ty-q[a].ty)*.01;
          q[b].ty += (q[a].ty-q[b].ty)*.01;
          q[a].c = color(#ffff00);
         q[a].lastC = b;
          q[b].c = color(#ffff00);
          q[b].lastC = a;
          
          q[a].colide(b);
          q[b].colide(a);
        }
      }
      
      /*
      if(a+b!=-2){
         q[a].c = color(#FF0000);
         q[a].lastC = b;
          q[b].c = color(#FF0000);
          q[b].lastC = a;
          float X1 = q[a].tx;
          float X2 = q[b].tx;
          float Y1 = q[a].ty;
          float Y2 = q[b].ty;
        
    
           
      }   */     
      
    }

  } 


}





