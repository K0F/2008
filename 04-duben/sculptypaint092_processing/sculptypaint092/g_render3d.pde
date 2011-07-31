// general_render3dmodel 




///----------------------render a sculpt color / white /wireframe-----------------
void drawsculpt()
{         
      if (rendermodez==0){noStroke();}            // colormapped
      if (rendermodez==1){noStroke();}            // plain white
      if (rendermodez==2){stroke(25,205,215, 20);}   // 90 wireframe
        
      pushMatrix();

      
      beginShape(TRIANGLES);

      
      //draw the main thing 
      for (int j=0;j<sculptsize-2;j++)
      {        
          for (int i=0;i<sculptsize-1;i++)
          {
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;
            //get the color
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}
            
              //gridflat.loadPixels();  
              //int r1=(b.pixels[t] >> 16) & 0xff;
              //int g1=(b.pixels[t] >>  8) & 0xff;
              //int b1= b.pixels[t] & 0xff;
              
            checkdrawselectsculpt(i,j);
            
            //draw the quad square
            drawtri3d(  
                    spx32[t],    spy32[t],   spz32[t],
                    spx32[t+1],  spy32[t+1], spz32[t+1],
                    spx32[tt],   spy32[tt],  spz32[tt]
                   );
            drawtri3d(  
                    spx32[t+1],  spy32[t+1],  spz32[t+1],
                    spx32[tt+1], spy32[tt+1], spz32[tt+1],
                    spx32[tt],   spy32[tt],   spz32[tt]
                   );  
                   
                     //point( spx32[t],    spy32[t],   spz32[t]);
                     
          }
      }
      
      //fill the last gap of the main thing 
      if(rendertype!=3)
      { 
        for (int j=0, i=sculptsize-1;j<sculptsize-2;j++)
        {        
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;
            //get the color
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}
            checkdrawselectsculpt(i,j);
            //draw the quad square
            drawtri3d(  
                    spx32[t],    spy32[t],   spz32[t],
                    spx32[t+1],  spy32[t+1], spz32[t+1],
                    spx32[tt],   spy32[tt],  spz32[tt]
                   );
              t=(j*sculptsize)+i;
              tt=((j*sculptsize)+0);//+i;
            drawtri3d(
                    spx32[t+1],  spy32[t+1],  spz32[t+1],  
                    spx32[t],    spy32[t],   spz32[t],
                    spx32[tt],   spy32[tt],   spz32[tt]
                   );  
        }
      }
      //draw now just the bottom parts I missed of the sculpted picture
      if(rendertype==1 || rendertype==2 )
      { 
        for (int i=0, j=sculptsize-2; i<sculptsize-2; i++)
        {       
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}

           if (drawselect==1)
            {
              if(selx==i && sely==j)
              {
                stroke(255,255,255, 255);
                fill(225, 225, 225,  255);
              }
              else
              {
                 if (rendermodez==2){stroke(25,205,215, 20);}else{noStroke();}
                
              }
            }
            drawtri3d(  
                    spx32[t],   spy32[t],       spz32[t],
                    spx32[t+1], spy32[t+1],     spz32[t+1],
                    spx32[tt],  spy32[tt],      spz32[tt]
                   ); 
      }
      for (int i=0, j=sculptsize-2; i<sculptsize-2; i++)
      {
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}
            if (drawselect==1)
            {
              if(selx==i && sely==j)
              {
                stroke(255,255,255, 255);
                fill(225, 225, 225,  255);
              }
              else
              {
                 if (rendermodez==2){stroke(25,205,215, 20);}else{noStroke();}            
              }
            }
            drawtri3d(  
                    spx32[t+1],   spy32[t+1],  spz32[t+1],
                    spx32[tt],    spy32[tt],   spz32[tt],
                    spx32[tt+1],  spy32[tt+1], spz32[tt+1]
                   );
        }      
    }
    
      //Since there seems holes in the object on top and bottom, so I want to close the object. 
      //Closing points are point no#33 on top and bottom row.
      //closing top
    if(rendertype==1)
    { 
      for (int i=0, j=0; i<sculptsize; i++)
      {
            int t=(j*sculptsize)+i;
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}
            drawtri3d(  
                    spx32[t],    spy32[t],     spz32[t],
                    spx32[t+1],  spy32[t+1],   spz32[t+1],
                    spx32[33],spy32[33],spz32[33]
                   );                   
      }
      //closing bottom
        for (int i=0, j=sculptsize-2; i<sculptsize; i++)
        {
            int t=(j*sculptsize)+i;
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}
            drawtri3d(  
                    spx32[t],    spy32[t],     spz32[t],
                    spx32[t+1],  spy32[t+1],   spz32[t+1],
                    spx32[(sculptsize*sculptsize)-31], spy32[(sculptsize*sculptsize)-31], spz32[(sculptsize*sculptsize)-31]
                   );
        }
    }
      //torus type stitch top to bottom
      if(rendertype==2)
      { 
        for (int i=0, j=sculptsize-2; i<sculptsize-1; i++)
        {       
            int t=(j*sculptsize)+i;
            int tt=((0)*sculptsize)+i;
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}

            if (drawselect==1)
            {
              if(selx==i && sely==j)
              {
                stroke(255,255,255, 255);
                fill(225, 225, 225,  255);
              }
              else
              {
                 if (rendermodez==2){stroke(25,205,215, 20);}else{noStroke();}
                
              }
            }
            drawtri3d(  
                    spx32[t],   spy32[t],       spz32[t],
                    spx32[t+1], spy32[t+1],     spz32[t+1],
                    spx32[tt],  spy32[tt],      spz32[tt]
                   ); 
      }      
      for (int i=0, j=sculptsize-2; i<sculptsize-1; i++)
      {
            int t=(j*sculptsize)+i;
            int tt=((0)*sculptsize)+i;
            if (rendermodez==0){fill(  (b.pixels[t] >> 16) & 0xff,  (b.pixels[t] >>  8) & 0xff, b.pixels[t] & 0xff,255);}
            if (rendermodez==1){fill(205,  205, 205, 255);}
            if (rendermodez==2){noFill();}
            if (drawselect==1)
            {
              if(selx==i && sely==j)
              {
                stroke(255,255,255, 255);
                fill(225, 225, 225,  255);
              }
              else
              {
                 if (rendermodez==2){stroke(25,205,215, 20);}else{noStroke();}            
              }
            }
            drawtri3d(  
                    spx32[t+1],   spy32[t+1],  spz32[t+1],
                    spx32[tt],    spy32[tt],   spz32[tt],
                    spx32[tt+1],  spy32[tt+1], spz32[tt+1]
                   );
        }
        // now draw just the last 2 closing triangles
        
        int t=(0*sculptsize)+0;//63;
        int tt=((62)*sculptsize)+0;
        drawtri3d(  
                    spx32[t],   spy32[t],       spz32[t],
                    spx32[t+63], spy32[t+63],     spz32[t+63],
                    spx32[tt],  spy32[tt],      spz32[tt]
                   ); 
        drawtri3d(  
                    spx32[t+63],   spy32[t+63],  spz32[t+63],
                    spx32[tt],    spy32[tt],   spz32[tt],
                    spx32[tt+63],  spy32[tt+63], spz32[tt+63]
                   );

    }
    

    endShape();
    popMatrix();
}


