// tool_arch
//----------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------Arch tool----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
void selectarchtool()
{

}


void rotate_ring2x(int ring, float inc, int mirror)
{
  //float rotatorz=256.0f*inc;  
  for (int j=ring; j<ring+2; j++)
  {
    float tx0=0.0f;
    float ty0=0.0f;
    float tz0=0.0f;
    
    if(arch_rotscalearound==1)
    {
      //find middle / origin of the ring
      for (int i=0; i<64; i++)
      {
        tx0+=spx[(j*64)+i];
        ty0+=spy[(j*64)+i];
        tz0+=spz[(j*64)+i];
      }
      tx0=tx0/64.0f;
      ty0=ty0/64.0f;
      tz0=tz0/64.0f;
    }
    if(arch_rotscalearound==2 && mirror==0)
    {
      tx0=arch_rsx;
      ty0=arch_rsy;
      tz0=arch_rsz;
    }
    if(arch_rotscalearound==2 && mirror==1)
    {
      tx0=arch_mirrsx;
      ty0=arch_mirrsy;
      tz0=arch_mirrsz;
    }
    
    //translate ring around 0,0,0 if possible origin..    
    //rotate the ring
    matbasic(mat1);
    matrotx(mat1, arch_steprotate*inc);//8.0/rotatorz);
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i]-tx0;
      ringy1[i]=spy[(j*64)+i]-ty0;
      ringz1[i]=spz[(j*64)+i]-tz0;
    }
    finmatring(mat1, 0, 64, j);
    //translate back
    if(arch_rotscalearound==1 || arch_rotscalearound==2)
    {
      for (int i=0; i<64; i++)
      {
        spx[(j*64)+i]+=tx0;
        spy[(j*64)+i]+=ty0;
        spz[(j*64)+i]+=tz0;
      }
    }
    
  }
  //generate_scuptxyz();
}
void rotate_ring2y(int ring, float inc, int mirror)
{
  //float rotatorz=256.0f*inc;  
  for (int j=ring; j<ring+2; j++)
  {
    float tx0=0.0f;
    float ty0=0.0f;
    float tz0=0.0f;
    if(arch_rotscalearound==1)
    {
      //find middle / origin of the ring
      for (int i=0; i<64; i++)
      {
        tx0+=spx[(j*64)+i];
        ty0+=spy[(j*64)+i];
        tz0+=spz[(j*64)+i];
      }
      tx0=tx0/64.0f;
      ty0=ty0/64.0f;
      tz0=tz0/64.0f;
    }
    if(arch_rotscalearound==2 && mirror==0)
    {
      tx0=arch_rsx;
      ty0=arch_rsy;
      tz0=arch_rsz;
    }
    if(arch_rotscalearound==2 && mirror==1)
    {
      tx0=arch_mirrsx;
      ty0=arch_mirrsy;
      tz0=arch_mirrsz;
    }    
    //translate ring around 0,0,0 if possible origin..    
    //rotate the ring
    matbasic(mat1);
    matroty(mat1,arch_steprotate*inc);
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i]-tx0;
      ringy1[i]=spy[(j*64)+i]-ty0;
      ringz1[i]=spz[(j*64)+i]-tz0;
    }
    finmatring(mat1, 0, 64, j);
    //translate back
    if(arch_rotscalearound==1 || arch_rotscalearound==2)
    {
      for (int i=0; i<64; i++)
      {
        spx[(j*64)+i]+=tx0;
        spy[(j*64)+i]+=ty0;
        spz[(j*64)+i]+=tz0;
      }
    }
    
  }
  //generate_scuptxyz();
}
void rotate_ring2z(int ring, float inc, int mirror)
{
  //float rotatorz=256.0f*inc;  
  for (int j=ring; j<ring+2; j++)
  {
    float tx0=0.0f;
    float ty0=0.0f;
    float tz0=0.0f;
    if(arch_rotscalearound==1)
    {
      //find middle / origin of the ring
      for (int i=0; i<64; i++)
      {
        tx0+=spx[(j*64)+i];
        ty0+=spy[(j*64)+i];
        tz0+=spz[(j*64)+i];
      }
      tx0=tx0/64.0f;
      ty0=ty0/64.0f;
      tz0=tz0/64.0f;
    }
    if(arch_rotscalearound==2 && mirror==0)
    {
      tx0=arch_rsx;
      ty0=arch_rsy;
      tz0=arch_rsz;
    }
    if(arch_rotscalearound==2 && mirror==1)
    {
      tx0=arch_mirrsx;
      ty0=arch_mirrsy;
      tz0=arch_mirrsz;
    }    //translate ring around 0,0,0 if possible origin..    
    //rotate the ring
    matbasic(mat1);
    matrotz(mat1,arch_steprotate*inc);
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i]-tx0;
      ringy1[i]=spy[(j*64)+i]-ty0;
      ringz1[i]=spz[(j*64)+i]-tz0;
    }
    finmatring(mat1, 0, 64, j);
    if(arch_rotscalearound==1 || arch_rotscalearound==2)
    {
      //translate back
      for (int i=0; i<64; i++)
      {
        spx[(j*64)+i]+=tx0;
        spy[(j*64)+i]+=ty0;
        spz[(j*64)+i]+=tz0;
      }
    }
    
  }
  //generate_scuptxyz();
}

