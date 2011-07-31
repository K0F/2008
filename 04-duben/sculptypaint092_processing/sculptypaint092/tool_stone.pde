// tool_stone
//----------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------Stone tool----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
void selectstonetool()
{
  
/*
  for(int j=0;j<32;j++)
  {
    for(int i=0;i<64;i++)
    {   
        int tsource=(j*64)+i;
        int tdesty=(((31-j)+32)*64)+i;
        spx[(j*64)+i]=spx[tsource]; //0 - 63  1 - 62 
        spy[tdesty]=-spy[tsource]; //0 - 63  1 - 62 
        spz[(j*64)+i]=spz[tsource];
    } 
  }
  generate_scuptxyz(); 
  */
}
void stone_reset_planecuberounded()
{//wwip
  //get a sphere
  reset_to_sphere();
  for(int j=31;j<33;j++)
  {
    for(int i=0;i<64;i++)
    {
      spxbuf[(j*64)+i]=spx[(j*64)+i];
      spzbuf[(j*64)+i]=spz[(j*64)+i];
    }
  }
  //now reset it to a planecube
//  reset_archplanecube();
//  stone_resetplane_round();
  stone_resetplane_ony();
    
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {
        spx[(j*64)+i]=spxbuf[(j*64)+(i/8)];
        spz[(j*64)+i]=spzbuf[(j*64)+(i/8)];        
    }   
  }
  /*
  for(int j=0;j<64;j++)
  {
    for(int i=32,ii=31;i<64;i++)
    {
        spx[(j*64)+i]=spx[(j*64)+(ii)];
        spz[(j*64)+i]=spz[(j*64)+(ii)]+4;
        ii--;        
    }   
  }
  */
  /*
  for(int j=0;j<64;j++)
  {
    for(int i=32;i<64;i++)
    {
        spx[(j*64)+i]=spx[(j*64)+i]+spxbuf[(31*64)+(i-32)];
        spz[(j*64)+i]=spz[(j*64)+i]+spzbuf[(31*64)+(i-32)];        
    }
  }  
  */
  //generate sculpt image
  generate_scuptxyz(); 
    
}

void stone_reset_archplanecube()
{
    gridflat= loadImage("data/grid.png");
     
  //rendertype=0;
  
//    rendertype=1;
   //draw sides of the cube
    arch_drawplanesides(0,64);
        
    for(int j=0;j<2;j++)//8
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=((spx[(j*64)+i]*(((float)j+0.1f)/2.0f)));//8
        spy[(j*64)+i]=-60;
        spz[(j*64)+i]=(spz[(j*64)+i]*(((float)j+0.1f)/2.0f));
      }
    }

    for(int j=62;j<64;j++)//56
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=spx[(j*64)+i]*((63.1f-(float)j)/2.0f); //0 
        spy[(j*64)+i]=58;
        spz[(j*64)+i]=spz[(j*64)+i]*((63.1f-(float)j)/2.0f);
      } 
    } 
    
    for(int i=0;i<32;i++)//56
    {
          scale_z(0.9);    
    }
    for(int i=0;i<6;i++)//56
    {
          scale_y(0.9);
    }
    
   scale_ring2xz(0, 0.0000009f,0);
   scale_ring2xz(62, 0.000009f,0);
   
  //generate sculpt image
    generate_scuptxyz(); 
}

void arch_drawplanesides(int starty, int endy)
{
  int ax1=32;//32
  int ay1=32;
  int az1=32;
  
    //side left
    for(int j=starty;j<endy;j++)
    {
      for(int i=0;i<2;i++)
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
      for(int i=2;i<32;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=((ax1-i)*2)-ax1+4;
        spy[(j*64)+i]=(j-ay1)*2;
        spz[(j*64)+i]=az1;
      } 
    }
    
    //side right
    for(int j=starty;j<endy;j++)
    {
      for(int i=32;i<34;i++)
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
      for(int i=34;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=((i-(ax1*2))*2)+ax1-4;
        spy[(j*64)+i]=(j-ay1)*2;
        spz[(j*64)+i]=-az1;
      } 
    }
}


void stone_resetplane()
{
  gridflat= loadImage("data/grid.png");
     
  rendertype=3;
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {
      spx[(j*64)+i]=i-32;
      spy[(j*64)+i]=0;
      spz[(j*64)+i]=j-32;
    }
  }
  generate_scuptxyz();
}

void stone_resetplane_ony()
{
//  gridflat= loadImage("data/grid.png");
     
  rendertype=3;
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {
      spx[(j*64)+i]=i-32;
      spy[(j*64)+i]=j-32;
      spz[(j*64)+i]=0;
    }
  }
  generate_scuptxyz();  //update 3D model based on picture
  
}

void stone_resetplane_round()
{
  stone_resetplane();

  float stepperz=0;
  for(int i=0;i<63;i=i+2)
  {
    float scalz=((float)i/64.0f)+stepperz;
    stepperz=stepperz-(((float)i/64.0f)/15.0f);
    scale_ring2x(i,scalz,0);   // 0.9f);
  }
  stone_smooth_plane();
  
  for(int i=0;i<16;i++)
  {
    scale_x(1.1);
  }
  generate_scuptxyz();
}

void stone_resetplane_triangle()
{
  stone_resetplane();

  for(int i=0;i<63;i=i+2)
  {
    float scalz=(float)i/64.0f;
    scale_ring2x(i,scalz,0);   // 0.9f);
  }
  generate_scuptxyz();

}

void stone_transferto4()
{
 
  stone_transferto8();
  for(int j=0;j<64;j++)
  {
    for(int i=8;i<16;i++)
    {
      spx32[(j*64)+i]=spx32[(j*64)+0];
      spy32[(j*64)+i]=spy32[(j*64)+0];
      spz32[(j*64)+i]=spz32[(j*64)+0];      
    }
  }
  for(int j=0;j<64;j++)
  {
    for(int i=24;i<32;i++)
    {
      spx32[(j*64)+i]=spx32[(j*64)+16];
      spy32[(j*64)+i]=spy32[(j*64)+16];
      spz32[(j*64)+i]=spz32[(j*64)+16];      
    }
  }
  for(int j=0;j<64;j++)
  {
    for(int i=40;i<48;i++)
    {
      spx32[(j*64)+i]=spx32[(j*64)+32];
      spy32[(j*64)+i]=spy32[(j*64)+32];
      spz32[(j*64)+i]=spz32[(j*64)+32];      
    }
  }
  for(int j=0;j<64;j++)
  {
    for(int i=56;i<64;i++)
    {
      spx32[(j*64)+i]=spx32[(j*64)+48];
      spy32[(j*64)+i]=spy32[(j*64)+48];
      spz32[(j*64)+i]=spz32[(j*64)+48];      
    }
  }
  
  
  for(int j=1;j<63;j++)
  {
    for(int i=0;i<64;i++)
    {
      spx[(j*64)+i]=spx32[(j*64)+i];
      spy[(j*64)+i]=spy32[(j*64)+i];
      spz[(j*64)+i]=spz32[(j*64)+i];
    }
  }
  generate_scuptxyz(); 

}
void stone_transferto3()
{
  stone_transferto6();
  for(int j=0;j<64;j++)
  {
    for(int i=10;i<20;i++)
    {
      spx32[(j*64)+i]=spx32[(j*64)+0];
      spy32[(j*64)+i]=spy32[(j*64)+0];
      spz32[(j*64)+i]=spz32[(j*64)+0];      
    }
  }
  for(int j=0;j<64;j++)
  {
    for(int i=30;i<40;i++)
    {
      spx32[(j*64)+i]=spx32[(j*64)+20];
      spy32[(j*64)+i]=spy32[(j*64)+20];
      spz32[(j*64)+i]=spz32[(j*64)+20];      
    }
  }
  for(int j=0;j<64;j++)
  {
    for(int i=50;i<62;i++)
    {
      spx32[(j*64)+i]=spx32[(j*64)+40];
      spy32[(j*64)+i]=spy32[(j*64)+40];
      spz32[(j*64)+i]=spz32[(j*64)+40];      
    }
  }
  for(int j=1;j<63;j++)
  {
    for(int i=0;i<64;i++)
    {
      spx[(j*64)+i]=spx32[(j*64)+i];
      spy[(j*64)+i]=spy32[(j*64)+i];
      spz[(j*64)+i]=spz32[(j*64)+i];
    }
  }
  generate_scuptxyz(); 
}

