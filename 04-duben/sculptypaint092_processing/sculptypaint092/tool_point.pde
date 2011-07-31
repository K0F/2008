// tool_point
//----------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------Point tool----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
void selectpointtool()
{
  //get latest sculptmap
  pointtoolpix.loadPixels();
  pointtoolpix.copy(b, 0, 0, 64, 64, 0, 0, 256, 256);    
  pointtoolpix.updatePixels();
  
  generate_scuptxyz();

}

//-------------------rotating points (test)---------------------------
void point_tool_rotate(int around, float inc)
{
  float tx0=0.0f; //rotate around..
  float ty0=0.0f;
  float tz0=0.0f;

  matbasic(mat1);
  if(around==0){ matrotx(mat1, arch_steprotate*inc); }//rotate around X
  if(around==1){ matroty(mat1, arch_steprotate*inc); }//rotate around Y
  if(around==2){ matrotz(mat1, arch_steprotate*inc); }//rotate around Z
  
  //
  if(point_rotscalearound==1)//scale / rotate around selected points.
  {
    int tempcounter=0;
    for (int j=0;j<32;j++)
    {
      for (int i=0;i<32;i++)
      {
        if( point_mul[(j*32)+i]==1)
        {
          int ii=i*2;
          int jj=j*2;
  
          tx0+=spx[(jj*64)+ii];
          ty0+=spy[(jj*64)+ii];
          tz0+=spz[(jj*64)+ii];
          
          tx0+=spx[(jj*64)+ii+1];
          ty0+=spy[(jj*64)+ii+1];
          tz0+=spz[(jj*64)+ii+1];

          tx0+=spx[( (jj+1)*64)+ii];
          ty0+=spy[( (jj+1)*64)+ii];
          tz0+=spz[( (jj+1)*64)+ii];

          tx0+=spx[( (jj+1)*64)+ii+1];
          ty0+=spy[( (jj+1)*64)+ii+1];
          tz0+=spz[( (jj+1)*64)+ii+1];
          tempcounter+=4;
        }
      }
    }
    //println("tempcounter: "+tempcounter);
    tx0=tx0/(float)tempcounter;
    ty0=ty0/(float)tempcounter;
    tz0=tz0/(float)tempcounter;
  }
  
  
  //get the points ready for rotation
  for (int j=0; j<64; j++)
  {
    for (int i=0; i<64; i++)
    {
      spxbuf[(j*64)+i]=spx[(j*64)+i]-tx0;
      spybuf[(j*64)+i]=spy[(j*64)+i]-ty0;
      spzbuf[(j*64)+i]=spz[(j*64)+i]-tz0;
    }
  }
  finmatpoints(mat1); // my rotated points are now in spxbuf2

  for (int j=0;j<32;j++)
  {
    for (int i=0;i<32;i++)
    {
      if( point_mul[(j*32)+i]==1)
      {
          point_getrotated(i,j, tx0,ty0,tz0);//get points from my rotated buffer
      }         
    }
  }
  

  generate_scuptxyz();
}

void point_getrotated(int x,int y, float x0, float y0,float z0)
{
  int i=x*2;
  int j=y*2;
  
  spx[(j*64)+i]=spxbuf2[(j*64)+i]+x0;
  spy[(j*64)+i]=spybuf2[(j*64)+i]+y0;
  spz[(j*64)+i]=spzbuf2[(j*64)+i]+z0;
  
  spx[(j*64)+i+1]=spxbuf2[(j*64)+i+1]+x0;
  spy[(j*64)+i+1]=spybuf2[(j*64)+i+1]+y0;
  spz[(j*64)+i+1]=spzbuf2[(j*64)+i+1]+z0;

  spx[((j+1)*64)+i]=spxbuf2[((j+1)*64)+i]+x0;
  spy[((j+1)*64)+i]=spybuf2[((j+1)*64)+i]+y0;
  spz[((j+1)*64)+i]=spzbuf2[((j+1)*64)+i]+z0;

  spx[((j+1)*64)+i+1]=spxbuf2[((j+1)*64)+i+1]+x0;
  spy[((j+1)*64)+i+1]=spybuf2[((j+1)*64)+i+1]+y0;
  spz[((j+1)*64)+i+1]=spzbuf2[((j+1)*64)+i+1]+z0;
  
}