void finmatring(float matrix[], int start, int number, int ring)
{
  float xo,yo,zo;
  for (int i=start; i<number; i++)
  {
     xo=ringx1[i];
     yo=ringy1[i];
     zo=ringz1[i];     
     spx[(ring*64)+i]=(xo*matrix[0]+yo*matrix[1]+zo*matrix[2]+matrix[3]);
     spy[(ring*64)+i]=xo*matrix[4]+yo*matrix[5]+zo*matrix[6]+matrix[7];
     spz[(ring*64)+i]=xo*matrix[8]+yo*matrix[9]+zo*matrix[10]+matrix[11];
  }
}



void translate_ring2x(int ring, float inc)
{
  for(int j=ring;j<ring+1;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spx[(j*64)+i]=spx[(j*64)+i]+inc;
        spx[((j+1)*64)+i]=spx[((j+1)*64)+i]+inc;
    } 
  }
  //generate_scuptxyz(); 
}
void translate_ring2z(int ring, float inc)
{
  for(int j=ring;j<ring+1;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spz[(j*64)+i]=spz[(j*64)+i]+inc;
        spz[((j+1)*64)+i]=spz[((j+1)*64)+i]+inc;
    } 
  }
  //generate_scuptxyz(); 
}
void translate_ring2y(int ring, float inc)
{
  for(int j=ring;j<ring+1;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spy[(j*64)+i]=spy[(j*64)+i]+inc;       
        spy[((j+1)*64)+i]=spy[((j+1)*64)+i]+inc;       
    } 
  }
  //generate_scuptxyz(); 
}



void scale_ring2xz(int ring, float inc, int mirror)
{
  for(int j=ring;j<ring+1;j++)
  {
    float tx0=0.0f;
   // float ty0=0.0f;
    float tz0=0.0f;
    if(arch_rotscalearound==1)
    {    
      //find middle / origin of the ring
      for (int i=0; i<64; i++)
      {
        tx0+=spx[(j*64)+i];
       // ty0+=spy[(j*64)+i];
        tz0+=spz[(j*64)+i];
      }
      tx0=tx0/64.0f;
      //ty0=ty0/64.0f;
      tz0=tz0/64.0f;
    }

    if(arch_rotscalearound==2 && mirror==0)
    {
      tx0=arch_rsx;
      //ty0=arch_rsy;
      tz0=arch_rsz;
    }
    if(arch_rotscalearound==2 && mirror==1)
    {
      tx0=arch_mirrsx;
      //ty0=arch_mirrsy;
      tz0=arch_mirrsz;
    }    
    //translate to origin
    for(int i=0;i<64;i++)
    {    
        spx[(j*64)+i]=(spx[(j*64)+i]-tx0)*inc;
        spz[(j*64)+i]=(spz[(j*64)+i]-tz0)*inc;
        spx[((j+1)*64)+i]=(spx[((j+1)*64)+i]-tx0)*inc;
        spz[((j+1)*64)+i]=(spz[((j+1)*64)+i]-tz0)*inc;
    }
    if(arch_rotscalearound==1 || arch_rotscalearound==2)
    {    
      //translate it back
      for(int i=0;i<64;i++)
      {    
          spx[(j*64)+i]+=tx0;
          spz[(j*64)+i]+=tz0;
          spx[((j+1)*64)+i]+=tx0;
          spz[((j+1)*64)+i]+=tz0;
      }
    }    
  }
  //generate_scuptxyz(); 
}