void stone_transferto6()
{
        //convert model to 6*6 size xyz looking model   
      for (int j=0;j<sculptsize-10; j+=10) //1
      {
        for (int i=0;i<sculptsize-10; i+=10) //1
        {
            int p1=(j*sculptsize)+i;
            int p2=((j+1)*sculptsize)+i;
            int p3=((j+2)*sculptsize)+i;
            int p4=((j+3)*sculptsize)+i;
            int p5=((j+4)*sculptsize)+i;
            int p6=((j+5)*sculptsize)+i;
            int p7=((j+6)*sculptsize)+i;
            int p8=((j+7)*sculptsize)+i;
            int p9=((j+8)*sculptsize)+i;
            int p10=((j+9)*sculptsize)+i;
            
            spx32[p1]=(               spx[p1]+spx[p1+1]+spx[p1+2]+spx[p1+3]+spx[p1+4]+spx[p1+5]+spx[p1+6]+spx[p1+7]+spx[p1+8]+spx[p1+9]
                                    + spx[p2]+spx[p2+1]+spx[p2+2]+spx[p2+3]+spx[p2+4]+spx[p2+5]+spx[p2+6]+spx[p2+7]+spx[p2+8]+spx[p2+9]
                                    + spx[p3]+spx[p3+1]+spx[p3+2]+spx[p3+3]+spx[p3+4]+spx[p3+5]+spx[p3+6]+spx[p3+7]+spx[p3+8]+spx[p3+9]
                                    + spx[p4]+spx[p4+1]+spx[p4+2]+spx[p4+3]+spx[p4+4]+spx[p4+5]+spx[p4+6]+spx[p4+7]+spx[p4+8]+spx[p4+9]
                                    + spx[p5]+spx[p5+1]+spx[p5+2]+spx[p5+3]+spx[p5+4]+spx[p5+5]+spx[p5+6]+spx[p5+7]+spx[p5+8]+spx[p5+9]
                                    + spx[p6]+spx[p6+1]+spx[p6+2]+spx[p6+3]+spx[p6+4]+spx[p6+5]+spx[p6+6]+spx[p6+7]+spx[p6+8]+spx[p6+9]
                                    + spx[p7]+spx[p7+1]+spx[p7+2]+spx[p7+3]+spx[p7+4]+spx[p7+5]+spx[p7+6]+spx[p7+7]+spx[p7+8]+spx[p7+9]                                    
                                    + spx[p8]+spx[p8+1]+spx[p8+2]+spx[p8+3]+spx[p8+4]+spx[p8+5]+spx[p8+6]+spx[p8+7]+spx[p8+8]+spx[p8+9]                                    
                                    + spx[p9]+spx[p9+1]+spx[p9+2]+spx[p9+3]+spx[p9+4]+spx[p9+5]+spx[p9+6]+spx[p9+7]+spx[p9+8]+spx[p9+9]                                    
                                    + spx[p10]+spx[p10+1]+spx[p10+2]+spx[p10+3]+spx[p10+4]+spx[p10+5]+spx[p10+6]+spx[p10+7]+spx[p10+8]+spx[p10+9]                                    
                                    )/100.0f;
            spx32[p1+1]=spx32[p1];
            spx32[p1+2]=spx32[p1];
            spx32[p1+3]=spx32[p1];
            spx32[p1+4]=spx32[p1];
            spx32[p1+5]=spx32[p1];
            spx32[p1+6]=spx32[p1];
            spx32[p1+7]=spx32[p1];
            spx32[p1+8]=spx32[p1];
            spx32[p1+9]=spx32[p1];
           
            spx32[p2]=spx32[p1];
            spx32[p2+1]=spx32[p1];
            spx32[p2+2]=spx32[p1];
            spx32[p2+3]=spx32[p1];
            spx32[p2+4]=spx32[p1];
            spx32[p2+5]=spx32[p1];
            spx32[p2+6]=spx32[p1];
            spx32[p2+7]=spx32[p1];
            spx32[p2+8]=spx32[p1];
            spx32[p2+9]=spx32[p1];
            
            spx32[p3]=spx32[p1];
            spx32[p3+1]=spx32[p1];
            spx32[p3+2]=spx32[p1];
            spx32[p3+3]=spx32[p1];
            spx32[p3+4]=spx32[p1];
            spx32[p3+5]=spx32[p1];
            spx32[p3+6]=spx32[p1];
            spx32[p3+7]=spx32[p1];
            spx32[p3+8]=spx32[p1];
            spx32[p3+9]=spx32[p1];
            
            spx32[p4]=spx32[p1];
            spx32[p4+1]=spx32[p1];
            spx32[p4+2]=spx32[p1];
            spx32[p4+3]=spx32[p1];
            spx32[p4+4]=spx32[p1];
            spx32[p4+5]=spx32[p1];
            spx32[p4+6]=spx32[p1];
            spx32[p4+7]=spx32[p1];
            spx32[p4+8]=spx32[p1];
            spx32[p4+9]=spx32[p1];

            spx32[p5]=spx32[p1];
            spx32[p5+1]=spx32[p1];
            spx32[p5+2]=spx32[p1];
            spx32[p5+3]=spx32[p1];
            spx32[p5+4]=spx32[p1];
            spx32[p5+5]=spx32[p1];
            spx32[p5+6]=spx32[p1];
            spx32[p5+7]=spx32[p1];
            spx32[p5+8]=spx32[p1];
            spx32[p5+9]=spx32[p1];

            spx32[p6]=spx32[p1];
            spx32[p6+1]=spx32[p1];
            spx32[p6+2]=spx32[p1];
            spx32[p6+3]=spx32[p1];
            spx32[p6+4]=spx32[p1];
            spx32[p6+5]=spx32[p1];
            spx32[p6+6]=spx32[p1];
            spx32[p6+7]=spx32[p1];
            spx32[p6+8]=spx32[p1];
            spx32[p6+9]=spx32[p1];
            
            spx32[p7]=spx32[p1];
            spx32[p7+1]=spx32[p1];
            spx32[p7+2]=spx32[p1];
            spx32[p7+3]=spx32[p1];
            spx32[p7+4]=spx32[p1];
            spx32[p7+5]=spx32[p1];
            spx32[p7+6]=spx32[p1];
            spx32[p7+7]=spx32[p1];
            spx32[p7+8]=spx32[p1];
            spx32[p7+9]=spx32[p1];
            
            spx32[p8]=spx32[p1];
            spx32[p8+1]=spx32[p1];
            spx32[p8+2]=spx32[p1];
            spx32[p8+3]=spx32[p1];
            spx32[p8+4]=spx32[p1];
            spx32[p8+5]=spx32[p1];
            spx32[p8+6]=spx32[p1];
            spx32[p8+7]=spx32[p1];
            spx32[p8+8]=spx32[p1];
            spx32[p8+9]=spx32[p1];

            spx32[p9]=spx32[p1];
            spx32[p9+1]=spx32[p1];
            spx32[p9+2]=spx32[p1];
            spx32[p9+3]=spx32[p1];
            spx32[p9+4]=spx32[p1];
            spx32[p9+5]=spx32[p1];
            spx32[p9+6]=spx32[p1];
            spx32[p9+7]=spx32[p1];
            spx32[p9+8]=spx32[p1];
            spx32[p9+9]=spx32[p1];

            spx32[p10]=spx32[p1];
            spx32[p10+1]=spx32[p1];
            spx32[p10+2]=spx32[p1];
            spx32[p10+3]=spx32[p1];
            spx32[p10+4]=spx32[p1];
            spx32[p10+5]=spx32[p1];
            spx32[p10+6]=spx32[p1];
            spx32[p10+7]=spx32[p1];
            spx32[p10+8]=spx32[p1];
            spx32[p10+9]=spx32[p1];

            spy32[p1]=(               spy[p1]+spy[p1+1]+spy[p1+2]+spy[p1+3]+spy[p1+4]+spy[p1+5]+spy[p1+6]+spy[p1+7]+spy[p1+8]+spy[p1+9]
                                    + spy[p2]+spy[p2+1]+spy[p2+2]+spy[p2+3]+spy[p2+4]+spy[p2+5]+spy[p2+6]+spy[p2+7]+spy[p2+8]+spy[p2+9]
                                    + spy[p3]+spy[p3+1]+spy[p3+2]+spy[p3+3]+spy[p3+4]+spy[p3+5]+spy[p3+6]+spy[p3+7]+spy[p3+8]+spy[p3+9]
                                    + spy[p4]+spy[p4+1]+spy[p4+2]+spy[p4+3]+spy[p4+4]+spy[p4+5]+spy[p4+6]+spy[p4+7]+spy[p4+8]+spy[p4+9]
                                    + spy[p5]+spy[p5+1]+spy[p5+2]+spy[p5+3]+spy[p5+4]+spy[p5+5]+spy[p5+6]+spy[p5+7]+spy[p5+8]+spy[p5+9]
                                    + spy[p6]+spy[p6+1]+spy[p6+2]+spy[p6+3]+spy[p6+4]+spy[p6+5]+spy[p6+6]+spy[p6+7]+spy[p6+8]+spy[p6+9]
                                    + spy[p7]+spy[p7+1]+spy[p7+2]+spy[p7+3]+spy[p7+4]+spy[p7+5]+spy[p7+6]+spy[p7+7]+spy[p7+8]+spy[p7+9]                                   
                                    + spy[p8]+spy[p8+1]+spy[p8+2]+spy[p8+3]+spy[p8+4]+spy[p8+5]+spy[p8+6]+spy[p8+7]+spy[p8+8]+spy[p8+9]                                   
                                    + spy[p9]+spy[p9+1]+spy[p9+2]+spy[p9+3]+spy[p9+4]+spy[p9+5]+spy[p9+6]+spy[p9+7]+spy[p9+8]+spy[p9+9]                                   
                                    + spy[p10]+spy[p10+1]+spy[p10+2]+spy[p10+3]+spy[p10+4]+spy[p10+5]+spy[p10+6]+spy[p10+7]+spy[p10+8]+spy[p10+9]                                   
                                    )/100.0f;
                                    
            spy32[p1+1]=spy32[p1];
            spy32[p1+2]=spy32[p1];
            spy32[p1+3]=spy32[p1];
            spy32[p1+4]=spy32[p1];
            spy32[p1+5]=spy32[p1];
            spy32[p1+6]=spy32[p1];
            spy32[p1+7]=spy32[p1];
            spy32[p1+8]=spy32[p1];
            spy32[p1+9]=spy32[p1];
            
            
            spy32[p2]=spy32[p1];
            spy32[p2+1]=spy32[p1];
            spy32[p2+2]=spy32[p1];
            spy32[p2+3]=spy32[p1];
            spy32[p2+4]=spy32[p1];
            spy32[p2+5]=spy32[p1];
            spy32[p2+6]=spy32[p1];
            spy32[p2+7]=spy32[p1];
            spy32[p2+8]=spy32[p1];
            spy32[p2+9]=spy32[p1];
         
            spy32[p3]=spy32[p1];
            spy32[p3+1]=spy32[p1];
            spy32[p3+2]=spy32[p1];
            spy32[p3+3]=spy32[p1];
            spy32[p3+4]=spy32[p1];
            spy32[p3+5]=spy32[p1];
            spy32[p3+6]=spy32[p1];
            spy32[p3+7]=spy32[p1];
            spy32[p3+8]=spy32[p1];
            spy32[p3+9]=spy32[p1];
         
            spy32[p4]=spy32[p1];
            spy32[p4+1]=spy32[p1];
            spy32[p4+2]=spy32[p1];
            spy32[p4+3]=spy32[p1];
            spy32[p4+4]=spy32[p1];
            spy32[p4+5]=spy32[p1];
            spy32[p4+6]=spy32[p1];
            spy32[p4+7]=spy32[p1];
            spy32[p4+8]=spy32[p1];
            spy32[p4+9]=spy32[p1];

            spy32[p5]=spy32[p1];
            spy32[p5+1]=spy32[p1];
            spy32[p5+2]=spy32[p1];
            spy32[p5+3]=spy32[p1];
            spy32[p5+4]=spy32[p1];
            spy32[p5+5]=spy32[p1];
            spy32[p5+6]=spy32[p1];
            spy32[p5+7]=spy32[p1];
            spy32[p5+8]=spy32[p1];
            spy32[p5+9]=spy32[p1];

            spy32[p6]=spy32[p1];
            spy32[p6+1]=spy32[p1];
            spy32[p6+2]=spy32[p1];
            spy32[p6+3]=spy32[p1];
            spy32[p6+4]=spy32[p1];
            spy32[p6+5]=spy32[p1];
            spy32[p6+6]=spy32[p1];
            spy32[p6+7]=spy32[p1];
            spy32[p6+8]=spy32[p1];
            spy32[p6+9]=spy32[p1];

            spy32[p7]=spy32[p1];
            spy32[p7+1]=spy32[p1];
            spy32[p7+2]=spy32[p1];
            spy32[p7+3]=spy32[p1];
            spy32[p7+4]=spy32[p1];
            spy32[p7+5]=spy32[p1];
            spy32[p7+6]=spy32[p1];
            spy32[p7+7]=spy32[p1];
            spy32[p7+8]=spy32[p1];
            spy32[p7+9]=spy32[p1];

            spy32[p8]=spy32[p1];
            spy32[p8+1]=spy32[p1];
            spy32[p8+2]=spy32[p1];
            spy32[p8+3]=spy32[p1];
            spy32[p8+4]=spy32[p1];
            spy32[p8+5]=spy32[p1];
            spy32[p8+6]=spy32[p1];
            spy32[p8+7]=spy32[p1];
            spy32[p8+8]=spy32[p1];
            spy32[p8+9]=spy32[p1];

            spy32[p9]=spy32[p1];
            spy32[p9+1]=spy32[p1];
            spy32[p9+2]=spy32[p1];
            spy32[p9+3]=spy32[p1];
            spy32[p9+4]=spy32[p1];
            spy32[p9+5]=spy32[p1];
            spy32[p9+6]=spy32[p1];
            spy32[p9+7]=spy32[p1];
            spy32[p9+8]=spy32[p1];
            spy32[p9+9]=spy32[p1];

            spy32[p10]=spy32[p1];
            spy32[p10+1]=spy32[p1];
            spy32[p10+2]=spy32[p1];
            spy32[p10+3]=spy32[p1];
            spy32[p10+4]=spy32[p1];
            spy32[p10+5]=spy32[p1];
            spy32[p10+6]=spy32[p1];
            spy32[p10+7]=spy32[p1];
            spy32[p10+8]=spy32[p1];
            spy32[p10+9]=spy32[p1];

            spz32[p1]=(               spz[p1]+spz[p1+1]+spz[p1+2]+spz[p1+3]+spz[p1+4]+spz[p1+5]+spz[p1+6]+spz[p1+7]+spz[p1+8]+spz[p1+9]
                                    + spz[p2]+spz[p2+1]+spz[p2+2]+spz[p2+3]+spz[p2+4]+spz[p2+5]+spz[p2+6]+spz[p2+7]+spz[p2+8]+spz[p2+9]
                                    + spz[p3]+spz[p3+1]+spz[p3+2]+spz[p3+3]+spz[p3+4]+spz[p3+5]+spz[p3+6]+spz[p3+7]+spz[p3+8]+spz[p3+9]
                                    + spz[p4]+spz[p4+1]+spz[p4+2]+spz[p4+3]+spz[p4+4]+spz[p4+5]+spz[p4+6]+spz[p4+7]+spz[p4+8]+spz[p4+9]
                                    + spz[p5]+spz[p5+1]+spz[p5+2]+spz[p5+3]+spz[p5+4]+spz[p5+5]+spz[p5+6]+spz[p5+7]+spz[p5+8]+spz[p5+9]
                                    + spz[p6]+spz[p6+1]+spz[p6+2]+spz[p6+3]+spz[p6+4]+spz[p6+5]+spz[p6+6]+spz[p6+7]+spz[p6+8]+spz[p6+9]
                                    + spz[p7]+spz[p7+1]+spz[p7+2]+spz[p7+3]+spz[p7+4]+spz[p7+5]+spz[p7+6]+spz[p7+7]+spz[p7+8]+spz[p7+9]
                                    + spz[p8]+spz[p8+1]+spz[p8+2]+spz[p8+3]+spz[p8+4]+spz[p8+5]+spz[p8+6]+spz[p8+7]+spz[p8+8]+spz[p8+9]                                    
                                    + spz[p9]+spz[p9+1]+spz[p9+2]+spz[p9+3]+spz[p9+4]+spz[p9+5]+spz[p9+6]+spz[p9+7]+spz[p9+8]+spz[p9+9]
                                    + spz[p10]+spz[p10+1]+spz[p10+2]+spz[p10+3]+spz[p10+4]+spz[p10+5]+spz[p10+6]+spz[p10+7]+spz[p10+8]+spz[p10+9]                                    
                                    )/100.0f;            
            spz32[p1+1]=spz32[p1];
            spz32[p1+2]=spz32[p1];
            spz32[p1+3]=spz32[p1];
            spz32[p1+4]=spz32[p1];
            spz32[p1+5]=spz32[p1];
            spz32[p1+6]=spz32[p1];
            spz32[p1+7]=spz32[p1];
            spz32[p1+8]=spz32[p1];
            spz32[p1+9]=spz32[p1];
            
            spz32[p2]=spz32[p1];
            spz32[p2+1]=spz32[p1];
            spz32[p2+2]=spz32[p1];
            spz32[p2+3]=spz32[p1];
            spz32[p2+4]=spz32[p1];
            spz32[p2+5]=spz32[p1];
            spz32[p2+6]=spz32[p1];
            spz32[p2+7]=spz32[p1];
            spz32[p2+8]=spz32[p1];
            spz32[p2+9]=spz32[p1];
            
            spz32[p3]=spz32[p1];
            spz32[p3+1]=spz32[p1];
            spz32[p3+2]=spz32[p1];
            spz32[p3+3]=spz32[p1];
            spz32[p3+4]=spz32[p1];
            spz32[p3+5]=spz32[p1];
            spz32[p3+6]=spz32[p1];
            spz32[p3+7]=spz32[p1];
            spz32[p3+8]=spz32[p1];
            spz32[p3+9]=spz32[p1];
            
            spz32[p4]=spz32[p1];
            spz32[p4+1]=spz32[p1];
            spz32[p4+2]=spz32[p1];
            spz32[p4+3]=spz32[p1];            
            spz32[p4+4]=spz32[p1];
            spz32[p4+5]=spz32[p1];
            spz32[p4+6]=spz32[p1];
            spz32[p4+7]=spz32[p1];
            spz32[p4+8]=spz32[p1];
            spz32[p4+9]=spz32[p1];
            
            spz32[p5]=spz32[p1];
            spz32[p5+1]=spz32[p1];
            spz32[p5+2]=spz32[p1];
            spz32[p5+3]=spz32[p1];            
            spz32[p5+4]=spz32[p1];
            spz32[p5+5]=spz32[p1];
            spz32[p5+6]=spz32[p1];
            spz32[p5+7]=spz32[p1];
            spz32[p5+8]=spz32[p1];
            spz32[p5+9]=spz32[p1];
            
            spz32[p6]=spz32[p1];
            spz32[p6+1]=spz32[p1];
            spz32[p6+2]=spz32[p1];
            spz32[p6+3]=spz32[p1];            
            spz32[p6+4]=spz32[p1];
            spz32[p6+5]=spz32[p1];
            spz32[p6+6]=spz32[p1];
            spz32[p6+7]=spz32[p1];
            spz32[p6+8]=spz32[p1];
            spz32[p6+9]=spz32[p1];
            
            spz32[p7]=spz32[p1];
            spz32[p7+1]=spz32[p1];
            spz32[p7+2]=spz32[p1];
            spz32[p7+3]=spz32[p1];            
            spz32[p7+4]=spz32[p1];
            spz32[p7+5]=spz32[p1];
            spz32[p7+6]=spz32[p1];
            spz32[p7+7]=spz32[p1];
            spz32[p7+8]=spz32[p1];
            spz32[p7+9]=spz32[p1];
            
            spz32[p8]=spz32[p1];
            spz32[p8+1]=spz32[p1];
            spz32[p8+2]=spz32[p1];
            spz32[p8+3]=spz32[p1];            
            spz32[p8+4]=spz32[p1];
            spz32[p8+5]=spz32[p1];
            spz32[p8+6]=spz32[p1];
            spz32[p8+7]=spz32[p1];            
            spz32[p8+8]=spz32[p1];
            spz32[p8+9]=spz32[p1];

            spz32[p9]=spz32[p1];
            spz32[p9+1]=spz32[p1];
            spz32[p9+2]=spz32[p1];
            spz32[p9+3]=spz32[p1];            
            spz32[p9+4]=spz32[p1];
            spz32[p9+5]=spz32[p1];
            spz32[p9+6]=spz32[p1];
            spz32[p9+7]=spz32[p1];            
            spz32[p9+8]=spz32[p1];
            spz32[p9+9]=spz32[p1];

            spz32[p10]=spz32[p1];
            spz32[p10+1]=spz32[p1];
            spz32[p10+2]=spz32[p1];
            spz32[p10+3]=spz32[p1];            
            spz32[p10+4]=spz32[p1];
            spz32[p10+5]=spz32[p1];
            spz32[p10+6]=spz32[p1];
            spz32[p10+7]=spz32[p1];            
            spz32[p10+8]=spz32[p1];
            spz32[p10+9]=spz32[p1];
        }
      }
      
  for (int j=0;j<sculptsize; j++) //1
  {
        for (int i=60;i<sculptsize-2; i++) //1
        {
          spx32[(j*64)+i]=spx32[(j*64)+59];
          spy32[(j*64)+i]=spy32[(j*64)+59];
          spz32[(j*64)+i]=spz32[(j*64)+59];
        }
  }    

   //fix last parts
   /*
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<10;i++)
    {
      spx32[(j*64)+i]=((spx32[(j*64)+i]*5)+spx32[(j*64)+59])/6.0;
      spy32[(j*64)+i]=((spy32[(j*64)+i]*5)+spy32[(j*64)+59])/6.0;
      spz32[(j*64)+i]=((spz32[(j*64)+i]*5)+spz32[(j*64)+59])/6.0;      
    }
  }*/
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<10;i++)
    {
      spx32[(j*64)+i]=-spx32[(j*64)+30];
      spy32[(j*64)+i]=spy32[(j*64)+30];
      spz32[(j*64)+i]=-spz32[(j*64)+30];      
    }
  }
  
  for (int j=0;j<sculptsize; j++) //1
  {
        for (int i=62;i<sculptsize; i++) //1
        {
          spx32[(j*64)+i]=spx32[(j*64)];
          spy32[(j*64)+i]=spy32[(j*64)];
          spz32[(j*64)+i]=spz32[(j*64)];
        }
  }
  /*
  for(int j=0;j<64;j++)
  {
    for(int i=50;i<62;i++)
    {
      spx32[(j*64)+i]=((spx32[(j*64)+i]*5)+spx32[(j*64)+0])/6.0;
      spy32[(j*64)+i]=((spy32[(j*64)+i]*5)+spy32[(j*64)+0])/6.0;
      spz32[(j*64)+i]=((spz32[(j*64)+i]*5)+spz32[(j*64)+0])/6.0;      
    }
  }*/
  
 
  for(int j=0;j<64;j++)
  {
    for(int i=50;i<62;i++)
    {
      spx32[(j*64)+i]=-spx32[(j*64)+20];
      spy32[(j*64)+i]=spy32[(j*64)+20];
      spz32[(j*64)+i]=-spz32[(j*64)+20];      
    }
  }
  for(int j=1;j<63;j++)
  {
    for(int i=0;i<64;i++)
    {
      spx[(j*64)+i]=spx32[(j*64)+i];
      spy[(j*64)+i]=spy32[(j*64)+i];
      spz[(j*64)+i]=spz32[(j*64)+i];
    }
  }
  generate_scuptxyz();  
}