void finmatpoints(float matrix[])
{
  float xo,yo,zo;
  for (int j=0; j<64; j++)
  {
    for (int i=0; i<64; i++)
    {
       xo=spxbuf[(j*64)+i];
       yo=spybuf[(j*64)+i];
       zo=spzbuf[(j*64)+i];     
       spxbuf2[(j*64)+i]=xo*matrix[0]+yo*matrix[1]+zo*matrix[2]+matrix[3];
       spybuf2[(j*64)+i]=xo*matrix[4]+yo*matrix[5]+zo*matrix[6]+matrix[7];
       spzbuf2[(j*64)+i]=xo*matrix[8]+yo*matrix[9]+zo*matrix[10]+matrix[11];
    }
  }
}

//-------------------------------------
void point_smooth1()
{
    int i=pointselectx*2;
    int j=pointselecty*2;
    if(i>0 && j>0 && i<64 && j<62)
    {
       int t0=((j-1)*64)+i;
       int t1=(j*64)+i;
       int t2=((j+1)*64)+i;
       int t3=((j+2)*64)+i;
       
       float tempx1=(spx[t1] + spx[t1+1] + spx[t1-1] + spx[t2]+spx[t0])/5.0f;
       float tempx2=(spx[t1+1] + spx[t1+2] + spx[t1] + spx[t2+2]+spx[t0+1])/5.0f;
       float tempx3=(spx[t2] + spx[t2+1] + spx[t2-1] + spx[t1]+spx[t3])/5.0f;
       float tempx4=(spx[t2+1] + spx[t2+2] + spx[t2] + spx[t1+1]+spx[t3+1])/5.0f;
      
       spx[(j*64)+i]=tempx1;
       spx[(j*64)+i+1]=tempx2;
       spx[((j+1)*64)+i]=tempx3;
       spx[((j+1)*64)+i+1]=tempx4;

       float tempy1=(spy[t1] + spy[t1+1] + spy[t1-1] + spy[t2]+spy[t0])/5.0f;
       float tempy2=(spy[t1+1] + spy[t1+2] + spy[t1] + spy[t2+2]+spy[t0+1])/5.0f;
       float tempy3=(spy[t2] + spy[t2+1] + spy[t2-1] + spy[t1]+spy[t3])/5.0f;
       float tempy4=(spy[t2+1] + spy[t2+2] + spy[t2] + spy[t1+1]+spy[t3+1])/5.0f;
      
       spy[(j*64)+i]=tempy1;
       spy[(j*64)+i+1]=tempy2;
       spy[((j+1)*64)+i]=tempy3;
       spy[((j+1)*64)+i+1]=tempy4;

       float tempz1=(spz[t1] + spz[t1+1] + spz[t1-1] + spz[t2]+spz[t0])/5.0f;
       float tempz2=(spz[t1+1] + spz[t1+2] + spz[t1] + spz[t2+2]+spz[t0+1])/5.0f;
       float tempz3=(spz[t2] + spz[t2+1] + spz[t2-1] + spz[t1]+spz[t3])/5.0f;
       float tempz4=(spz[t2+1] + spz[t2+2] + spz[t2] + spz[t1+1]+spz[t3+1])/5.0f;
      
       spz[(j*64)+i]=tempz1;
       spz[(j*64)+i+1]=tempz2;
       spz[((j+1)*64)+i]=tempz3;
       spz[((j+1)*64)+i+1]=tempz4;
       
    }
    generate_scuptxyz();
}

void point_clearmultiple()
{
 for(int i=0; i<(32*32); i++){ point_mul[i]=0;}  
}