void scale_ring2x(int ring, float inc, int mirror)
{
  for(int j=ring;j<ring+1;j++)
  {
    float tx0=0.0f;
    if(arch_rotscalearound==1)
    {
      //find middle / origin of the ring
      for (int i=0; i<64; i++)
      {
        tx0+=spx[(j*64)+i];
      }
      tx0=tx0/64.0f;
    }
         
    if(arch_rotscalearound==2 && mirror==0)
    {
      tx0=arch_rsx;
      //ty0=arch_rsy;
      //tz0=arch_rsz;
    }
    if(arch_rotscalearound==2 && mirror==1)
    {
      tx0=arch_mirrsx;
      //ty0=arch_mirrsy;
      //tz0=arch_mirrsz;
    }      
    for(int i=0;i<64;i++)
    {    
        spx[(j*64)+i]=(spx[(j*64)+i]-tx0)*inc;
        spx[((j+1)*64)+i]=(spx[((j+1)*64)+i]-tx0)*inc;
    } 
    if(arch_rotscalearound==1 || arch_rotscalearound==2)
    {
      //translate it back
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]+=tx0;
        spx[((j+1)*64)+i]+=tx0;
      }
    }
    
  }
  //generate_scuptxyz(); 
}

void scale_ring2z(int ring, float inc, int mirror)
{
  for(int j=ring;j<ring+1;j++)
  {
    float tz0=0.0f;
    if(arch_rotscalearound==1)
    {
      //find middle / origin of the ring
      for (int i=0; i<64; i++)
      {
        tz0+=spz[(j*64)+i];
      }
      tz0=tz0/64.0f;
    }
    
    if(arch_rotscalearound==2 && mirror==0)
    {
     // tx0=arch_rsx;
     // ty0=arch_rsy;
      tz0=arch_rsz;
    }
    if(arch_rotscalearound==2 && mirror==1)
    {
     // tx0=arch_mirrsx;
     // ty0=arch_mirrsy;
      tz0=arch_mirrsz;
    }
    //translate to origin        
    for(int i=0;i<64;i++)
    {    
        spz[(j*64)+i]=(spz[(j*64)+i]-tz0)*inc;
        spz[((j+1)*64)+i]=(spz[((j+1)*64)+i]-tz0)*inc;
    }
    if(arch_rotscalearound==1 || arch_rotscalearound==2)
    {
      //translate it back
      for(int i=0;i<64;i++)
      {    
        spz[(j*64)+i]+=tz0;
        spz[((j+1)*64)+i]+=tz0;
      }
    }    
  }
  //generate_scuptxyz(); 
}

