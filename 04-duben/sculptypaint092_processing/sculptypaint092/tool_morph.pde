//morph tool

void morph_clearmultiple()
{
    for(int j=0;j<32;j++)
    {
        for(int i=0;i<32;i++)
        {
           morph_mul[(j*32)+i]=0;
        }
    }
}


void morph_copyto_a()
{
  //screen snapshot and update icon
  morph_getimage=g.get(0,0,386,486);
  morph_image1.loadPixels();
  morph_image1.copy(morph_getimage, 11, 14, 386, 386, 0, 0, 64, 64);
  morph_image1.updatePixels();
  int[] morph_getimage = new int[1]; //clear getimage
  
  //now copy current 3D model
    for (int i=0;i<64*64;i++)
    {
      morph_spx1[i] = spx[i];
      morph_spy1[i] = spy[i];
      morph_spz1[i] = spz[i];
    }
 
}
void morph_copyto_b()
{
  
  //screen snapshot and update icon
  morph_getimage=g.get(0,0,386,486);
  morph_image2.loadPixels();
  morph_image2.copy(morph_getimage, 11, 14, 386, 386, 0, 0, 64, 64);
  morph_image2.updatePixels();
  int[] morph_getimage = new int[1]; //clear getimage
 
  //now copy current 3D model
    for (int i=0;i<64*64;i++)
    {
      morph_spx2[i] = spx[i];
      morph_spy2[i] = spy[i];
      morph_spz2[i] = spz[i];
    }
  
}

void morph_get_a()
{
  //now copy current 3D model
    for (int i=0;i<64*64;i++)
    {
       spx[i]=morph_spx1[i];
       spy[i]=morph_spy1[i];
       spz[i]=morph_spz1[i];
    }
    generate_scuptxyz();
}
void morph_get_b()
{
  //now copy current 3D model
    for (int i=0;i<64*64;i++)
    {
       spx[i]=morph_spx2[i];
       spy[i]=morph_spy2[i];
       spz[i]=morph_spz2[i];
    }
    generate_scuptxyz();
}

void morph_mix_ab(int mixvalue) // mix between 0 and 160
{
  float mixfloat=(float)mixvalue;

  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {  
      int ti=(j*64)+i;
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      {
        spx[ti]=(((morph_spx2[ti]-morph_spx1[ti])/160.0f)*mixfloat) + morph_spx1[ti];
        spy[ti]=(((morph_spy2[ti]-morph_spy1[ti])/160.0f)*mixfloat) + morph_spy1[ti];
        spz[ti]=(((morph_spz2[ti]-morph_spz1[ti])/160.0f)*mixfloat) + morph_spz1[ti];
      }
    }
  }
  generate_scuptxyz();

}