void point_tool_translatex(float stepper)
{
  if(select_multiple==0)
  {  
    int i=pointselectx*2;
    int j=pointselecty*2;
    point_trans_x4( i, j,stepper);  
    point_checksym_x(i/2, j/2, stepper);
  }
  if(select_multiple==1)
  {  
     for (int j=0;j<32;j++)
     {
       for (int i=0;i<32;i++)
       {
         if( point_mul[(j*32)+i]==1)
         {
             point_trans_x4( i*2, j*2, stepper);
             point_checksym_x(i, j, stepper);
         }         
       }
     }  
  }
  generate_scuptxyz();
}
void point_checksym_x(int ii, int jj, float stepper)
{    
    int iii,jjj;
    if(symmetry_x==1)
    {
      iii=(31-ii)*2;    
      jjj=jj*2;
      point_trans_x4( iii, jjj,stepper);  
      //println("s x iii: "+iii/2); //0-32
    }
    if(symmetry_y==1)
    {
      iii=ii*2;    
      jjj=(31-jj)*2;
      point_trans_x4( iii, jjj,stepper);  
      //println("s y iii: "+iii/2); //0-32
    }
    if(symmetry_z==1)
    {
      //println("z:"); //0-32
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}
      jjj=(jj)*2;// //
      point_trans_x4( iii, jjj,stepper);            
      //println("s z iii:"+iii/2); //0-32
    }
    
    if(symmetry_x==1 && symmetry_y==1)
    {
      iii=(31-ii)*2;    
      jjj=(31-jj)*2;
      point_trans_x4( iii, jjj,stepper);            
    }
    
    if(symmetry_x==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}       
      jjj=(jj)*2;// //
      point_trans_x4( iii, jjj,stepper);
      //println("s x-z iii: "+iii/2); //0-32
    }
    if(symmetry_y==1 && symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}      
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_trans_x4( iii, jjj,stepper);
      //println("s y-z iii: "+iii/2); //0-32
    }
    if(symmetry_x==1 && symmetry_y==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}       
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_trans_x4( iii, jjj,stepper);
      //println("s x-y-z iii: "+iii/2); //0-32    
    }       
    
    //println(i+" - "+j); 
}

void point_trans_x4(int i, int j, float stepper)
{  
  if(j<64 && i<64)
  {
    spx[(j*64)+i]=spx[(j*64)+i]+stepper;
    spx[(j*64)+i+1]=spx[(j*64)+i+1]+stepper;
    spx[((j+1)*64)+i]=spx[((j+1)*64)+i]+stepper;
    spx[((j+1)*64)+i+1]=spx[((j+1)*64)+i+1]+stepper;
  }
}

void point_tool_translatey(float stepper)
{
  if(select_multiple==0)
  {  
    int i=pointselectx*2;
    int j=pointselecty*2;
    point_trans_y4(i, j, stepper);
    point_checksym_y(i/2, j/2, stepper);     
  }
  if(select_multiple==1)
  {  
     for (int j=0;j<32;j++)
     {
       for (int i=0;i<32;i++)
       {
         if( point_mul[(j*32)+i]==1)
         {
             point_trans_y4( i*2, j*2, stepper);
             point_checksym_y(i, j, stepper);
         }         
       }
     }  
  
  }
  generate_scuptxyz();
}
void point_checksym_y(int ii, int jj, float stepper)
{  
    int iii,jjj;
    if(symmetry_x==1)
    {
      iii=(31-ii)*2;
      jjj=jj*2;
      point_trans_y4(iii, jjj, stepper);
    }
    if(symmetry_y==1)
    {
      iii=(ii)*2;
      jjj=(31-jj)*2;
      point_trans_y4(iii, jjj, stepper);
    }
    if(symmetry_x==1 && symmetry_y==1)
    {
      iii=(31-ii)*2;
      jjj=(31-jj)*2;
      point_trans_y4(iii, jjj, stepper);
    }

    if(symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}
      jjj=(jj)*2;
      point_trans_y4( iii, jjj,stepper);            
    }
    
    if(symmetry_x==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}       
      jjj=(jj)*2;// //
      point_trans_y4( iii, jjj,stepper);
    }
    if(symmetry_y==1 && symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}      
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_trans_y4( iii, jjj,stepper);
    }
    if(symmetry_x==1 && symmetry_y==1 && symmetry_z==1)
    { 
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}       
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_trans_y4( iii, jjj,stepper);
    }       
    
}

void point_trans_y4(int i, int j, float stepper)
{
  if(j<64 && i<64)
  {
    spy[(j*64)+i]=spy[(j*64)+i]+stepper;
    spy[(j*64)+i+1]=spy[(j*64)+i+1]+stepper;
    spy[((j+1)*64)+i]=spy[((j+1)*64)+i]+stepper;
    spy[((j+1)*64)+i+1]=spy[((j+1)*64)+i+1]+stepper;
  }
}