void scale_ring2y(int ring, float inc, int mirror)
{
  float ty0=0.0f;
  double tyyy=0.0;
  int county=0;
  if(arch_rotscalearound==1)
  {
    for(int j=ring;j<ring+2;j++)      //find middle / origin of the ring
    {
      for (int i=0; i<64; i++)
      {
        tyyy+=(double)spy[(j*64)+i];
        county++;
      }
    }
    tyyy=tyyy/128.0;
    ty0=(float)tyyy;
   // println("county: "+county+ " ring: "+ring);
  }
  
  for(int j=ring;j<ring+1;j++)
  {

    if(arch_rotscalearound==1)
    {
      //find middle / origin of the ring
      //for (int i=0; i<64; i++)
      //{
      //  ty0+=spy[(j*64)+i];
     // }
      //ty0=ty0/64.0f;
    }
    if(arch_rotscalearound==2 && mirror==0)
    {
    //  tx0=arch_rsx;
      ty0=arch_rsy;
  //    tz0=arch_rsz;
    }
    if(arch_rotscalearound==2 && mirror==1)
    {
//      tx0=arch_mirrsx;
      ty0=arch_mirrsy;
//      tz0=arch_mirrsz;
    }
    //translate to origin        
    for(int i=0;i<64;i++)
    {    
        spy[(j*64)+i]=(spy[(j*64)+i]-ty0)*inc;        
        spy[((j+1)*64)+i]=(spy[((j+1)*64)+i]-ty0)*inc;         
    }
    if(arch_rotscalearound==1 || arch_rotscalearound==2)
    {
      //translate it back
      for(int i=0;i<64;i++)
      {    
        spy[(j*64)+i]+=ty0;
        spy[((j+1)*64)+i]+=ty0;
      }
    } 
    
  }
  
  //generate_scuptxyz();
}