void stone_transferto8()
{
        //convert model to 8*8 size xyz looking model   
      for (int j=0;j<sculptsize-1; j+=8) //1
      {
        for (int i=0;i<sculptsize-1; i+=8) //1
        {
            int p1=(j*sculptsize)+i;
            int p2=((j+1)*sculptsize)+i;
            int p3=((j+2)*sculptsize)+i;
            int p4=((j+3)*sculptsize)+i;
            int p5=((j+4)*sculptsize)+i;
            int p6=((j+5)*sculptsize)+i;
            int p7=((j+6)*sculptsize)+i;
            int p8=((j+7)*sculptsize)+i;
            
            spx32[p1]=(               spx[p1]+spx[p1+1]+spx[p1+2]+spx[p1+3]+spx[p1+4]+spx[p1+5]+spx[p1+6]+spx[p1+7]
                                    + spx[p2]+spx[p2+1]+spx[p2+2]+spx[p2+3]+spx[p2+4]+spx[p2+5]+spx[p2+6]+spx[p2+7]
                                    + spx[p3]+spx[p3+1]+spx[p3+2]+spx[p3+3]+spx[p3+4]+spx[p3+5]+spx[p3+6]+spx[p3+7]
                                    + spx[p4]+spx[p4+1]+spx[p4+2]+spx[p4+3]+spx[p4+4]+spx[p4+5]+spx[p4+6]+spx[p4+7]
                                    + spx[p5]+spx[p5+1]+spx[p5+2]+spx[p5+3]+spx[p5+4]+spx[p5+5]+spx[p5+6]+spx[p5+7]
                                    + spx[p6]+spx[p6+1]+spx[p6+2]+spx[p6+3]+spx[p6+4]+spx[p6+5]+spx[p6+6]+spx[p6+7]
                                    + spx[p7]+spx[p7+1]+spx[p7+2]+spx[p7+3]+spx[p7+4]+spx[p7+5]+spx[p7+6]+spx[p7+7]                                    
                                    + spx[p8]+spx[p8+1]+spx[p8+2]+spx[p8+3]+spx[p8+4]+spx[p8+5]+spx[p8+6]+spx[p8+7]                                    
                                    )/64.0f;
            spx32[p1+1]=spx32[p1];
            spx32[p1+2]=spx32[p1];
            spx32[p1+3]=spx32[p1];
            spx32[p1+4]=spx32[p1];
            spx32[p1+5]=spx32[p1];
            spx32[p1+6]=spx32[p1];
            spx32[p1+7]=spx32[p1];
           
            spx32[p2]=spx32[p1];
            spx32[p2+1]=spx32[p1];
            spx32[p2+2]=spx32[p1];
            spx32[p2+3]=spx32[p1];
            spx32[p2+4]=spx32[p1];
            spx32[p2+5]=spx32[p1];
            spx32[p2+6]=spx32[p1];
            spx32[p2+7]=spx32[p1];
            
            spx32[p3]=spx32[p1];
            spx32[p3+1]=spx32[p1];
            spx32[p3+2]=spx32[p1];
            spx32[p3+3]=spx32[p1];
            spx32[p3+4]=spx32[p1];
            spx32[p3+5]=spx32[p1];
            spx32[p3+6]=spx32[p1];
            spx32[p3+7]=spx32[p1];
            
            spx32[p4]=spx32[p1];
            spx32[p4+1]=spx32[p1];
            spx32[p4+2]=spx32[p1];
            spx32[p4+3]=spx32[p1];
            spx32[p4+4]=spx32[p1];
            spx32[p4+5]=spx32[p1];
            spx32[p4+6]=spx32[p1];
            spx32[p4+7]=spx32[p1];

            spx32[p5]=spx32[p1];
            spx32[p5+1]=spx32[p1];
            spx32[p5+2]=spx32[p1];
            spx32[p5+3]=spx32[p1];
            spx32[p5+4]=spx32[p1];
            spx32[p5+5]=spx32[p1];
            spx32[p5+6]=spx32[p1];
            spx32[p5+7]=spx32[p1];

            spx32[p6]=spx32[p1];
            spx32[p6+1]=spx32[p1];
            spx32[p6+2]=spx32[p1];
            spx32[p6+3]=spx32[p1];
            spx32[p6+4]=spx32[p1];
            spx32[p6+5]=spx32[p1];
            spx32[p6+6]=spx32[p1];
            spx32[p6+7]=spx32[p1];
            
            spx32[p7]=spx32[p1];
            spx32[p7+1]=spx32[p1];
            spx32[p7+2]=spx32[p1];
            spx32[p7+3]=spx32[p1];
            spx32[p7+4]=spx32[p1];
            spx32[p7+5]=spx32[p1];
            spx32[p7+6]=spx32[p1];
            spx32[p7+7]=spx32[p1];
            
            spx32[p8]=spx32[p1];
            spx32[p8+1]=spx32[p1];
            spx32[p8+2]=spx32[p1];
            spx32[p8+3]=spx32[p1];
            spx32[p8+4]=spx32[p1];
            spx32[p8+5]=spx32[p1];
            spx32[p8+6]=spx32[p1];
            spx32[p8+7]=spx32[p1];

            
           // spy32[p1]=(spy[p1]+spy[p1+1]+spy[p1+2]+spy[p1+3] + spy[p2]+spy[p2+1]+spy[p2+2]+spy[p2+3] + spy[p3]+spy[p3+1]+spy[p3+2]+spy[p3+3] + spy[p4]+spy[p4+1]+spy[p4+2]+spy[p4+3])/16.0f;
            spy32[p1]=(               spy[p1]+spy[p1+1]+spy[p1+2]+spy[p1+3]+spy[p1+4]+spy[p1+5]+spy[p1+6]+spy[p1+7]
                                    + spy[p2]+spy[p2+1]+spy[p2+2]+spy[p2+3]+spy[p2+4]+spy[p2+5]+spy[p2+6]+spy[p2+7]
                                    + spy[p3]+spy[p3+1]+spy[p3+2]+spy[p3+3]+spy[p3+4]+spy[p3+5]+spy[p3+6]+spy[p3+7]
                                    + spy[p4]+spy[p4+1]+spy[p4+2]+spy[p4+3]+spy[p4+4]+spy[p4+5]+spy[p4+6]+spy[p4+7]
                                    + spy[p5]+spy[p5+1]+spy[p5+2]+spy[p5+3]+spy[p5+4]+spy[p5+5]+spy[p5+6]+spy[p5+7]
                                    + spy[p6]+spy[p6+1]+spy[p6+2]+spy[p6+3]+spy[p6+4]+spy[p6+5]+spy[p6+6]+spy[p6+7]
                                    + spy[p7]+spy[p7+1]+spy[p7+2]+spy[p7+3]+spy[p7+4]+spy[p7+5]+spy[p7+6]+spy[p7+7]                                    
                                    + spy[p8]+spy[p8+1]+spy[p8+2]+spy[p8+3]+spy[p8+4]+spy[p8+5]+spy[p8+6]+spy[p8+7]                                    
                                    )/64.0f;
                                    
            spy32[p1+1]=spy32[p1];
            spy32[p1+2]=spy32[p1];
            spy32[p1+3]=spy32[p1];
            spy32[p1+4]=spy32[p1];
            spy32[p1+5]=spy32[p1];
            spy32[p1+6]=spy32[p1];
            spy32[p1+7]=spy32[p1];
            
            
            spy32[p2]=spy32[p1];
            spy32[p2+1]=spy32[p1];
            spy32[p2+2]=spy32[p1];
            spy32[p2+3]=spy32[p1];
            spy32[p2+4]=spy32[p1];
            spy32[p2+5]=spy32[p1];
            spy32[p2+6]=spy32[p1];
            spy32[p2+7]=spy32[p1];
         
            spy32[p3]=spy32[p1];
            spy32[p3+1]=spy32[p1];
            spy32[p3+2]=spy32[p1];
            spy32[p3+3]=spy32[p1];
            spy32[p3+4]=spy32[p1];
            spy32[p3+5]=spy32[p1];
            spy32[p3+6]=spy32[p1];
            spy32[p3+7]=spy32[p1];
         
            spy32[p4]=spy32[p1];
            spy32[p4+1]=spy32[p1];
            spy32[p4+2]=spy32[p1];
            spy32[p4+3]=spy32[p1];
            spy32[p4+4]=spy32[p1];
            spy32[p4+5]=spy32[p1];
            spy32[p4+6]=spy32[p1];
            spy32[p4+7]=spy32[p1];

            spy32[p5]=spy32[p1];
            spy32[p5+1]=spy32[p1];
            spy32[p5+2]=spy32[p1];
            spy32[p5+3]=spy32[p1];
            spy32[p5+4]=spy32[p1];
            spy32[p5+5]=spy32[p1];
            spy32[p5+6]=spy32[p1];
            spy32[p5+7]=spy32[p1];

            spy32[p6]=spy32[p1];
            spy32[p6+1]=spy32[p1];
            spy32[p6+2]=spy32[p1];
            spy32[p6+3]=spy32[p1];
            spy32[p6+4]=spy32[p1];
            spy32[p6+5]=spy32[p1];
            spy32[p6+6]=spy32[p1];
            spy32[p6+7]=spy32[p1];

            spy32[p7]=spy32[p1];
            spy32[p7+1]=spy32[p1];
            spy32[p7+2]=spy32[p1];
            spy32[p7+3]=spy32[p1];
            spy32[p7+4]=spy32[p1];
            spy32[p7+5]=spy32[p1];
            spy32[p7+6]=spy32[p1];
            spy32[p7+7]=spy32[p1];

            spy32[p8]=spy32[p1];
            spy32[p8+1]=spy32[p1];
            spy32[p8+2]=spy32[p1];
            spy32[p8+3]=spy32[p1];
            spy32[p8+4]=spy32[p1];
            spy32[p8+5]=spy32[p1];
            spy32[p8+6]=spy32[p1];
            spy32[p8+7]=spy32[p1];


            //spz32[p1]=(spz[p1]+spz[p1+1]+spz[p1+2]+spz[p1+3] + spz[p2]+spz[p2+1]+spz[p2+2]+spz[p2+3] + spz[p3]+spz[p3+1]+spz[p3+2]+spz[p3+3] + spz[p4]+spz[p4+1]+spz[p4+2]+spz[p4+3])/16.0f;
            spz32[p1]=(               spz[p1]+spz[p1+1]+spz[p1+2]+spz[p1+3]+spz[p1+4]+spz[p1+5]+spz[p1+6]+spz[p1+7]
                                    + spz[p2]+spz[p2+1]+spz[p2+2]+spz[p2+3]+spz[p2+4]+spz[p2+5]+spz[p2+6]+spz[p2+7]
                                    + spz[p3]+spz[p3+1]+spz[p3+2]+spz[p3+3]+spz[p3+4]+spz[p3+5]+spz[p3+6]+spz[p3+7]
                                    + spz[p4]+spz[p4+1]+spz[p4+2]+spz[p4+3]+spz[p4+4]+spz[p4+5]+spz[p4+6]+spz[p4+7]
                                    + spz[p5]+spz[p5+1]+spz[p5+2]+spz[p5+3]+spz[p5+4]+spz[p5+5]+spz[p5+6]+spz[p5+7]
                                    + spz[p6]+spz[p6+1]+spz[p6+2]+spz[p6+3]+spz[p6+4]+spz[p6+5]+spz[p6+6]+spz[p6+7]
                                    + spz[p7]+spz[p7+1]+spz[p7+2]+spz[p7+3]+spz[p7+4]+spz[p7+5]+spz[p7+6]+spz[p7+7]                                    
                                    + spz[p8]+spz[p8+1]+spz[p8+2]+spz[p8+3]+spz[p8+4]+spz[p8+5]+spz[p8+6]+spz[p8+7]                                    
                                    )/64.0f;            
            spz32[p1+1]=spz32[p1];
            spz32[p1+2]=spz32[p1];
            spz32[p1+3]=spz32[p1];
            spz32[p1+4]=spz32[p1];
            spz32[p1+5]=spz32[p1];
            spz32[p1+6]=spz32[p1];
            spz32[p1+7]=spz32[p1];
            
            spz32[p2]=spz32[p1];
            spz32[p2+1]=spz32[p1];
            spz32[p2+2]=spz32[p1];
            spz32[p2+3]=spz32[p1];
            spz32[p2+4]=spz32[p1];
            spz32[p2+5]=spz32[p1];
            spz32[p2+6]=spz32[p1];
            spz32[p2+7]=spz32[p1];

            
            spz32[p3]=spz32[p1];
            spz32[p3+1]=spz32[p1];
            spz32[p3+2]=spz32[p1];
            spz32[p3+3]=spz32[p1];
            spz32[p3+4]=spz32[p1];
            spz32[p3+5]=spz32[p1];
            spz32[p3+6]=spz32[p1];
            spz32[p3+7]=spz32[p1];
            
            spz32[p4]=spz32[p1];
            spz32[p4+1]=spz32[p1];
            spz32[p4+2]=spz32[p1];
            spz32[p4+3]=spz32[p1];            
            spz32[p4+4]=spz32[p1];
            spz32[p4+5]=spz32[p1];
            spz32[p4+6]=spz32[p1];
            spz32[p4+7]=spz32[p1];
            
            spz32[p5]=spz32[p1];
            spz32[p5+1]=spz32[p1];
            spz32[p5+2]=spz32[p1];
            spz32[p5+3]=spz32[p1];            
            spz32[p5+4]=spz32[p1];
            spz32[p5+5]=spz32[p1];
            spz32[p5+6]=spz32[p1];
            spz32[p5+7]=spz32[p1];
            
            spz32[p6]=spz32[p1];
            spz32[p6+1]=spz32[p1];
            spz32[p6+2]=spz32[p1];
            spz32[p6+3]=spz32[p1];            
            spz32[p6+4]=spz32[p1];
            spz32[p6+5]=spz32[p1];
            spz32[p6+6]=spz32[p1];
            spz32[p6+7]=spz32[p1];
            
            spz32[p7]=spz32[p1];
            spz32[p7+1]=spz32[p1];
            spz32[p7+2]=spz32[p1];
            spz32[p7+3]=spz32[p1];            
            spz32[p7+4]=spz32[p1];
            spz32[p7+5]=spz32[p1];
            spz32[p7+6]=spz32[p1];
            spz32[p7+7]=spz32[p1];
            
            spz32[p8]=spz32[p1];
            spz32[p8+1]=spz32[p1];
            spz32[p8+2]=spz32[p1];
            spz32[p8+3]=spz32[p1];            
            spz32[p8+4]=spz32[p1];
            spz32[p8+5]=spz32[p1];
            spz32[p8+6]=spz32[p1];
            spz32[p8+7]=spz32[p1];            
        }
      }
      
  for(int j=1;j<63;j++)
  {
    
    for(int i=0;i<64;i++)
    {
      spx[(j*64)+i]=spx32[(j*64)+i];
      spy[(j*64)+i]=spy32[(j*64)+i];
      spz[(j*64)+i]=spz32[(j*64)+i];
    }
  }
  generate_scuptxyz();  
}

