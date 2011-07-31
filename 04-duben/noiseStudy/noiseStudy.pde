color [][] a = new color[30][30];
int shiftX[] = {-1,0,1,1,1,0,-1,-1,
-2,-1,0,1,2,2,2,2,1,0,-1,-2,-2};
int shiftY[] = {-1,-1,-1,0,1,1,1,0,
-2,-2,-2,-2,-2,-1,0,1,2,2,2,2,2,1,0,-1};
color neighs[] = new color[8];

void setup(){
  size(a.length*10+1,a[0].length*10+1);
  reset();
}

void reset(){
  //a = new int[a.length][a[0].length];
  for(int one = 0;one<a.length;one++){
    for(int two = 0;two<a[one].length;two++){
      a[one][two] = color(random(0,255));
    }  
  } 
}

void mousePressed(){
  reset();  
}

void draw(){
  reset();
  for(int one = 0;one<a.length;one++){
    for(int two = 0;two<a[one].length;two++){      
      fill(getNeighs(one,two),25);
      rect(one*(width/a.length),two*(height/a[0].length),a.length,a[0].length);
    }  
  }
}

color getNeighs(int one,int two){
  float rs = brightness(a[one][two]);
  for(int i = 0;i<shiftX.length;i++){
   rs = (rs+brightness(a[((one+shiftX[i]+a.length)%a.length)][((two+shiftY[i]+a[0].length)%a[0].length)]))/2.01; 
  }  
  return color(rs);
  
}
