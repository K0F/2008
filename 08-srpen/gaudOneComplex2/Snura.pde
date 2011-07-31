class Snura{
  int pocetBodu;
  float x[],y[],z[];
  float xr[],yr[],zr[];
  Point[] pts;
  float pocatekDelka;
  float vule;
  
  float forceA = 200.0;
  float forceB = 30.0;

  Snura(int in, Point[] a){
    pocetBodu = in;
    x = new float[pocetBodu];
    y = new float[pocetBodu];
    z = new float[pocetBodu];
    xr = new float[pocetBodu];
    yr = new float[pocetBodu];
    zr = new float[pocetBodu];
    xr=x;yr=y;zr=z;
    pts = a;    
    calcXYZ();
    pocatekDelka = dist(pts[0].x,pts[0].y,pts[0].z,pts[1].x,pts[1].y,pts[1].z)/(pocetBodu+0.0f);
    println(pocatekDelka);
    vule = pocatekDelka*1.1;
  }

  void calcXYZ(){
    for(int i = 0;i<pocetBodu;i++){
      x[i] = lerp(pts[0].x,pts[1].x,map(i,0,pocetBodu-1,0,1));// (pts[0].x-pts[1].x)*(1/(i+0.0001))+pts[1].x;
      y[i] = lerp(pts[0].y,pts[1].y,map(i,0,pocetBodu-1,0,1));//(pts[0].y-pts[1].y)*(1/(i+0.0001))+pts[1].y;
      z[i] = lerp(pts[0].z,pts[1].z,map(i,0,pocetBodu-1,0,1));//(pts[0].z-pts[1].z)*(1/(i+0.0001))+pts[1].z;
    }
  }

  void compute(){
    for(int i = 0;i<pocetBodu;i++){
      if(i!=0&&i!=pocetBodu-1){
        float dstDalsi = dist(x[i],y[i],z[i],x[i+1],y[i+1],z[i+1]);
        float dstPredchozi = dist(x[i],y[i],z[i],x[i-1],y[i-1],z[i-1]);
        
        //z[i] -= 0.1;
        //if((dstDalsi+dstPredchozi)/2.0<vule){
        
        //}

        if(dstDalsi<vule){         
          z[i] += (z[i+1]-z[i])/(forceA);
          x[i] += (x[i+1]-x[i])/(forceA);
          y[i] += (y[i+1]-y[i])/(forceA);
        }
        else{
         
          z[i] += (z[i+1]-z[i])/(forceB);
          x[i] += (x[i+1]-x[i])/(forceB);
          y[i] += (y[i+1]-y[i])/(forceB);
        }

        if(dstPredchozi<vule){   
          z[i] += (z[i-1]-z[i])/(forceA);
          x[i] += (x[i-1]-x[i])/(forceA);
          y[i] += (y[i-1]-y[i])/(forceA);
        }
        else{
          z[i] += (z[i-1]-z[i])/(forceB);
          x[i] += (x[i-1]-x[i])/(forceB);
          y[i] += (y[i-1]-y[i])/(forceB);

        }
          z[i] -= 0.03;
          
          xr[i] += (x[i] - xr[i])*0.0001;
          yr[i] += (y[i] - yr[i])*0.0001;
          zr[i] += (z[i] - zr[i])*0.0001;

      }//if 0 1
    }//for
  }//void

  void draw(){
    compute();
    

    
    for(int i =0;i<x.length;i++){
      stroke(255);
      /*
      pushMatrix();
      rotateX(radians(-90));
      text("id : "+i,xr[i],yr[i],zr[i]);
      scale(0.1);
      
      popMatrix();
      */
      int next = constrain(i+1,0,x.length-1);
      int pre = constrain(i-1,0,x.length-1);
      
      point(xr[i],yr[i],zr[i]);
      float mom = dist(xr[i],yr[i],zr[i],xr[next],yr[next],zr[next])+dist(xr[i],yr[i],zr[i],xr[pre],yr[pre],zr[pre]);
      color q = lerpColor(color(#00ff00),color(#ff0000),map(mom,0,vule*10,0,1));
      stroke(q,55);
      line(xr[i],yr[i],zr[i],xr[pre],yr[pre],zr[pre]);
      
    }
    
  } 
}