void stone_transferto16()
{
        //convert model to 16*16 size xyz looking model   
      for (int j=0;j<sculptsize-1; j+=4) //1
      {
        for (int i=0;i<sculptsize-1; i+=4) //1
        {
            int p1=(j*sculptsize)+i;
            int p2=((j+1)*sculptsize)+i;
            int p3=((j+2)*sculptsize)+i;
            int p4=((j+3)*sculptsize)+i;
            
            spx32[p1]=(spx[p1]+spx[p1+1]+spx[p1+2]+spx[p1+3] + spx[p2]+spx[p2+1]+spx[p2+2]+spx[p2+3] + spx[p3]+spx[p3+1]+spx[p3+2]+spx[p3+3] + spx[p4]+spx[p4+1]+spx[p4+2]+spx[p4+3])/16.0f;
            spx32[p1+1]=spx32[p1];
            spx32[p1+2]=spx32[p1];
            spx32[p1+3]=spx32[p1];            
            spx32[p2]=spx32[p1];
            spx32[p2+1]=spx32[p1];
            spx32[p2+2]=spx32[p1];
            spx32[p2+3]=spx32[p1];
            spx32[p3]=spx32[p1];
            spx32[p3+1]=spx32[p1];
            spx32[p3+2]=spx32[p1];
            spx32[p3+3]=spx32[p1];
            spx32[p4]=spx32[p1];
            spx32[p4+1]=spx32[p1];
            spx32[p4+2]=spx32[p1];
            spx32[p4+3]=spx32[p1];

            spy32[p1]=(spy[p1]+spy[p1+1]+spy[p1+2]+spy[p1+3] + spy[p2]+spy[p2+1]+spy[p2+2]+spy[p2+3] + spy[p3]+spy[p3+1]+spy[p3+2]+spy[p3+3] + spy[p4]+spy[p4+1]+spy[p4+2]+spy[p4+3])/16.0f;
            spy32[p1+1]=spy32[p1];
            spy32[p1+2]=spy32[p1];
            spy32[p1+3]=spy32[p1];
            spy32[p2]=spy32[p1];
            spy32[p2+1]=spy32[p1];
            spy32[p2+2]=spy32[p1];
            spy32[p2+3]=spy32[p1];
            spy32[p3]=spy32[p1];
            spy32[p3+1]=spy32[p1];
            spy32[p3+2]=spy32[p1];
            spy32[p3+3]=spy32[p1];
            spy32[p4]=spy32[p1];
            spy32[p4+1]=spy32[p1];
            spy32[p4+2]=spy32[p1];
            spy32[p4+3]=spy32[p1];

            spz32[p1]=(spz[p1]+spz[p1+1]+spz[p1+2]+spz[p1+3] + spz[p2]+spz[p2+1]+spz[p2+2]+spz[p2+3] + spz[p3]+spz[p3+1]+spz[p3+2]+spz[p3+3] + spz[p4]+spz[p4+1]+spz[p4+2]+spz[p4+3])/16.0f;
            spz32[p1+1]=spz32[p1];
            spz32[p1+2]=spz32[p1];
            spz32[p1+3]=spz32[p1];
            spz32[p2]=spz32[p1];
            spz32[p2+1]=spz32[p1];
            spz32[p2+2]=spz32[p1];
            spz32[p2+3]=spz32[p1];
            spz32[p3]=spz32[p1];
            spz32[p3+1]=spz32[p1];
            spz32[p3+2]=spz32[p1];
            spz32[p3+3]=spz32[p1];
            spz32[p4]=spz32[p1];
            spz32[p4+1]=spz32[p1];
            spz32[p4+2]=spz32[p1];
            spz32[p4+3]=spz32[p1];            
        }
      }

  for(int j=1;j<63;j++)
  {
    for(int i=0;i<64;i++)
    {
      spx[(j*64)+i]=spx32[(j*64)+i];
      spy[(j*64)+i]=spy32[(j*64)+i];
      spz[(j*64)+i]=spz32[(j*64)+i];
    }
  }
  generate_scuptxyz();  
}