//---------------------------------------------------
void arch_rotatex(int direction)
{
  float rotatorz=256.0f*direction;
  //rotate
  for (int j=8; j<56; j++)
//  for (int j=0; j<64; j++)
  {
    matbasic(mat1);
    matrotx(mat1,(float)j/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];      
    }
    //find height put it to 0    
    finmat(mat1, 0, 64, j);
  }
  
  for (int j=0; j<8; j++)
  {
    matbasic(mat1);
    matrotx(mat1,(float)8.0/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
  for (int j=56; j<64; j++)
  {
    matbasic(mat1);
    matrotx(mat1,(float)56.0/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
    
  //generate_scuptxyz();
}

void arch_rotatey(int direction)
{
  float rotatorz=256.0f*direction;//
  for (int j=8; j<56; j++)
  {
    matbasic(mat1);
    matroty(mat1,(float)j/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
  for (int j=0; j<8; j++)
  {
    matbasic(mat1);
    matroty(mat1,(float)8.0/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
  for (int j=56; j<64; j++)
  {
    matbasic(mat1);
    matroty(mat1,(float)56.0/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
  
 // generate_scuptxyz();
}

void arch_rotatez(int direction)
{
  float rotatorz=256.0f*direction;
//  for (int j=0; j<64; j++)
  for (int j=8; j<56; j++)
  {
    matbasic(mat1);
    matrotz(mat1,(float)j/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
  
  for (int j=0; j<8; j++)
  {
    matbasic(mat1);
    matrotz(mat1,(float)8.0/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
  for (int j=56; j<64; j++)
  {
    matbasic(mat1);
    matrotz(mat1,(float)56.0/rotatorz);  
    for (int i=0; i<64; i++)
    {
      ringx1[i]=spx[(j*64)+i];
      ringy1[i]=spy[(j*64)+i];
      ringz1[i]=spz[(j*64)+i];
    }
    finmat(mat1, 0, 64, j);
  }
  //generate_scuptxyz();
}

void finmat(float matrix[], int start, int number, int ring)
{
  float xo,yo,zo;
  for (int i=start; i<number; i++)
  {
     xo=ringx1[i];
     yo=ringy1[i];
     zo=ringz1[i];
     
     spx[(ring*64)+i]=(xo*matrix[0]+yo*matrix[1]+zo*matrix[2]+matrix[3]);
     spy[(ring*64)+i]=xo*matrix[4]+yo*matrix[5]+zo*matrix[6]+matrix[7];
     spz[(ring*64)+i]=xo*matrix[8]+yo*matrix[9]+zo*matrix[10]+matrix[11];
  }
}

void reset_archcube()
{
    rendertype=1;
   //draw sides of the cube
    arch_drawsides(0,64);
    
    for(int j=0;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {
        spx[(j*64)+i]=spx[(j*64)+i]*0.2;
        spz[(j*64)+i]=spz[(j*64)+i]*0.2;        
      }
    }
        
    for(int j=0;j<8;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=((spx[(j*64)+i]*(((float)j+0.1f)/8.0f)));
        spy[(j*64)+i]=-48;
        spz[(j*64)+i]=(spz[(j*64)+i]*(((float)j+0.1f)/8.0f));
      }
    }

    for(int j=56;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=spx[(j*64)+i]*((63.1f-(float)j)/8.0f); //0 
        spy[(j*64)+i]=46;
        spz[(j*64)+i]=spz[(j*64)+i]*((63.1f-(float)j)/8.0f);
      } 
    } 
    
          
  //generate sculpt image
    generate_scuptxyz(); 
}

///archpipe'r
void reset_to_archpipe()
{
  
    reset_to_sphere();
   
    //middle 
    for(int j=6;j<32;j++)
    {
      for(int i=0;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[((2)*64)+i];
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[((2)*64)+i];
      } 
    }
    for(int j=32,jjj=31;j<58;j++)
    {
      for(int i=0;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[((2)*64)+i];
        spy[(j*64)+i]=-spy[(jjj*64)+i];
        spz[(j*64)+i]=spz[((2)*64)+i];
      }
      jjj--;
    }
   
    //top
    for(int j=0;j<6;j++)
    {
      for(int i=0;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]/4.0f;
        spy[(j*64)+i]=spy[(6*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]/4.0f;
      } 
    }    
    //bottom --- -42
    for(int j=58;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]/4.0f;
        spy[(j*64)+i]=spy[(57*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]/4.0f;
      } 
    }    
    //println ("t: "+spy[0]+" b: "+spy[(63*64)+1]);
   
   generate_scuptxyz(); 
   flat_top=1;
   flat_bottom=63;
}


void arch_drawsides(int starty, int endy)
{
  int ax1=32;
  int ay1=32;
  int az1=32;
  
    //side left
    for(int j=starty;j<endy;j++)
    {
      for(int i=0;i<16;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=ax1;
        spy[(j*64)+i]=(j-ay1)*2;
        spz[(j*64)+i]=((i-(az1/2))*4)+az1;
      } 
    }
    
    //front 
    for(int j=starty;j<endy;j++)
    {
      for(int i=16;i<32;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=((ax1-i)*4)-ax1;
        spy[(j*64)+i]=(j-ay1)*2;
        spz[(j*64)+i]=az1;
      } 
    }
    
    //side right
    for(int j=starty;j<endy;j++)
    {
      for(int i=32;i<48;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=-ax1;
        spy[(j*64)+i]=(j-ay1)*2;
        spz[(j*64)+i]=((((az1/2)*3)-i)*4)-az1;
      } 
    }
    
    //back 
    for(int j=starty;j<endy;j++)
    {
      for(int i=48;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=((i-(ax1*2))*4)+ax1;
        spy[(j*64)+i]=(j-ay1)*2;
        spz[(j*64)+i]=-az1;
      } 
    }
}

/*
void arch_smooth() 
{
   //smooth a bit
   
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
    
   //left line
   for(int j=1;j<64-1;j++)
   {
      for(int i=0;i<1;i++)
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

   //right line
   for(int j=1;j<64-1;j++)
   {
      for(int i=63;i<64;i++)
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
    //stone_fixtopbottom();  
    
    //generate sculpt image
    generate_scuptxyz();
   // getimagedata();
}      
*/


void arch_showmirrorbox(int whatbox)
{
  pushMatrix();
  noFill();
  
  if (whatbox==1)//top to bottom
  {    
      stroke(0,155,155 ,80);
      translate(0,31,0);
      box(120,60,120);
      stroke(255,255,255 ,255);
      translate(0,-62,0);
      box(120,60,120);      
  }
  if (whatbox==2)// bottom to top
  {    
      stroke(255,255,255 ,255);
      translate(0,31,0);
      box(120,60,120);      
      stroke(0,155,155 ,80);
      translate(0,-62,0);
      box(120,60,120);      
  }
  if (whatbox==3)// left to right
  {  
      stroke(255,255,255 ,255);
      translate(0,0,31);
      box(120,120,60);      
      stroke(0,155,155 ,80);
      translate(0,0,-62);
      box(120,120,60);  
  }
  if (whatbox==4)//  right to left
  {  
      stroke(0,155,155 ,80);
      translate(0,0,31);
      box(120,120,60);      
      stroke(255,255,255 ,255);
      translate(0,0,-62);
      box(120,120,60);  
  }
  
  if (whatbox==5)// front to back 
  {  
      stroke(255,255,255 ,255);
      translate(31,0,0);
      box(60,120,120);      
      stroke(0,155,155 ,80);
      translate(-62,0,0);
      box(60,120,120);  
  }    
  if (whatbox==6)// front to back 
  {  
      stroke(0,155,155 ,80);
      translate(31,0,0);
      box(60,120,120);      
      stroke(255,255,255 ,255);
      translate(-62,0,0);
      box(60,120,120);  
  }
  
  popMatrix();
}

void arch_mirror_toptowardsbottom()
{
  //mmin
   for(int j=32,jj=31;j<64;j++)
   {
     for(int i=0;i<64;i++)
     {
       spx[(j*64)+i]=spx[(jj*64)+i];
       spy[(j*64)+i]=-spy[(jj*64)+i];
       spz[(j*64)+i]=spz[(jj*64)+i];
       
     } 
     jj--;  
   }
   generate_scuptxyz();
}
void arch_mirror_bottomtowardstop()
{
  //mmin
   for(int j=0,jj=63;j<32;j++)
   {
     for(int i=0;i<64;i++)
     {
       spx[(j*64)+i]=spx[(jj*64)+i];
       spy[(j*64)+i]=-spy[(jj*64)+i];
       spz[(j*64)+i]=spz[(jj*64)+i];       
     }
     jj--;  
   }
   generate_scuptxyz();
}

void arch_mirror_lefttoright()
{
  //mmin
   for(int j=0;j<64;j++)
   {
     for(int i=32,ii=31;i<64;i++)
     {
       spx[(j*64)+i]=spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=-spz[(j*64)+ii];       
       ii--;  
     }
   }
   generate_scuptxyz();
}
void arch_mirror_righttoleft()
{
  //mmin
   for(int j=0;j<64;j++)
   {
     for(int i=0,ii=63;i<32;i++)
     {
       spx[(j*64)+i]=spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=-spz[(j*64)+ii];       
       ii--;  
     }
   }
   generate_scuptxyz();
}
void arch_mirror_fronttoback()
{
   for(int j=0;j<64;j++)
   {
     for(int i=16,ii=15;i<32;i++)
     {
       spx[(j*64)+i]=-spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=spz[(j*64)+ii];       
       ii--;  
     }
   }
   for(int j=0;j<64;j++)
   {
     for(int i=32,ii=63;i<48;i++)
     {
       spx[(j*64)+i]=-spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=spz[(j*64)+ii];       
       ii--;  
     }
   }  
   generate_scuptxyz();
}

void arch_mirror_backtofront()
{
   for(int j=0;j<64;j++)
   {
     for(int i=0,ii=31;i<16;i++)
     {
       spx[(j*64)+i]=-spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=spz[(j*64)+ii];       
       ii--;  
     }
   }
   for(int j=0;j<64;j++)
   {
     for(int i=48,ii=47;i<64;i++)
     {
       spx[(j*64)+i]=-spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=spz[(j*64)+ii];       
       ii--;  
     }
   }  
   generate_scuptxyz();
}