void point_tool_translatez(float stepper)
{

  if(select_multiple==0)
  {  
    int i=pointselectx*2;
    int j=pointselecty*2;
    point_trans_z4(i, j, stepper);
    point_checksym_z(i/2, j/2, stepper);     
  }
  if(select_multiple==1)
  {  
     for (int j=0;j<32;j++)
     {
       for (int i=0;i<32;i++)
       {
         if( point_mul[(j*32)+i]==1)
         {
             point_trans_z4( i*2, j*2, stepper);
             point_checksym_z(i, j, stepper);
         }         
       }
     }  
  }
  generate_scuptxyz();
}

void point_checksym_z(int ii, int jj, float stepper)
{  
    int iii,jjj;
    if(symmetry_x==1)
    {
      iii=(31-ii)*2;
      jjj=jj*2;
      point_trans_z4(iii, jjj, stepper);
    }
    if(symmetry_y==1)
    {
      iii=(ii)*2;
      jjj=(31-jj)*2;
      point_trans_z4(iii, jjj, stepper);
    }
    if(symmetry_x==1 && symmetry_y==1)
    {
      iii=(31-ii)*2;
      jjj=(31-jj)*2;
      point_trans_z4(iii, jjj, stepper);
    }
    if(symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}
      jjj=(jj)*2;
      point_trans_z4( iii, jjj,stepper);            
    }
    
    if(symmetry_x==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}   
      jjj=(jj)*2;// //
      point_trans_z4( iii, jjj,stepper);
    }
    if(symmetry_y==1 && symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}      
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_trans_z4( iii, jjj,stepper);
    }
    if(symmetry_x==1 && symmetry_y==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}       
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_trans_z4( iii, jjj,stepper);
    }       
    
}
    
void point_trans_z4(int i, int j, float stepper)
{
  if(j<64 && i<64)
  {
    spz[(j*64)+i]=spz[(j*64)+i]+stepper;
    spz[(j*64)+i+1]=spz[(j*64)+i+1]+stepper;
    spz[((j+1)*64)+i]=spz[((j+1)*64)+i]+stepper;
    spz[((j+1)*64)+i+1]=spz[((j+1)*64)+i+1]+stepper;
  }
}

//-------------------scaling points---------------------------
void point_tool_scalex(float stepper)
{
  float tx0=0.0f; //scale around..
 
  if(point_rotscalearound==1)//scale / rotate around selected points.
  {
    int tempcounter=0;
    for (int j=0;j<32;j++)
    {
      for (int i=0;i<32;i++)
      {
        if( point_mul[(j*32)+i]==1)
        {
          int ii=i*2;
          int jj=j*2;
          tx0+=spx[(jj*64)+ii];
          tx0+=spx[(jj*64)+ii+1];
          tx0+=spx[( (jj+1)*64)+ii];
          tx0+=spx[( (jj+1)*64)+ii+1];
          tempcounter+=4;
        }
      }
    }    
    tx0=tx0/(float)tempcounter;
  }
  
  
  if(select_multiple==0)
  {  
    int i=pointselectx*2;
    int j=pointselecty*2;
    point_scale_x4( i, j,stepper, tx0);  
    point_checksym_scale_x(i/2, j/2, stepper, tx0);
  }
  if(select_multiple==1)
  {  
     for (int j=0;j<32;j++)
     {
       for (int i=0;i<32;i++)
       {
         if( point_mul[(j*32)+i]==1)
         {
             point_scale_x4( i*2, j*2, stepper, tx0);
             point_checksym_scale_x(i, j, stepper, tx0);
         }         
       }
     }  
  }
  generate_scuptxyz();
}
void point_checksym_scale_x(int ii, int jj, float stepper, float tx0)
{  
    int iii,jjj;
    if(symmetry_x==1)
    {
      iii=(31-ii)*2;    
      jjj=jj*2;
      point_scale_x4( iii, jjj,stepper, tx0);  
    }
    if(symmetry_y==1)
    {
      iii=ii*2;    
      jjj=(31-jj)*2;
      point_scale_x4( iii, jjj,stepper, tx0);  
    }
    if(symmetry_x==1 && symmetry_y==1)
    {
      iii=(31-ii)*2;    
      jjj=(31-jj)*2;
      point_scale_x4( iii, jjj,stepper, tx0);      
    } 
    if(symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      //println(" 1- "+iii);
      if(iii<0){iii=64+iii;}
      jjj=(jj)*2;
      point_scale_x4( iii, jjj,stepper, tx0);
      
    }
    
    if(symmetry_x==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16 // `17 66 -2
      if(iii>=64){iii=(ii-16)*2;} //(32-ii)+16;
      jjj=(jj)*2;// //
      point_scale_x4( iii, jjj,stepper, tx0);
    }
    if(symmetry_y==1 && symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_scale_x4( iii, jjj,stepper, tx0);
    }
    if(symmetry_x==1 && symmetry_y==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;} //(32-ii)+16;      
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_scale_x4( iii, jjj,stepper, tx0);
    }       


}