void stone_bendx(int direction)
{
  float rotatorz=256.0f*direction;
  //rotate
  for (int j=0; j<64; j++)
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
  generate_scuptxyz();
}

void stone_bendy(int direction)
{
  float rotatorz=256.0f*direction;//
  for (int j=0; j<64; j++)
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
  generate_scuptxyz();
}

void stone_bendz(int direction)
{
  float rotatorz=256.0f*direction;
  for (int j=0; j<64; j++)
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
  generate_scuptxyz();
}



void scale_x(float inc)
{
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spx[(j*64)+i]=spx[(j*64)+i]*inc;
    } 
  }
  generate_scuptxyz(); 
}

void scale_y(float inc)
{
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spy[(j*64)+i]=spy[(j*64)+i]*inc;
    } 
  }
  generate_scuptxyz(); 
}

void scale_z(float inc)
{
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spz[(j*64)+i]=spz[(j*64)+i]*inc;
    } 
  }
  generate_scuptxyz(); 
}


void flatten_top()
{
  if(flat_top<flat_bottom)
  {
    flat_top++; //2
  }    
  for(int j=0;j<flat_top;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spy[(j*64)+i]=spy[(flat_top*64)+i];
    } 
  }  
  generate_scuptxyz(); 
}

void flatten_bottom()
{
  //println(flat_top+"  -  " + flat_bottom);
  if(flat_top<flat_bottom)
  {
    flat_bottom--; //62
  }  
  for(int j=flat_bottom;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spy[(j*64)+i]=spy[((flat_bottom-1)*64)+i];
    } 
  }  
  generate_scuptxyz();  
}


