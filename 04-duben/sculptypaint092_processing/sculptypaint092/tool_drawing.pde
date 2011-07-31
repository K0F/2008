// tool_drawing


//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------drawing tool------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
void selectdrawrgb()
{
    paintmode=0;  
    getimagedata();        
    layersredgreenblue();
    selectdrawingtool();         
}


// Draw height
void scaleringxz(int ring, float scalerz)
{
    int locky=1;
    if(lockselector==0){locky=1;}
    if(lockselector==1){locky=4;}
    if(lockselector==2){locky=8;}
    if(lockselector==3){locky=16;}
    if(lockselector==4){locky=32;}
    
    for (int i=0;i<64;i=i+locky)
    {
      spy[(ring*64)+i]=scalerz;  // 0 -  80      
    }
    selectdrawingtool_height();
    generate_scuptxyz(); //generate the new sculpt image  
}
//---------------------------------------------------------------------------------------------------------------------------------------------
//when drawing height
void selectdrawingtool_height() 
{
  //find the min and max points  
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {      
      float tx =  spx[(j*64)+i];
      float ty =  spy[(j*64)+i];
      float tz =  spz[(j*64)+i];
      if(tx<minx){minx=tx;}
      if(ty<miny){miny=ty;}
      if(tz<minz){minz=tz;}
      if(tx>maxx){maxx=tx;}
      if(ty>maxy){maxy=ty;}
      if(tz>maxz){maxz=tz;}
    }
  }  
  sizex=maxx-minx; 
  sizey=maxy-miny; 
  sizez=maxz-minz;
  
  //clear the drawing canvas
  draw512.loadPixels();  
  draw512.copy(draw512buffer, 0, 0, 512, 512, 0, 0, 512, 512);

  for (int j=0,i=0;j<63;j++) //Draw lines
  {
      float siz=510.0;
      float tx=  (spy[(j*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty=  (j*8)+4;      
      int xx=  (int) tx;
      int yy=  (int) ty;
      float tx2=  (spy[((j+1)*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty2=  ((j+1)*8)+4;     
      int xx2=  (int) tx2;
      int yy2=  (int) ty2;
      gline1(draw512.pixels, xx, yy, xx2, yy2, 512, 0, 100, 100);
  }
  
  for (int j=0,i=0;j<64;j++) //draw points
  {
      float siz=510.0;
      float tx=  (spy[(j*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty=  (j*8)+4;         
      int xx=  (int) tx;
      int yy=  (int) ty;
      drawpoint2( draw512.pixels,  xx,yy, 512, 255, 255, 255); // xy
      drawpoint2( draw512.pixels,  xx+1,yy, 512, 255, 255, 255); // xy
      drawpoint2( draw512.pixels,  xx,yy+1, 512, 255, 255, 255); // xy
      drawpoint2( draw512.pixels,  xx+1,yy+1, 512, 255, 255, 255); // xy
  }
  draw512.updatePixels();
}



//draw width
void scaleringxy(int ring, float scalerz)
{
    int locky=1;
    if(lockselector==0){locky=1;}
    if(lockselector==1){locky=4;}
    if(lockselector==2){locky=8;}
    if(lockselector==3){locky=16;}
    if(lockselector==4){locky=32;}

    for (int i=0;i<64;i=i+locky)//4, 8, 16, 32 
    {
      spx[(ring*64)+i]=cosd[i]*scalerz;  // 0 -  80
      spz[(ring*64)+i]=sind[i]*scalerz;      
    }
    selectdrawingtool();
    generate_scuptxyz(); //generate the new sculpt image  
}


//when drawing width
void selectdrawingtool()
{
  //find the min and max points  
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {      
      float tx =  spx[(j*64)+i];
      float ty =  spy[(j*64)+i];
      float tz =  spz[(j*64)+i];
      if(tx<minx){minx=tx;}
      if(ty<miny){miny=ty;}
      if(tz<minz){minz=tz;}
      if(tx>maxx){maxx=tx;}
      if(ty>maxy){maxy=ty;}
      if(tz>maxz){maxz=tz;}
    }
  }
  
  sizex=maxx-minx; // 85
  sizey=maxy-miny; 
  sizez=maxz-minz;

  //clear the drawing canvas
  draw512.loadPixels();  
  draw512.copy(draw512buffer, 0, 0, 512, 512, 0, 0, 512, 512);
  

  for (int j=0,i=0;j<63;j++) //Draw lines
  {
      float siz=510.0;
      float tx=  (spx[(j*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty=  (j*8)+4;      
      int xx=  (int) tx;
      int yy=  (int) ty;
      float tx2=  (spx[((j+1)*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty2=  ((j+1)*8)+4;     
      int xx2=  (int) tx2;
      int yy2=  (int) ty2;
      gline1(draw512.pixels, xx, yy, xx2, yy2, 512, 0, 100, 100);
  }
  
  for (int j=0,i=32;j<63;j++) //Draw lines mirrored
  {
      float siz=510.0;
      float tx=  (spx[(j*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty=  (j*8)+4;      
      int xx=  (int) tx;
      int yy=  (int) ty;
      float tx2=  (spx[((j+1)*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty2=  ((j+1)*8)+4;     
      int xx2=  (int) tx2;
      int yy2=  (int) ty2;
      gline1(draw512.pixels, xx, yy, xx2, yy2, 512, 0, 100, 100);
  }

  for (int j=0,i=0;j<64;j++) //draw points
  {
      float siz=510.0;
      float tx=  (spx[(j*64)+i]-minx)*(siz/sizex);  // 0 -  80
      float ty=  (j*8)+4;         
      int xx=  (int) tx;
      int yy=  (int) ty;
      drawpoint2( draw512.pixels,  xx,yy, 512, 255, 255, 255); // xy
      drawpoint2( draw512.pixels,  xx+1,yy, 512, 255, 255, 255); // xy
      drawpoint2( draw512.pixels,  xx,yy+1, 512, 255, 255, 255); // xy
      drawpoint2( draw512.pixels,  xx+1,yy+1, 512, 255, 255, 255); // xy
  }
  draw512.updatePixels();
}