void point_scale_x4(int i, int j, float stepper,  float x0)
{
  if(j<64 && i<64)
  {
    spx[(j*64)+i]=      ((spx[(j*64)+i]-x0)*stepper)+x0;
    spx[(j*64)+i+1]=    ((spx[(j*64)+i+1]-x0)*stepper)+x0;
    spx[((j+1)*64)+i]=  ((spx[((j+1)*64)+i]-x0)*stepper)+x0;
    spx[((j+1)*64)+i+1]=((spx[((j+1)*64)+i+1]-x0)*stepper)+x0;      
  }
}

void point_tool_scaley(float stepper)
{
  float ty0=0.0f; //scale around..
  if(point_rotscalearound==1)//scale / rotate around selected points.
  {
    int tempcounter=0;
    for (int j=0;j<32;j++)
    {
      for (int i=0;i<32;i++)
      {
        if( point_mul[(j*32)+i]==1)
        {
          int ii=i*2;
          int jj=j*2;
          ty0+=spy[(jj*64)+ii];
          ty0+=spy[(jj*64)+ii+1];
          ty0+=spy[( (jj+1)*64)+ii];
          ty0+=spy[( (jj+1)*64)+ii+1];
          tempcounter+=4;
        }
      }
    }    
    ty0=ty0/(float)tempcounter;
  }

  
  if(select_multiple==0)
  {  
    int i=pointselectx*2;
    int j=pointselecty*2;
    point_scale_y4(i, j, stepper, ty0);
    point_checksym_scale_y(i/2, j/2, stepper, ty0);     
  }
  if(select_multiple==1)
  {  
     for (int j=0;j<32;j++)
     {
       for (int i=0;i<32;i++)
       {
         if( point_mul[(j*32)+i]==1)
         {
             point_scale_y4( i*2, j*2, stepper, ty0);
             point_checksym_scale_y(i, j, stepper, ty0);
         }         
       }
     }  
  
  }
  generate_scuptxyz();
}
void point_checksym_scale_y(int ii, int jj, float stepper, float ty0)
{  
    int iii,jjj;
    if(symmetry_x==1)
    {
      iii=(31-ii)*2;
      jjj=jj*2;
      point_scale_y4(iii, jjj, stepper, ty0);
    }
    if(symmetry_y==1)
    {
      iii=(ii)*2;
      jjj=(31-jj)*2;
      point_scale_y4(iii, jjj, stepper, ty0);
    }
    if(symmetry_x==1 && symmetry_y==1)
    {
      iii=(31-ii)*2;
      jjj=(31-jj)*2;
      point_scale_y4(iii, jjj, stepper, ty0);
    }
    if(symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}
      jjj=(jj)*2;
      point_scale_y4( iii, jjj,stepper, ty0);            
    }

  //    iii=(16+ii)*2; //0 -> 16 // `17 66 -2
  //    if(iii>=64){iii=((ii-16))*2;} //(32-ii)+16;
      
    if(symmetry_x==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=((ii-16))*2;} //(32-ii)+16;
      jjj=(jj)*2;// //
      point_scale_y4( iii, jjj,stepper, ty0);
    }
    if(symmetry_y==1 && symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;} 
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_scale_y4( iii, jjj,stepper, ty0);
    }
    if(symmetry_x==1 && symmetry_y==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}   
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_scale_y4( iii, jjj,stepper, ty0);
    }       
    
    
}