void pinch_to_middle()
{
  for(int j=0;j<32;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spx[(j*64)+i]=spx[(j*64)+i]*(1+(( (float) (64-j) / 64.0f)/3.0f)) ;
        spz[(j*64)+i]=spz[(j*64)+i]*(1+(( (float) (64-j) / 64.0f)/3.0f)) ;
    } 
  }
  for(int j=32;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        spx[(j*64)+i]=spx[(j*64)+i]*(1+(( (float) (j) / 64.0f)/3.0f)) ;
        spz[(j*64)+i]=spz[(j*64)+i]*(1+(( (float) (j) / 64.0f)/3.0f)) ;
    } 
  }
  
  generate_scuptxyz();
  //getimagedata();

}

void extrude_to_middle()
{
  for(int j=0;j<32;j++)
  {
    for(int i=0;i<64;i++)
    {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*(1-(( (float) (64-j) / 64.0f)/3.0f)) ;
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]*(1-(( (float) (64-j) / 64.0f)/3.0f)) ;
    } 
  }
  for(int j=32;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*(1-(( (float) (j) / 64.0f)/3.0f)) ;
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]*(1-(( (float) (j) / 64.0f)/3.0f)) ;
    } 
  }
  generate_scuptxyz();
  //getimagedata();
}
void pinch_to_bottom()
{
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*(1+(( (float) (64-j) / 64.0f)/6.0f)) ;
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]*(1+(( (float) (64-j) / 64.0f)/6.0f)) ;
    } 
  }
  generate_scuptxyz();
  //getimagedata();
}
void pinch_to_top()
{
  
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*(1+(( (float) j / 64.0f)/6.0f)) ;
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]*(1+(( (float) j / 64.0f)/6.0f)) ;
    } 
  }
  
generate_scuptxyz();
//getimagedata();
}

void extrude_to_bottom()
{
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*(1-(( (float) (64-j) / 64.0f)/6.0f)) ;
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]*(1-(( (float) (64-j) / 64.0f)/6.0f)) ;
    } 
  }
  generate_scuptxyz();
  //getimagedata();
}
void extrude_to_top()
{
  
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*(1-(( (float) j / 64.0f)/6.0f)) ;
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]*(1-(( (float) j / 64.0f)/6.0f)) ;
    } 
  }
  
generate_scuptxyz();
//getimagedata();
}


void reset_to_sphere()
{
      rendertype=1;

   toxi_sphere();
 
   scale_ring2xz(0, 0.0000009f,0);
   scale_ring2xz(62, 0.000009f,0);
   //scale_ring2xz(2, 0.0000009f,0);
   //scale_ring2xz(60, 0.000009f,0);

   //make my sphere perfect mirrored...
   
   //mirror 1st part top
   for(int j=0;j<32;j++)
   {
     for(int i=16,ii=15;i<32;i++)
     {
       spx[(j*64)+i]=-spx[(j*64)+(ii)];
       spy[(j*64)+i]=spy[(j*64)+(ii)];
       spz[(j*64)+i]=spz[(j*64)+(ii)];
       ii--;
     }   
   }

  //3th part top
   for(int j=0;j<32;j++)
   {
     for(int i=32,ii=31;i<48;i++)
     {
       spx[(j*64)+i]=spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=-spz[(j*64)+ii];
       ii--;
     }   
   }
  //4th part top
   for(int j=0;j<32;j++)
   {
     for(int i=48,ii=15;i<64;i++)
     {
       spx[(j*64)+i]=spx[(j*64)+ii];
       spy[(j*64)+i]=spy[(j*64)+ii];
       spz[(j*64)+i]=-spz[(j*64)+ii];
       ii--;
     }   
   }
   
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
   
   
  stone_smooth(); 
  stone_smooth(); 
  stone_smooth(); 
 
   scale_ring2xz(0, 0.0000009f,0);
   scale_ring2xz(62, 0.000009f,0);
 
   generate_scuptxyz();
 // getimagedata();
           
   gridflat= loadImage("data/grid.png");
   flat_top=1;
   flat_bottom=63;   
}