void morph_smooth() 
{
   
   //copy to buffer
   for(int i=0;i<64*64;i++)
   {
     spxbuf[i]=spx[i];
     spybuf[i]=spy[i];
     spzbuf[i]=spz[i];
   }
      
   //smooth around -- main grid
   for(int j=1;j<64-1;j++)
   {
      for(int i=1;i<64-1;i++)
      {
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        {        
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        float x2=spxbuf[(j*64)+i-1];
        float y2=spybuf[(j*64)+i-1];
        float z2=spzbuf[(j*64)+i-1];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
        }
      }
    }
    
   //left line
   for(int j=1;j<64-1;j++)
   {
      for(int i=0;i<1;i++)
      {
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        {        
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        float x2=spxbuf[(j*64)+63];
        float y2=spybuf[(j*64)+63];
        float z2=spzbuf[(j*64)+63];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
        }
      }
    }

   //right line
   for(int j=1;j<64-1;j++)
   {
      for(int i=63;i<64;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        {
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i-1];
        float y1=spybuf[(j*64)+i-1];
        float z1=spzbuf[(j*64)+i-1];
        
        float x2=spxbuf[(j*64)+0];
        float y2=spybuf[(j*64)+0];
        float z2=spzbuf[(j*64)+0];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
        }
      }
    }

    
   //smooth around -- top line
   for(int j=0;j<1;j++)
   {
      for(int i=1;i<64-1;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        {        
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        float x2=spxbuf[(j*64)+i-1];
        float y2=spybuf[(j*64)+i-1];
        float z2=spzbuf[(j*64)+i-1];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        spx[(j*64)+i]=(x0+x1+x2+x3)/4.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3)/4.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3)/4.0f;     
        }
      }
    }

    //top leftpoint
    if(morph_mul[((0/2)*32)+(0/2)]==0)//check for pointlock selector
    {            
    float nx0=spxbuf[(0*64)+0];
    float ny0=spybuf[(0*64)+0];
    float nz0=spzbuf[(0*64)+0];
        
    float nx1=spxbuf[(0*64)+0+1];
    float ny1=spybuf[(0*64)+0+1];
    float nz1=spzbuf[(0*64)+0+1];
        
    float nx2=spxbuf[(0*64)+63];
    float ny2=spybuf[(0*64)+63];
    float nz2=spzbuf[(0*64)+63];
        
    float nx3=spxbuf[((1)*64)+0];
    float ny3=spybuf[((1)*64)+0];
    float nz3=spzbuf[((1)*64)+0];
        
    spx[(0*64)+0]=(nx0+nx1+nx2+nx3)/4.0f;
    spy[(0*64)+0]=(ny0+ny1+ny2+ny3)/4.0f;
    spz[(0*64)+0]=(nz0+nz1+nz2+nz3)/4.0f;     
    }
    //top rightpoint
    if(morph_mul[((0/2)*32)+(63/2)]==0)//check for pointlock selector
    {    
    float nx0=spxbuf[(0*64)+63];
    float ny0=spybuf[(0*64)+63];
    float nz0=spzbuf[(0*64)+63];
        
    float nx1=spxbuf[(0*64)+0];
    float ny1=spybuf[(0*64)+0];
    float nz1=spzbuf[(0*64)+0];
        
    float nx2=spxbuf[(0*64)+62];
    float ny2=spybuf[(0*64)+62];
    float nz2=spzbuf[(0*64)+62];
        
    float nx3=spxbuf[((0+1)*64)+63];
    float ny3=spybuf[((0+1)*64)+63];
    float nz3=spzbuf[((0+1)*64)+63];
        
    spx[(0*64)+63]=(nx0+nx1+nx2+nx3)/4.0f;
    spy[(0*64)+63]=(ny0+ny1+ny2+ny3)/4.0f;
    spz[(0*64)+63]=(nz0+nz1+nz2+nz3)/4.0f;     
    }
    
   //smooth around -- bottom line
   for(int j=63;j<64;j++)
   {
      for(int i=1;i<64-1;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        {        
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        float x2=spxbuf[(j*64)+i-1];
        float y2=spybuf[(j*64)+i-1];
        float z2=spzbuf[(j*64)+i-1];
        
        float x3=spxbuf[((j-1)*64)+i];
        float y3=spybuf[((j-1)*64)+i];
        float z3=spzbuf[((j-1)*64)+i];

        spx[(j*64)+i]=(x0+x1+x2+x3)/4.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3)/4.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3)/4.0f;     
        }
      }
    }
    
    //bottom leftpoint
    if(morph_mul[((63/2)*32)+(0/2)]==0)//check for pointlock selector
    {     
    float nx0=spxbuf[(63*64)+0];
    float ny0=spybuf[(63*64)+0];
    float nz0=spzbuf[(63*64)+0];
        
    float nx1=spxbuf[(63*64)+0+1];
    float ny1=spybuf[(63*64)+0+1];
    float nz1=spzbuf[(63*64)+0+1];
        
    float nx2=spxbuf[(63*64)+63];
    float ny2=spybuf[(63*64)+63];
    float nz2=spzbuf[(63*64)+63];
        
    float nx3=spxbuf[((62)*64)+0];
    float ny3=spybuf[((62)*64)+0];
    float nz3=spzbuf[((62)*64)+0];
        
    spx[(63*64)+0]=(nx0+nx1+nx2+nx3)/4.0f;
    spy[(63*64)+0]=(ny0+ny1+ny2+ny3)/4.0f;
    spz[(63*64)+0]=(nz0+nz1+nz2+nz3)/4.0f;     
    }
    //bottom rightpoint
    if(morph_mul[((63/2)*32)+(63/2)]==0)//check for pointlock selector
    {        
    float nx0=spxbuf[(63*64)+63];
    float ny0=spybuf[(63*64)+63];
    float nz0=spzbuf[(63*64)+63];
        
    float nx1=spxbuf[(63*64)+0];
    float ny1=spybuf[(63*64)+0];
    float nz1=spzbuf[(63*64)+0];
        
    float nx2=spxbuf[(63*64)+62];
    float ny2=spybuf[(63*64)+62];
    float nz2=spzbuf[(63*64)+62];
        
    float nx3=spxbuf[((62)*64)+63];
    float ny3=spybuf[((62)*64)+63];
    float nz3=spzbuf[((62)*64)+63];
        
    spx[(63*64)+63]=(nx0+nx1+nx2+nx3)/4.0f;
    spy[(63*64)+63]=(ny0+ny1+ny2+ny3)/4.0f;
    spz[(63*64)+63]=(nz0+nz1+nz2+nz3)/4.0f;     
    }


   int smoothtop=1;
   for(int j=0;j<1;j++)
   {
      for(int i=0;i<64;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==1)//check for pointlock selector
        {
          smoothtop=0;
        }
      }
   }
   int smoothbottom=1;
   for(int j=63;j<64;j++)
   {
      for(int i=0;i<64;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==1)//check for pointlock selector
        {
          smoothbottom=0;
        }
      }
   }   
   
   
   if(smoothtop==1)
   {
    // scale top and bottom rings small
    int temp1=arch_rotscalearound;
    arch_rotscalearound=1; //scale around ring  
    scale_ring2xz(0, 0.000009f,0);
    scale_ring2y(0, 0.000009f,0);
//    scale_ring2xz(62, 0.000009f,0);
//    scale_ring2y(62, 0.000009f,0);  
    arch_rotscalearound=temp1;
  
    //int temp1=arch_rotscalearound;
    //arch_rotscalearound=1;
    //scale_ring2xz(0, 0.0000009f,0);
    //scale_ring2y(0, 0.0000009f,0);
    //arch_rotscalearound=temp1;   
   }
   if(smoothbottom==1)
   {
    int temp1=arch_rotscalearound;
    arch_rotscalearound=1; //scale around ring  
//    scale_ring2xz(0, 0.000009f,0);
//    scale_ring2y(0, 0.000009f,0);
    scale_ring2xz(62, 0.000009f,0);
    scale_ring2y(62, 0.000009f,0);  
    arch_rotscalearound=temp1;
     
   // int temp1=arch_rotscalearound;
   // arch_rotscalearound=1;
   // scale_ring2xz(62, 0.000009f,0);
   // scale_ring2y(62, 0.000009f,0);
   // arch_rotscalearound=temp1;   
   }
   
   
    
    //generate sculpt image
    generate_scuptxyz();
   // getimagedata();
}
void morph_smooth_plane() 
{
   
   //copy to buffer
   for(int j=0;j<64;j++)
   {
     for(int i=0;i<64;i++)
     {
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      {   
       spxbuf[(j*64)+i]=spx[(j*64)+i];
       spybuf[(j*64)+i]=spy[(j*64)+i];
       spzbuf[(j*64)+i]=spz[(j*64)+i];
      }
     }
   }
   //smooth around -- main grid
   for(int j=1;j<64-1;j++)
   {
      for(int i=1;i<64-1;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        {         
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        float x2=spxbuf[(j*64)+i-1];
        float y2=spybuf[(j*64)+i-1];
        float z2=spzbuf[(j*64)+i-1];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
        }
      }
    }
    
   //left line
   for(int j=1;j<64-1;j++)
   {
      for(int i=0;i<1;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        { 
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        //float x2=spxbuf[(j*64)+63];
        //float y2=spybuf[(j*64)+63];
        //float z2=spzbuf[(j*64)+63];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x3+x4)/4.0f;
        spy[(j*64)+i]=(y0+y1+y3+y4)/4.0f;
        spz[(j*64)+i]=(z0+z1+z3+z4)/4.0f;     
        }
      }
    }

   //right line
   for(int j=1;j<64-1;j++)
   {
      for(int i=63;i<64;i++)
      {        
        if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
        { 
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i-1];
        float y1=spybuf[(j*64)+i-1];
        float z1=spzbuf[(j*64)+i-1];
        
       // float x2=spxbuf[(j*64)+0];
       // float y2=spybuf[(j*64)+0];
       // float z2=spzbuf[(j*64)+0];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x3+x4)/4.0f;
        spy[(j*64)+i]=(y0+y1+y3+y4)/4.0f;
        spz[(j*64)+i]=(z0+z1+z3+z4)/4.0f;    
        } 
      }
    }
    
    
    //generate sculpt image
    generate_scuptxyz();
   // getimagedata();
}

