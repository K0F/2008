// piper tool  testzone - not in use really atm
void selectpipertool()
{
    piper_drawimage.loadPixels();

    for(int j=0;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {
        int rr= ((b.pixels[(j*64)+i] >> 16) & 0xff);
        int gg= ((b.pixels[(j*64)+i] >> 8) & 0xff);
        int bb= ((b.pixels[(j*64)+i]  ) & 0xff);
        drawpoint( piper_drawimage.pixels,  rr, gg, 256,   255,255, 0);
        drawpoint( piper_drawimage.pixels,  rr, bb, 256,   255, 0, 255);
        drawpoint( piper_drawimage.pixels,  gg, bb, 256,   0, 255, 255);
      }
    }
    
    piper_drawimage.updatePixels();
}

void piper_checkmousepoints()
{
  //mouse pos 0-255
  //find closest point

    int tempx=mx-696;
    int tempy=my-8;  
    float nox=0;
    float noy=0;
    int whatpoint=-1;
    float tempdistance=1000.0f;
    
    piper_drawimage.copy(piper_backgroundimage, 0, 0, 256, 256, 0, 0, 256, 256);
    
    if(pipe_clickstatus==0)
    {    
      for (int i=0;i<32;i++)
      {
        if(tempx<=pipe_x[i]){nox=pipe_x[i]-tempx;}
        if(tempx>=pipe_x[i]){nox=tempx-pipe_x[i];}
        if(tempy<=pipe_y[i]){noy=pipe_y[i]-tempy;}
        if(tempy>=pipe_y[i]){noy=tempy-pipe_y[i];}
        float distance=sqrt((nox*nox)+(noy*noy));
        if (distance<tempdistance){whatpoint=i; tempdistance=distance;}
      }
      if (whatpoint!=-1)
      {
        pipe_whatpoint=whatpoint;
        //println("pointer"+ pipe_whatpoint);
      }
    }
    if(pipe_clickstatus==1)
    {
      if(pipe_xyzstatus[pipe_whatpoint]==0){pipe_xyzstatus[pipe_whatpoint]=1;} //0=follow 1=move 2=locked
      
      pipe_x[pipe_whatpoint]=mx-696;
      pipe_y[pipe_whatpoint]=my-8;
      piper_redrawpoints();
    }    
}

void piper_redrawpoints()
{
  
    
  
    piper_drawimage.copy(piper_backgroundimage, 0, 0, 256, 256, 0, 0, 256, 256);
    piper_drawimage.loadPixels();
    for(int i=0,r=0,g=0,b=0;i<32;i++)
    {
      if(pipe_xyzstatus[i]==0){   r=0;   g=255;   b=255;}
      if(pipe_xyzstatus[i]==1){ r=255;   g=255;   b=0;}
      if(pipe_xyzstatus[i]==2){ r=255;   g=0;   b=0;}            
      drawpoint( piper_drawimage.pixels,   pipe_x[i],pipe_y[i], 256,   r, g, b);
    }
    piper_drawimage.updatePixels();
  
}