void rotate_rings()
{
  float tempx=0;
  float tempz=0;
  for(int j=0;j<64;j++)
  {
    tempx=spx[(j*64)+0];
    tempz=spz[(j*64)+0];
    for(int i=0;i<63;i++)
    {    
        spx[(j*64)+i]=spx[(j*64)+i+1];
        spz[(j*64)+i]=spz[(j*64)+i+1];
    }
    spx[(j*64)+63]=tempx;
    spz[(j*64)+63]=tempz;    
  }  
}

void reset_to_pyramid()
{

  reset_to_cube();

  for(int j=0;j<56;j++)
  {
    rotate_rings();
  }    
  cube_drawsides(0,16);
  
    
  for(int j=0;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*(( (float) j / 64.0f)*2.0f) ;
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[(j*64)+i]*(( (float) j / 64.0f)*2.0f) ;
    } 
  }
  generate_scuptxyz(); 
  flat_top=1;
  flat_bottom=63;

}
void reset_to_cylinder()
{
  
    reset_to_sphere();
    
    //top
    for(int j=0;j<16;j++)
    {
      for(int i=0;i<64;i++)
      {    
        //int posi=(j*64)+i;
        //spx[(j*64)+i]=spx[((j-1)*64)+i];
        spy[(j*64)+i]=spy[(16*64)+i];
        //spz[(j*64)+i]=spz[((j-1)*64)+i];
      } 
    }
    
    //bottom
    for(int j=48;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {    
        //int posi=(j*64)+i;
        //spx[(j*64)+i]=spx[((j-1)*64)+i];
        spy[(j*64)+i]=spy[(47*64)+i];
        //spz[(j*64)+i]=spz[((j-1)*64)+i];
      } 
    }
    
    //middle 
    for(int j=16;j<48;j++)
    {
      for(int i=0;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[((j-1)*64)+i];
        //spy[(j*64)+i]=spy[(j*64)+i];
        spz[(j*64)+i]=spz[((j-1)*64)+i];
      } 
    }
generate_scuptxyz(); 
   flat_top=1;
   flat_bottom=63;
}

void stone_pinch_grid() 
{ 
    int xstep=8;
    int ystep=8;
    float mypinch=0.8f;


    if(grid_pincher_type_w==0){xstep=8;}    
    if(grid_pincher_type_w==1){xstep=16;}    
    if(grid_pincher_type_w==2){xstep=32;}
    
    if(grid_pincher_type_h==0){ystep=8;}    
    if(grid_pincher_type_h==1){ystep=16;}    
    if(grid_pincher_type_h==2){ystep=32;}

    for(int j=6;j<58;j=j+ystep)
    {
      for(int i=0;i<64;i=i+xstep)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*mypinch;
        spy[(j*64)+i]=spy[(j*64)+i]*mypinch;
        spz[(j*64)+i]=spz[(j*64)+i]*mypinch;
      } 
    }
    stone_fixtopbottom();
    //generate sculpt image
    generate_scuptxyz(); 
   //getimagedata();
  
}

//    int grid_pincher_type_w=1;    //0,1,2 -- 8,16,32
//int grid_pincher_type_h=1;    //0,1,2 -- 8,16,32
//int grid_extruder_type_w=1;   //0,1,2 -- 8,16,32
//int grid_extruder_type_h=1;   //0,1,2 -- 8,16,32

void stone_extrude_grid() 
{ 
    int xstep=8;
    int ystep=8;

    if(grid_extruder_type_w==0){xstep=8;}    
    if(grid_extruder_type_w==1){xstep=16;}    
    if(grid_extruder_type_w==2){xstep=32;}
    
    if(grid_extruder_type_h==0){ystep=8;}    
    if(grid_extruder_type_h==1){ystep=16;}    
    if(grid_extruder_type_h==2){ystep=32;}

    for(int j=6;j<58;j=j+ystep) //6- 58
    {
      for(int i=0;i<64;i=i+xstep)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=spx[(j*64)+i]*1.40f;
        spy[(j*64)+i]=spy[(j*64)+i]*1.40f;
        spz[(j*64)+i]=spz[(j*64)+i]*1.40f;

      } 
    }
    stone_fixtopbottom();
    //generate sculpt image
    generate_scuptxyz(); 
 //getimagedata();    
}

void stone_fixtopbottom() 
{
   /*
    float topy=spy[((2)*64)];
    for(int j=0;j<2;j++)
    {
      for(int i=0;i<64;i++)
      {
        int posi=(j*64)+i;
        spy[posi]=topy;
      }
    }
    float boty=spy[((61)*64)];
    for(int j=62;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {
        int posi=(j*64)+i;
        spy[posi]=boty;
      }
    }  
    */
    
   
}
void stone_extrude() 
{ 
  for(int ii=0;ii<10;ii++)
  {
    int i=(int)random(64);
    int j=(int)random(62)+1;
    
    int posi=(j*64)+i;
  
    spx[posi]=spx[posi]*2.40f;
    spy[posi]=spy[posi]*2.40f;
    spz[posi]=spz[posi]*2.40f;        
  }  
  stone_fixtopbottom();  
    //generate sculpt image
    generate_scuptxyz(); 
 //getimagedata();    
}
void stone_pinch() 
{
  for(int ii=0;ii<10;ii++)
  {
    int i=(int)random(64);
    int j=(int)random(62)+1;
    
    int posi=(j*64)+i;
  
    spx[posi]=spx[posi]/9.40f;
    spy[posi]=spy[posi]/9.40f;
    spz[posi]=spz[posi]/9.40f;        
  }  
  stone_fixtopbottom();  
    //generate sculpt image
    generate_scuptxyz(); 
}
      
void stone_random() 
{  
    //randomize a bit - dont touch top and bottom closing ring
    for(int j=1;j<64-1;j++)
    {
      for(int i=0;i<64;i++)
      {
        int posi=(j*64)+i;
        float xr=(random(8)-4)/10.0f;
        float yr=(random(8)-4)/10.0f;
        float zr=(random(8)-4)/10.0f;
        spx[posi]=spx[posi]+xr;
        spy[posi]=spy[posi]+yr;
        spz[posi]=spz[posi]+zr;        
      }
    }
  stone_fixtopbottom();  
       //generate sculpt image
    generate_scuptxyz();
}

void stone_random2() 
{  
    //randomize a bit - dont touch top and bottom closing ring
    for(int j=1;j<64-1;j++)
    {
      for(int i=0;i<64;i++)
      {
        int posi=(j*64)+i;
        float xr=(random(28)-14)/1.0f;
        float yr=(random(28)-14)/1.0f;
        float zr=(random(28)-14)/1.0f;
        spx[posi]=spx[posi]+xr;
        spy[posi]=spy[posi]+yr;
        spz[posi]=spz[posi]+zr;        
      }
    }
  stone_fixtopbottom();  
       //generate sculpt image
    generate_scuptxyz();
     //getimagedata();
}

