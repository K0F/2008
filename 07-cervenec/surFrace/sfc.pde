class Surfrace{
  float pnt[][];
  color colors[] = new color[0]; 
  float[] center;
  
  Surfrace(){

    pnt = new float[3][3];
    center = center = new float[3]; 
    
    colors = (color[])expand(colors,colors.length+1);
  colors[colors.length-1] = lerpColor(#FF0000,#FFFFFF,random(1000)/1000.0);

    for(int num=0;num<pnt.length;num++){
      for(int dim=0;dim<pnt[num].length;dim++){
        pnt[num][dim] = random(-5*dim,dim*5);
      } 
    }


  } 

  void draw(){

    stroke(#ff0000,50);//stroke(0,150);
    fill(#ff0000,20);//fill(0,50);
    beginShape(TRIANGLES);
    for(int num=0;num<pnt.length;num++){
      
      stroke(colors[num/4],50);
      fill(colors[num/4],20);
      
      vertex(pnt[num][0],pnt[num][1],pnt[num][2]);
    }   
    endShape(CLOSE);
  }

  void grow(){
    
    float posib[] = {6,-6.1,5,-5.2,1.1,-10};
    int kde = pnt.length-1;
    float nnew[][] = new float[3][3];
    
    for(int num=0;num<pnt.length;num++){
      
      for(int dim=0;dim<pnt[num].length;dim++){
        if(num==0){
          nnew[num][dim] = pnt[kde-1][dim];
          center[dim] += (pnt[kde][dim]-center[dim])/100.0;
        }
        else if(num == 1){
          nnew[num][dim] = pnt[kde][dim];
           center[dim] += (pnt[kde][dim]-center[dim])/100.0;
        }
        else if(num == 2){
          nnew[num][dim] = pnt[kde-1][dim]+posib[((int)random(posib.length*5))%posib.length]*(dim+1);
           center[dim] += (pnt[kde][dim]-center[dim])/100.0;
        }      
      } 
    }
    pnt = (float[][])concat(pnt, nnew);
    
    colors = (color[])expand(colors,colors.length+1);
  colors[colors.length-1] = lerpColor(#FF0000,#FFFFFF,random(1000)/1000.0);

  }
  
  


}