void drawtri3d(float x1,float  y1,float  z1, float  x2,float  y2,float  z2, float  x3,float  y3,float  z3)
{
  vertex(x1, y1, z1);
  vertex(x2, y2, z2);
  vertex(x3, y3, z3);
}

void checkdrawselectsculpt(int i, int j)
{
            if (drawselect==1)
            {
              if(selx==i && sely==j)
              {
                stroke(255,255,255, 255);
                fill(225, 225, 225,  255);
              }
              else
              {
                 if (rendermodez==2){stroke(25,205,215, 20);}else{noStroke();} 
              }
            }
            if (drawselect==2)
            {
              if(sely==j)//selx==i && 
              {
                stroke(255,255,255, 255);
                fill(225, 225, 225,  255);
              }
              else
              {
                 if (rendermodez==2){stroke(25,205,215, 20);}else{noStroke();} 
              }
            }       

}
///----------------------render a sculpt with texture-----------------

void drawsculpt_textured()
{

      
      noStroke();
     
      pushMatrix();
      
      textureMode(IMAGE);
 
      beginShape(TRIANGLES);
      if(paintmode==7)
      {texture(textureimg);}
      else
      {
        texture(gridinvert);      
      }
 
 
      //textureMode(NORMALIZED);

    
      //draw the main thing 
      for (int j=0;j<sculptsize-2;j++) //0
      {        
          for (int i=0;i<sculptsize-1;i++) //1
          {
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;
            
            int u1=(i*4);
            if(u1==0){u1=1;}
            int v1=(j*4);
            //if(v1==0){v1=1;}
            int u2=u1+4;
            
            if(u2==64){u2=63;}
            
            int v2=v1;
            int u3=u1;
            int v3=v1+4;
            int u4=u2;
            int v4=v1+4;

            //draw the quad square
            drawtri3dtextured(
                    spx32[t],    spy32[t],   spz32[t],   
                    spx32[t+1],  spy32[t+1], spz32[t+1], 
                    spx32[tt],   spy32[tt],  spz32[tt],  
                    u1, v1, u2, v2, u3, v3
                   );
            drawtri3dtextured(  
                    spx32[t+1],  spy32[t+1],  spz32[t+1],
                    spx32[tt+1], spy32[tt+1], spz32[tt+1],
                    spx32[tt],   spy32[tt],   spz32[tt],
                    u2,v2, u4, v4, u3,v3
                   );  
          }
      }
      
      if(rendertype!=3)
      {      
        //fill the last gap of the main thing 
        for (int j=0, i=sculptsize-1;j<sculptsize-2;j++)
        {        
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;
            
            int u1=252;
            int v1=(j*4);
            int u2=255;
            int v2=v1;
            int u3=252;
            int v3=v1+4;
            int u4=255;
            int v4=v1+4;
            
            //draw the quad square
              
            drawtri3dtextured(  
                    spx32[t],    spy32[t],   spz32[t],
                    spx32[t+1],  spy32[t+1], spz32[t+1],
                    spx32[tt],   spy32[tt],  spz32[tt],
                    u1,v1, u4, v4, u3,v3  
                   );   
                    
              t=(j*sculptsize)+i;
              tt=((j*sculptsize)+0);//+i;
            drawtri3dtextured(
                    spx32[t+1],  spy32[t+1],  spz32[t+1],  
                    spx32[t],    spy32[t],   spz32[t],
                    spx32[tt],   spy32[tt],   spz32[tt],
                    u4, v4, u1, v1,  u2, v2  
                   ); 
                 
                   
        }
      } 
      
      //draw now just the bottom parts I missed of the sculpted picture 
     if(rendertype==1 || rendertype==2)
      {     
        for (int i=0, j=sculptsize-2; i<sculptsize-2; i++)
        {     
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;          
            int u1=i*4;
            int v1=j*4;
            int u2=u1+4;
            int v2=v1;
            int u3=u1;
            int v3=v1+4;
            int u4=u1+4;
            int v4=v1+4;
            drawtri3dtextured(  
                    spx32[t],   spy32[t],       spz32[t],
                    spx32[t+1], spy32[t+1],     spz32[t+1],
                    spx32[tt],  spy32[tt],      spz32[tt],
                    u1, v1, u2, v2, u3, v3
                   ); 
        }       
         
        for (int i=0, j=sculptsize-2; i<sculptsize-2; i++)
        {
            int t=(j*sculptsize)+i;
            int tt=((j+1)*sculptsize)+i;
            int u1=i*4;
            int v1=j*4;
            int u2=u1+4;
            int v2=v1;
            int u3=u1;
            int v3=v1+4;
            int u4=u1+4;
            int v4=v1+4;
            drawtri3dtextured(  
                    spx32[t+1],   spy32[t+1],  spz32[t+1],
                    spx32[tt],    spy32[tt],   spz32[tt],
                    spx32[tt+1],  spy32[tt+1], spz32[tt+1],
                    u2,v2, u3, v3, u4,v4 // u2,v2, u4, v4, u3,v3
                   );
        }
          //fix or stitch last 2 gaps
        int t=(62*sculptsize)+0;//63;
        int tt=((63)*sculptsize);
        int u1=2*4; //i
        int v1=2*4; //j
        int u2=u1+4;
        int v2=v1;
        int u3=u1;
        int v3=v1+4;
        int u4=u1+4;
        int v4=v1+4;

        drawtri3dtextured(  
                    spx32[t],   spy32[t],       spz32[t],
                    spx32[t+62], spy32[t+62],     spz32[t+62],
                    spx32[tt],  spy32[tt],      spz32[tt],
                    u1, v1, u2, v2, u3, v3
                   ); 
        drawtri3dtextured(  
                    spx32[t+62],   spy32[t+62],  spz32[t+62],
                    spx32[tt],    spy32[tt],   spz32[tt],
                    spx32[tt+62],  spy32[tt+62], spz32[tt+62],
                    u2,v2, u3, v3, u4,v4
                   );           
     }
      
      //Since there seems holes in the object on top and bottom, so I want to close the object. 
      //Closing points are point no#33 on top and bottom row.
      //closing top
    if(rendertype==1)
     { 
        for (int i=0, j=0; i<sculptsize; i++)
        {
            int t=(j*sculptsize)+i;
            int u1=0;
            int v1=0;
            drawtri3dtextured(  
                    spx32[t],    spy32[t],     spz32[t],
                    spx32[t+1],  spy32[t+1],   spz32[t+1],
                    spx32[33],   spy32[33],    spz32[33],
                    u1, v1, u1, v1, u1, v1
                   );                   
        }      
      //closing bottom     
        for (int i=0, j=sculptsize-2; i<sculptsize; i++)
        {
            int t=(j*sculptsize)+i;
            int u1=0;
            int v1=0;
            drawtri3dtextured(  
                    spx[t],    spy[t],     spz[t],
                    spx[t+1],  spy[t+1],   spz[t+1],
                    spx[(sculptsize*sculptsize)-32], spy[(sculptsize*sculptsize)-32], spz[(sculptsize*sculptsize)-32],
                    u1,v1, u1, v1, u1,v1
                   );
        }
    }

      //torus type stitch top to bottom
     if(rendertype==2)
    {
        
        for (int i=0, j=sculptsize-1; i<sculptsize-2; i++)
        {       
            int t=(j*sculptsize)+i;
            int tt=((0)*sculptsize)+i;
            int u1=i*4;
            int v1=j*4;
            int u2=u1+4;
            int v2=v1;
            int u3=u1;
            int v3=v1+4;
            int u4=u1+4;
            int v4=v1+4;
            drawtri3dtextured(  
                    spx32[t],   spy32[t],       spz32[t],
                    spx32[t+1], spy32[t+1],     spz32[t+1],
                    spx32[tt],  spy32[tt],      spz32[tt],
                    u1, v1, u2, v2, u3, v3
                   ); 
      }      
      for (int i=0, j=sculptsize-1; i<sculptsize-2; i++)
      {
            int t=(j*sculptsize)+i;
            int tt=((0)*sculptsize)+i;
            int u1=i*4;
            int v1=j*4;
            int u2=u1+4;
            int v2=v1;
            int u3=u1;
            int v3=v1+4;
            int u4=u1+4;
            int v4=v1+4;
            drawtri3dtextured(  
                    spx32[t+1],   spy32[t+1],  spz32[t+1],
                    spx32[tt],    spy32[tt],   spz32[tt],
                    spx32[tt+1],  spy32[tt+1], spz32[tt+1],
                    u2,v2, u3, v3, u4,v4
                   );
        }
        
        int t=(0*sculptsize)+0;//63;
        int tt=((63)*sculptsize);
        int u1=2*4; //i
        int v1=2*4; //j
        int u2=u1+4;
        int v2=v1;
        int u3=u1;
        int v3=v1+4;
        int u4=u1+4;
        int v4=v1+4;

        drawtri3dtextured(  
                    spx32[t],   spy32[t],       spz32[t],
                    spx32[t+62], spy32[t+62],     spz32[t+62],
                    spx32[tt],  spy32[tt],      spz32[tt],
                    u1, v1, u2, v2, u3, v3
                   ); 
        drawtri3dtextured(  
                    spx32[t+62],   spy32[t+62],  spz32[t+62],
                    spx32[tt],    spy32[tt],   spz32[tt],
                    spx32[tt+62],  spy32[tt+62], spz32[tt+62],
                    u2,v2, u3, v3, u4,v4
                   );        
   }         
    endShape();
    popMatrix();




      
}

void drawtri3dtextured(float x1,float  y1,float  z1, float  x2,float  y2,float  z2, float  x3,float  y3,float  z3, int u1, int v1, int u2, int v2, int u3, int v3)
{
  vertex(x1, y1, z1, u1, v1);
  vertex(x2, y2, z2, u2, v2);
  vertex(x3, y3, z3, u3, v3);
}




