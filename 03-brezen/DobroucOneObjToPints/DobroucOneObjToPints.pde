String points[];
String spoints[] = new String[0];

float x[] = new float[0];
float y[] = new float[0];
float z[] = new float[0];
float xx[],yy[],zz[];
float xmin,xmax,ymin,ymax,zmin,zmax;
float centX,centY,centZ;

int pocet;
float theta;
float rotX;
float rotY;
boolean loaded = false;
void setup()
{
  size(800, 600, P3D);
  frameRate(30);

  noFill();

  loadPoints();
  getMinMax();
  xx = x;
  yy = y;
  zz = z;

}

void draw(){
  background(0);
  stroke(255,75);
  pushMatrix();
  translate(width/2,height/2+30,150);
  pushMatrix();
  theta+=0.01;
  rotateY(theta);
  /*
  for(int i = 0;i<pocet;i++){
   int which = constrain(i-(int)(theta*5),0,pocet-1);
   float q = dist(scl(x[i]),scl(y[i]),scl(z[i])-150,mouseX,mouseY,-150);
   float q2 = dist(scl(x[which]),scl(y[which]),scl(z[which])-150,mouseX,mouseY,-150);
   stroke(255,15);
   line(scl(x[i]),scl(y[i]),50*(sin(q/100.0)+1)+scl(z[i])-150,
   scl(x[which]),scl(y[which]),50*(sin(q2/100.0)+1)+scl(z[which])-150);
   
   
   
   
  /*pushMatrix();
   translate(scl(x[i]),scl(y[i]),scl(z[i]));
   point(0,0,0);
   
   popMatrix(); 
   }*/

  beginShape(POLYGON);
  stroke(255,85);   
  for(int i = 0;i<pocet;i++){   
    vertex(scl(x[i]),scl(y[i]),scl(z[i])-150);    
  }
  endShape();
  popMatrix();
  pushMatrix();
  beginShape(POLYGON);
  stroke(255,15);   
  for(int i = 0;i<pocet;i++){       
    //xx[i]=(xx[i]+100)%xmax;  
    vertex(scl(xx[i]),scl(y[i]),scl(zz[i])-150);
  }
  endShape();
  popMatrix();
  popMatrix();

}


void mouseDragged()
{
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}

void loadPoints(){
  points = loadStrings("test.obj");
  int gi = 0;
  for(int i = 0;i<points.length;i++){
    if(points[i].length()>0){
      if(points[i].charAt(0)=='v'&&points[i].charAt(1)==' '){
        spoints = (String[])expand(spoints,spoints.length+1);
        spoints[gi] = points[i]+"";
        x=(float[])expand(x,x.length+1);
        y=(float[])expand(y,y.length+1);
        z=(float[])expand(z,z.length+1);
        String[] tmp = splitTokens(spoints[gi]," "); 
        x[gi] = parseFloat(tmp[1]);
        y[gi] = parseFloat(tmp[2]);
        z[gi] = parseFloat(tmp[3]);   
        //println(x[gi]);
        gi++;
      } 
    }
  }

  pocet = gi;
  println(gi+" points stored");  
}

void getMinMax(){
  xmin = min(x);
  xmax = max(x);
  ymin = min(y);
  ymax = max(y);
  zmin = min(z);
  zmax = max(z); 

  centX = abs(xmin-xmax);
  centY = abs(ymin-ymax);
  centZ = abs(zmin-zmax);
}

float scl(float _v){
  float res = 0;
  float maxx = max(centX,centY,centZ);
    if(maxx==centX){
      res = (map(_v,xmin,xmax,-100,100));
    }
    else if(maxx==centX){
      res= (map(_v,ymin,ymax,-100,100));       
    }  
  else{
    res = (map(_v,zmin,zmax,-100,100));  
  }  
  return res;
}
