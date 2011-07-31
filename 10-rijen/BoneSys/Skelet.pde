
class Skelet{
  Bone[] bs;
  int num = 10;
 // pnts[][] = new float[num][2];
  float q = 1/(num+0.0);
  
  Skelet(float a,float b,float c,float d,float e,float f,float g,float h){
    bs = new Bone[10];
    
    for(int i = 0;i<bs.length;i++){
      float t = i / (float)bs.length;
      bs[i] = new Bone(i, 
      curvePoint(a,c,e,g,t),
      curvePoint(b,d,f,h,t),
      curvePoint(a,c,e,g,constrain(t+q,0,1)),
      curvePoint(b,d,f,h,constrain(t+q,0,1))      
      );      
    }
    
  }
  
  void draw(){
    for(int i = 0 ;i<bs.length;i++){
      bs[i].draw();
    }
    
  }
  
}