void morph_smooth_torus() 
{
   //println("torus smooth");
   //copy to buffer
   for(int j=0;j<64;j++)
   {
     for(int i=0;i<64;i++)
     {
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      { 
        spxbuf[(j*64)+i]=spx[(j*64)+i];
        spybuf[(j*64)+i]=spy[(j*64)+i];
        spzbuf[(j*64)+i]=spz[(j*64)+i];
      }
     }
   }
      
   //smooth around -- main grid
   for(int j=1;j<64-1;j++)
   {
      for(int i=1;i<64-1;i++)
      {        
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      { 
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        float x2=spxbuf[(j*64)+i-1];
        float y2=spybuf[(j*64)+i-1];
        float z2=spzbuf[(j*64)+i-1];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
        }
      }
    }
    
   //left line
   for(int j=1;j<64-1;j++)
   {
      for(int i=0;i<1;i++)
      {        
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      { 
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i+1];
        float y1=spybuf[(j*64)+i+1];
        float z1=spzbuf[(j*64)+i+1];
        
        float x2=spxbuf[(j*64)+63];
        float y2=spybuf[(j*64)+63];
        float z2=spzbuf[(j*64)+63];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
      }
      }
    }

   //right line
   for(int j=1;j<64-1;j++)
   {
      for(int i=63;i<64;i++)
      {        
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      { 
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i-1];
        float y1=spybuf[(j*64)+i-1];
        float z1=spzbuf[(j*64)+i-1];
        
        float x2=spxbuf[(j*64)+0];
        float y2=spybuf[(j*64)+0];
        float z2=spzbuf[(j*64)+0];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((j-1)*64)+i];
        float y4=spybuf[((j-1)*64)+i];
        float z4=spzbuf[((j-1)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
      }
      }
    }
  
   //top line
   for(int j=0;j<1;j++)
   {
      for(int i=1;i<64-1;i++)
      {        
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      { 
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i-1];
        float y1=spybuf[(j*64)+i-1];
        float z1=spzbuf[(j*64)+i-1];
        
        float x2=spxbuf[(j*64)+i+1];
        float y2=spybuf[(j*64)+i+1];
        float z2=spzbuf[(j*64)+i+1];
        
        float x3=spxbuf[((j+1)*64)+i];
        float y3=spybuf[((j+1)*64)+i];
        float z3=spzbuf[((j+1)*64)+i];

        float x4=spxbuf[((63)*64)+i];
        float y4=spybuf[((63)*64)+i];
        float z4=spzbuf[((63)*64)+i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
      }
      }
    }
   //bottom line
   for(int j=63;j<64;j++)
   {
      for(int i=1;i<64-1;i++)
      {        
      if(morph_mul[((j/2)*32)+(i/2)]==0)//check for pointlock selector
      { 
        float x0=spxbuf[(j*64)+i];
        float y0=spybuf[(j*64)+i];
        float z0=spzbuf[(j*64)+i];
        
        float x1=spxbuf[(j*64)+i-1];
        float y1=spybuf[(j*64)+i-1];
        float z1=spzbuf[(j*64)+i-1];
        
        float x2=spxbuf[(j*64)+i+1];
        float y2=spybuf[(j*64)+i+1];
        float z2=spzbuf[(j*64)+i+1];
        
        float x3=spxbuf[((j-1)*64)+i];
        float y3=spybuf[((j-1)*64)+i];
        float z3=spzbuf[((j-1)*64)+i];

        float x4=spxbuf[i];
        float y4=spybuf[i];
        float z4=spzbuf[i];
        
        spx[(j*64)+i]=(x0+x1+x2+x3+x4)/5.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3+y4)/5.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3+z4)/5.0f;     
      }
      }
    }
   
    //get the points of the 4 corners
    float x0=spxbuf[0];
    float y0=spybuf[0];
    float z0=spzbuf[0];
        
    float x1=spxbuf[63];
    float y1=spybuf[63];
    float z1=spzbuf[63];
        
    float x2=spxbuf[(63*64)];
    float y2=spybuf[(63*64)];
    float z2=spzbuf[(63*64)];
        
    float x3=spxbuf[(63*64)+63];
    float y3=spybuf[(63*64)+63];
    float z3=spzbuf[(63*64)+63];

    float x4=spxbuf[1];
    float y4=spybuf[1];
    float z4=spzbuf[1];    
    float x5=spxbuf[64];
    float y5=spybuf[64];
    float z5=spzbuf[64];

    float x6=spxbuf[62];
    float y6=spybuf[62];
    float z6=spzbuf[62];
    float x7=spxbuf[127];
    float y7=spybuf[127];
    float z7=spzbuf[127];

    float x8=spxbuf[(62*64)];
    float y8=spybuf[(62*64)];
    float z8=spzbuf[(62*64)];
    float x9=spxbuf[(63*64)+1];
    float y9=spybuf[(63*64)+1];
    float z9=spzbuf[(63*64)+1];

    float x10=spxbuf[(62*64)+63];
    float y10=spybuf[(62*64)+63];
    float z10=spzbuf[(62*64)+63];
    float x11=spxbuf[(63*64)+62];
    float y11=spybuf[(63*64)+62];
    float z11=spzbuf[(63*64)+62];

    
      if(morph_mul[0]==0)//check for pointlock selector
      { 
        spx[0]=(x0+x1+x2+x4+x5)/5.0f; //top left
        spy[0]=(y0+y1+y2+y4+y5)/5.0f;
        spz[0]=(z0+z1+z2+z4+z5)/5.0f; 
      }
      if(morph_mul[31]==0)//check for pointlock selector
      { 
        spx[63]=(x0+x1+x3+x6+x7)/5.0f; //top right
        spy[63]=(y0+y1+y3+y6+y7)/5.0f;
        spz[63]=(z0+z1+z3+z6+z7)/5.0f; 
      }
    
      if(morph_mul[((63/2)*32)+(0)]==0)//check for pointlock selector
      { 
        spx[(63*64)]=(x0+x2+x3+x8+x9)/5.0f; //bottom left
        spy[(63*64)]=(y0+y2+y3+y8+y9)/5.0f;
        spz[(63*64)]=(z0+z2+z3+z8+z9)/5.0f;
      }
    
      if(morph_mul[((63/2)*32)+(63/2)]==0)//check for pointlock selector
      { 
        spx[(63*64)+63]=(x1+x2+x3+x10+x11)/5.0f; //bottom left
        spy[(63*64)+63]=(y1+y2+y3+y10+y11)/5.0f;
        spz[(63*64)+63]=(z1+z2+z3+z10+z11)/5.0f;
      }
  
    
    
    //generate sculpt image
    generate_scuptxyz();
   // getimagedata();
}    
 