void stone_smooth() 
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

   //smooth around -- top line
   for(int j=0;j<1;j++)
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

        spx[(j*64)+i]=(x0+x1+x2+x3)/4.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3)/4.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3)/4.0f;     
      }
    }
    //top leftpoint
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

    //top rightpoint
    nx0=spxbuf[(0*64)+63];
    ny0=spybuf[(0*64)+63];
    nz0=spzbuf[(0*64)+63];
        
    nx1=spxbuf[(0*64)+0];
    ny1=spybuf[(0*64)+0];
    nz1=spzbuf[(0*64)+0];
        
    nx2=spxbuf[(0*64)+62];
    ny2=spybuf[(0*64)+62];
    nz2=spzbuf[(0*64)+62];
        
    nx3=spxbuf[((0+1)*64)+63];
    ny3=spybuf[((0+1)*64)+63];
    nz3=spzbuf[((0+1)*64)+63];
        
    spx[(0*64)+63]=(nx0+nx1+nx2+nx3)/4.0f;
    spy[(0*64)+63]=(ny0+ny1+ny2+ny3)/4.0f;
    spz[(0*64)+63]=(nz0+nz1+nz2+nz3)/4.0f;     

   //smooth around -- bottom line
   for(int j=63;j<64;j++)
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
        
        float x3=spxbuf[((j-1)*64)+i];
        float y3=spybuf[((j-1)*64)+i];
        float z3=spzbuf[((j-1)*64)+i];

        spx[(j*64)+i]=(x0+x1+x2+x3)/4.0f;
        spy[(j*64)+i]=(y0+y1+y2+y3)/4.0f;
        spz[(j*64)+i]=(z0+z1+z2+z3)/4.0f;     
      }
    }
    //bottom leftpoint
    nx0=spxbuf[(63*64)+0];
    ny0=spybuf[(63*64)+0];
    nz0=spzbuf[(63*64)+0];
        
    nx1=spxbuf[(63*64)+0+1];
    ny1=spybuf[(63*64)+0+1];
    nz1=spzbuf[(63*64)+0+1];
        
    nx2=spxbuf[(63*64)+63];
    ny2=spybuf[(63*64)+63];
    nz2=spzbuf[(63*64)+63];
        
    nx3=spxbuf[((62)*64)+0];
    ny3=spybuf[((62)*64)+0];
    nz3=spzbuf[((62)*64)+0];
        
    spx[(63*64)+0]=(nx0+nx1+nx2+nx3)/4.0f;
    spy[(63*64)+0]=(ny0+ny1+ny2+ny3)/4.0f;
    spz[(63*64)+0]=(nz0+nz1+nz2+nz3)/4.0f;     

    //bottom rightpoint
    nx0=spxbuf[(63*64)+63];
    ny0=spybuf[(63*64)+63];
    nz0=spzbuf[(63*64)+63];
        
    nx1=spxbuf[(63*64)+0];
    ny1=spybuf[(63*64)+0];
    nz1=spzbuf[(63*64)+0];
        
    nx2=spxbuf[(63*64)+62];
    ny2=spybuf[(63*64)+62];
    nz2=spzbuf[(63*64)+62];
        
    nx3=spxbuf[((62)*64)+63];
    ny3=spybuf[((62)*64)+63];
    nz3=spzbuf[((62)*64)+63];
        
    spx[(63*64)+63]=(nx0+nx1+nx2+nx3)/4.0f;
    spy[(63*64)+63]=(ny0+ny1+ny2+ny3)/4.0f;
    spz[(63*64)+63]=(nz0+nz1+nz2+nz3)/4.0f;     
    
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
    
    /*
  //stone_fixtopbottom();  
  float tempx1=(spx[(0*64)+0]+spx[(0*64)+32])/2.0f;
  float tempy1=(spy[(0*64)+0]+spy[(0*64)+32])/2.0f;
  float tempz1=(spz[(0*64)+0]+spz[(0*64)+32])/2.0f;

  float tempx2=(spx[(63*64)+0]+spx[(63*64)+32])/2.0f;
  float tempy2=(spy[(63*64)+0]+spy[(63*64)+32])/2.0f;
  float tempz2=(spz[(63*64)+0]+spz[(63*64)+32])/2.0f;
  

  for(int j=0;j<2;j++)
  {
    for(int i=0;i<64;i++)
    {
        spx[(j*64)+i]=spx[(j*64)+i]-tempx1;        
        spy[(j*64)+i]=spy[(j*64)+i]-tempy1;        
        spz[(j*64)+i]=spz[(j*64)+i]-tempz1;        
    }
  }   
  for(int j=62;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {
        spx[(j*64)+i]=spx[(j*64)+i]-tempx2;        
        spy[(j*64)+i]=spy[(j*64)+i]-tempy2;        
        spz[(j*64)+i]=spz[(j*64)+i]-tempz2;        
    }
  }   
  scale_ring2xz(0, 0.0000009f,0);
  scale_ring2xz(62, 0.000009f,0);
  for(int j=0;j<2;j++)
  {
    for(int i=0;i<64;i++)
    {
        spx[(j*64)+i]=spx[(j*64)+i]+tempx1;        
        spy[(j*64)+i]=spy[(j*64)+i]+tempy1;        
        spz[(j*64)+i]=spz[(j*64)+i]+tempz1;        
    }
  }   
  for(int j=62;j<64;j++)
  {
    for(int i=0;i<64;i++)
    {
        spx[(j*64)+i]=spx[(j*64)+i]+tempx2;        
        spy[(j*64)+i]=spy[(j*64)+i]+tempy2;        
        spz[(j*64)+i]=spz[(j*64)+i]+tempz2;        
    }
  }   
  */
  
  
  // scale top and bottom rings small
  int temp1=arch_rotscalearound;
  arch_rotscalearound=1; //scale around ring
  
  scale_ring2xz(0, 0.000009f,0);
  scale_ring2y(0, 0.000009f,0);

  scale_ring2xz(62, 0.000009f,0);
  scale_ring2y(62, 0.000009f,0);
  
  arch_rotscalearound=temp1;
  
    //generate sculpt image
    generate_scuptxyz();
   // getimagedata();
}


void stone_smooth_plane() 
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
   
    
    //generate sculpt image
    generate_scuptxyz();
   // getimagedata();
}
void reset_to_torus()
{
  gridflat= loadImage("data/grid.png");
  b = loadImage("data/torus.png");
  getimagedata();      // redraw the 3D object
  rendertype=2;
  stone_smooth_torus();
  stone_smooth_torus();
  generate_scuptxyz();
}
void stone_smooth_torus() 
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
  
   //top line
   for(int j=0;j<1;j++)
   {
      for(int i=1;i<64-1;i++)
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
   //bottom line
   for(int j=63;j<64;j++)
   {
      for(int i=1;i<64-1;i++)
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

    
    spx[0]=(x0+x1+x2+x4+x5)/5.0f; //top left
    spy[0]=(y0+y1+y2+y4+y5)/5.0f;
    spz[0]=(z0+z1+z2+z4+z5)/5.0f; 
    
    spx[63]=(x0+x1+x3+x6+x7)/5.0f; //top right
    spy[63]=(y0+y1+y3+y6+y7)/5.0f;
    spz[63]=(z0+z1+z3+z6+z7)/5.0f; 
    
    spx[(63*64)]=(x0+x2+x3+x8+x9)/5.0f; //bottom left
    spy[(63*64)]=(y0+y2+y3+y8+y9)/5.0f;
    spz[(63*64)]=(z0+z2+z3+z8+z9)/5.0f;
    
    spx[(63*64)+63]=(x1+x2+x3+x10+x11)/5.0f; //bottom left
    spy[(63*64)+63]=(y1+y2+y3+y10+y11)/5.0f;
    spz[(63*64)+63]=(z1+z2+z3+z10+z11)/5.0f;
  
    
    
    //generate sculpt image
    generate_scuptxyz();
   // getimagedata();
}    

void stone_forceto32sl() //smoothed
{
  
  b.loadPixels();
  //int lastj=0;
  for (int j=0;j<62;j=j+2)
  {
    for (int i=0;i<63;i=i+2)
    {
      int r1= ((b.pixels[(j*64)+i] >> 16) & 0xff);
      int g1= ((b.pixels[(j*64)+i] >> 8) & 0xff);
      int b1= ((b.pixels[(j*64)+i]  ) & 0xff);
      
      int r2= ((b.pixels[(j*64)+i+1] >> 16) & 0xff);
      int g2= ((b.pixels[(j*64)+i+1] >> 8) & 0xff);
      int b2= ((b.pixels[(j*64)+i+1]  ) & 0xff);

      int r3= ((b.pixels[((j+1)*64)+i] >> 16) & 0xff);
      int g3= ((b.pixels[((j+1)*64)+i] >> 8) & 0xff);
      int b3= ((b.pixels[((j+1)*64)+i]  ) & 0xff);

      int r4= ((b.pixels[((j+1)*64)+i+1] >> 16) & 0xff);
      int g4= ((b.pixels[((j+1)*64)+i+1] >> 8) & 0xff);
      int b4= ((b.pixels[((j+1)*64)+i+1]  ) & 0xff);

      int r5= (r1+r2+r3+r4)/4;
      int g5= (g1+g2+g3+g4)/4;
      int b5= (b1+b2+b3+b4)/4;
      
      drawpoint( b.pixels,  i,j, 64,     r5, g5, b5);
      drawpoint( b.pixels,  i+1,j, 64,   r5, g5, b5);
      drawpoint( b.pixels,  i,j+1, 64,   r5, g5, b5);
      drawpoint( b.pixels,  i+1,j+1, 64, r5, g5, b5);
    }
    //lastj=j+1;
  }
  //fix bottom 2rows
  for (int j=62;j<64;j++)
  {
    for (int i=0;i<63;i=i+2)
    {
      int r1= ((b.pixels[(j*64)+i] >> 16) & 0xff);
      int g1= ((b.pixels[(j*64)+i] >> 8) & 0xff);
      int b1= ((b.pixels[(j*64)+i]  ) & 0xff);
      
      int r2= ((b.pixels[(j*64)+i+1] >> 16) & 0xff);
      int g2= ((b.pixels[(j*64)+i+1] >> 8) & 0xff);
      int b2= ((b.pixels[(j*64)+i+1]  ) & 0xff);
      
      int r3=(r1+r2)/2;
      int g3=(g1+g2)/2;
      int b3=(b1+b2)/2;
      
      drawpoint( b.pixels,  i,j, 64,   r3, g3, b3);
      drawpoint( b.pixels,  i+1,j, 64, r3, g3, b3);
    }
    //lastj=j;
  }
  
  //println(lastj);
  
  b.updatePixels();
  getimagedata();
  generate_scuptxyz();

}

void stone_forceto32slhard() //hard
{  
  b.loadPixels();
  for (int j=0;j<62;j=j+2)
  {
    for (int i=0;i<63;i=i+2)
    {
      int r1= ((b.pixels[(j*64)+i] >> 16) & 0xff);
      int g1= ((b.pixels[(j*64)+i] >> 8) & 0xff);
      int b1= ((b.pixels[(j*64)+i]  ) & 0xff);
            
      drawpoint( b.pixels,  i+1,j, 64,   r1, g1, b1);
      drawpoint( b.pixels,  i,j+1, 64,   r1, g1, b1);
      drawpoint( b.pixels,  i+1,j+1, 64, r1, g1, b1);
    }
  }
  //fix bottom 2rows
  for (int j=62;j<64;j++)
  {
    for (int i=0;i<63;i=i+2)
    {
      int r1= ((b.pixels[(j*64)+i] >> 16) & 0xff);
      int g1= ((b.pixels[(j*64)+i] >> 8) & 0xff);
      int b1= ((b.pixels[(j*64)+i]  ) & 0xff);
      drawpoint( b.pixels,  i+1,j, 64, r1, g1, b1);
    }
  }  
  b.updatePixels();
  getimagedata();
  generate_scuptxyz();
}