void point_scale_y4(int i, int j, float stepper, float ty0)
{
  if(j<64 && i<64)
  {
    spy[(j*64)+i]=((spy[(j*64)+i]-ty0)*stepper)+ty0;
    spy[(j*64)+i+1]=((spy[(j*64)+i+1]-ty0)*stepper)+ty0;
    spy[((j+1)*64)+i]=((spy[((j+1)*64)+i]-ty0)*stepper)+ty0;
    spy[((j+1)*64)+i+1]=((spy[((j+1)*64)+i+1]-ty0)*stepper)+ty0;      
  }
}



void point_tool_scalez(float stepper)
{
  
  float tz0=0.0f;
  if(point_rotscalearound==1)//scale / rotate around selected points.
  {
    int tempcounter=0;
    for (int j=0;j<32;j++)
    {
      for (int i=0;i<32;i++)
      {
        if( point_mul[(j*32)+i]==1)
        {
          int ii=i*2;
          int jj=j*2;
          tz0+=spz[(jj*64)+ii];
          tz0+=spz[(jj*64)+ii+1];
          tz0+=spz[( (jj+1)*64)+ii];
          tz0+=spz[( (jj+1)*64)+ii+1];
          tempcounter+=4;
        }
      }
    }    
    tz0=tz0/(float)tempcounter;
  }


  if(select_multiple==0)
  {  
    int i=pointselectx*2;
    int j=pointselecty*2;
    point_scale_z4(i, j, stepper, tz0);
    point_checkscale_z(i/2, j/2, stepper, tz0);     
  }
  if(select_multiple==1)
  {  
     for (int j=0;j<32;j++)
     {
       for (int i=0;i<32;i++)
       {
         if( point_mul[(j*32)+i]==1)
         {
             point_scale_z4( i*2, j*2, stepper, tz0);
             point_checkscale_z(i, j, stepper, tz0);
         }         
       }
     }  
  }
  generate_scuptxyz();
}

void point_checkscale_z(int ii, int jj, float stepper, float tz0)
{  
    int iii,jjj;
    if(symmetry_x==1)
    {
      iii=(31-ii)*2;
      jjj=jj*2;
      point_scale_z4(iii, jjj, stepper, tz0);
    }
    if(symmetry_y==1)
    {
      iii=(ii)*2;
      jjj=(31-jj)*2;
      point_scale_z4(iii, jjj, stepper, tz0);
    }
    if(symmetry_x==1 && symmetry_y==1)
    {
      iii=(31-ii)*2;
      jjj=(31-jj)*2;
      point_scale_z4(iii, jjj, stepper, tz0);
    }
    
    if(symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}
      jjj=(jj)*2;
      point_scale_z4( iii, jjj,stepper, tz0);            
    }
    
    if(symmetry_x==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}   
      jjj=(jj)*2;// //
      point_scale_z4( iii, jjj,stepper, tz0);
    }
    if(symmetry_y==1 && symmetry_z==1)
    {
      iii=(15-ii)*2; //0 -> 16  
      if(iii<0){iii=64+iii;}      
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_scale_z4( iii, jjj,stepper, tz0);
    }
    if(symmetry_x==1 && symmetry_y==1 && symmetry_z==1)
    {
      iii=(16+ii)*2; //0 -> 16  
      if(iii>=64){iii=(ii-16)*2;}       
      jjj=(31-jj)*2;// //jjj=(32-jj)*2;
      point_scale_z4( iii, jjj,stepper, tz0);
    }       
    
}

void point_scale_z4(int i, int j, float stepper, float tz0)
{
  if(j<64 && i<64)
  {
    spz[(j*64)+i]=((spz[(j*64)+i]-tz0)*stepper)+tz0;
    spz[(j*64)+i+1]=((spz[(j*64)+i+1]-tz0)*stepper)+tz0;
    spz[((j+1)*64)+i]=((spz[((j+1)*64)+i]-tz0)*stepper)+tz0;
    spz[((j+1)*64)+i+1]=((spz[((j+1)*64)+i+1]-tz0)*stepper)+tz0;   
  }
}



