//tool_rgb_layers


//----------------------------------------------------------------------------------------------------------------------------------
//--------------------------------RGB layers tool - Sliding the pictures red green and blue-----------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
//-- Red sliders
void slide_redup()
{  
  temp64.loadPixels();
  for (int j=1;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int r= ((smallr.pixels[(j*64)+i] >> 16) & 0xff);
     drawpoint( temp64.pixels,  i,j-1, 64,   r, 0, 0);
    }
  }
  for (int i=0,j=63;i<64;i++)
  {
    int r= ((smallr.pixels[i] >> 16) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   r, 0, 0); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  smallr.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallr.updatePixels();
  
  update_bigred();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_reddown()
{  
  temp64.loadPixels();
  for (int j=0;j<63;j++)
  {
    for (int i=0;i<64;i++)
    {
      int r= ((smallr.pixels[(j*64)+i] >> 16) & 0xff);
     drawpoint( temp64.pixels,  i,j+1, 64,   r, 0, 0);
    }
  }
  for (int i=0,j=63;i<64;i++)
  {
    int r= ((smallr.pixels[(j*64)+i] >> 16) & 0xff);
    drawpoint( temp64.pixels,  i,0, 64,   r, 0, 0); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  smallr.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallr.updatePixels();
  
  update_bigred();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_redleft()
{
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=1;i<64;i++)
    {
      int r= ((smallr.pixels[(j*64)+i] >> 16) & 0xff);
     drawpoint( temp64.pixels,  i-1,j, 64,   r, 0, 0);
    }
  }
  for (int j=0,i=63;j<64;j++)
  {
    int r= ((smallr.pixels[(j*64)+0] >> 16) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   r, 0, 0); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  //smallr.loadPixels();
  smallr.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallr.updatePixels();
  
  update_bigred();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_redright()
{
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<63;i++)
    {
      int r= ((smallr.pixels[(j*64)+i] >> 16) & 0xff);
     drawpoint( temp64.pixels,  i+1,j, 64,   r, 0, 0);
    }
  }
  for (int j=0,i=0;j<64;j++)
  {
    int r= ((smallr.pixels[(j*64)+63] >> 16) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   r, 0, 0); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  //smallr.loadPixels();
  smallr.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallr.updatePixels();
  
  update_bigred();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}


//--Green  sliders
void slide_greenup()
{ 
  temp64.loadPixels();
  for (int j=1;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int g= ((smallg.pixels[(j*64)+i] >> 8) & 0xff);
      drawpoint( temp64.pixels,  i,j-1, 64, 0, g, 0);
    }
  }
  
  for (int i=0,j=63;i<64;i++)
  {
    int g= ((smallg.pixels[i] >> 8) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   0, g, 0); 
  }
  temp64.updatePixels();
  
  //copy area back to green
  smallg.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallg.updatePixels();
  
  update_biggreen();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_greendown()
{  
  temp64.loadPixels();
  for (int j=0;j<63;j++)
  {
    for (int i=0;i<64;i++)
    {
      int g= ((smallg.pixels[(j*64)+i] >> 8) & 0xff);
     drawpoint( temp64.pixels,  i,j+1, 64,   0, g, 0);
    }
  }
  for (int i=0,j=63;i<64;i++)
  {
    int g= ((smallg.pixels[(j*64)+i] >> 8) & 0xff);
    drawpoint( temp64.pixels,  i,0, 64,   0, g, 0); 
  }
  
  temp64.updatePixels();
  
  //copy area back to red
  smallg.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallg.updatePixels();
  
  update_biggreen();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_greenleft()
{
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=1;i<64;i++)
    {
      int g= ((smallg.pixels[(j*64)+i] >> 8) & 0xff);
      drawpoint( temp64.pixels,  i-1,j, 64, 0, g, 0);
    }
  }
  for (int j=0,i=63;j<64;j++)
  {
    int g= ((smallg.pixels[(j*64)+0] >> 8) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   0, g, 0); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  //smallr.loadPixels();
  smallg.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallg.updatePixels();
  
  update_biggreen();   // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_greenright()
{
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<63;i++)
    {
      int g= ((smallg.pixels[(j*64)+i] >> 8) & 0xff);
     drawpoint( temp64.pixels,  i+1,j, 64,   0, g, 0);
    }
  }
  for (int j=0,i=0;j<64;j++)
  {
    int g= ((smallg.pixels[(j*64)+63] >> 8) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   0, g, 0); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  //smallr.loadPixels();
  smallg.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallg.updatePixels();
  
  update_biggreen();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}


//--Blue sliders
void slide_blueup()
{ 
  temp64.loadPixels();
  for (int j=1;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int b= ((smallb.pixels[(j*64)+i]  ) & 0xff);
      drawpoint( temp64.pixels,  i,j-1, 64, 0, 0, b);
    }
  }
  
  for (int i=0,j=63;i<64;i++)
  {
    int b= ((smallb.pixels[i]    ) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   0, 0, b); 
  }
  temp64.updatePixels();
  
  //copy area back to green
  smallb.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallb.updatePixels();
  
  update_bigblue();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_bluedown()
{  
  temp64.loadPixels();
  for (int j=0;j<63;j++)
  {
    for (int i=0;i<64;i++)
    {
      int b= ((smallb.pixels[(j*64)+i]  ) & 0xff);
     drawpoint( temp64.pixels,  i,j+1, 64,   0, 0, b);
    }
  }
  for (int i=0,j=63;i<64;i++)
  {
    int b= ((smallb.pixels[(j*64)+i]  ) & 0xff);
    drawpoint( temp64.pixels,  i,0, 64,   0, 0, b); 
  }
  
  temp64.updatePixels();
  
  //copy area back to red
  smallb.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallb.updatePixels();
  
  update_bigblue();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_blueleft()
{
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=1;i<64;i++)
    {
      int b= ((smallb.pixels[(j*64)+i]  ) & 0xff);
      drawpoint( temp64.pixels,  i-1,j, 64, 0, 0, b);
    }
  }
  for (int j=0,i=63;j<64;j++)
  {
    int b= ((smallb.pixels[(j*64)+0] ) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   0, 0, b); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  //smallr.loadPixels();
  smallb.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallb.updatePixels();
  
  update_bigblue();   // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}

void slide_blueright()
{
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<63;i++)
    {
      int b= ((smallb.pixels[(j*64)+i]  ) & 0xff);
     drawpoint( temp64.pixels,  i+1,j, 64,   0, 0, b);
    }
  }
  for (int j=0,i=0;j<64;j++)
  {
    int b= ((smallb.pixels[(j*64)+63]  ) & 0xff);
    drawpoint( temp64.pixels,  i,j, 64,   0, 0, b); 
  }
  temp64.updatePixels();
  
  //copy area back to red
  //smallr.loadPixels();
  smallb.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  smallb.updatePixels();
  
  update_bigblue();     // update the big one
  redrawsculptmap();   // redraw sculptmap
  getimagedata();      // redraw the 3D object
}




//-------------------------------------------------
// Create the new sculptmap after change or painting
void redrawsculptmap()
{
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int r= ((smallr.pixels[(j*64)+i] >> 16) & 0xff);
      int g= ((smallg.pixels[(j*64)+i] >> 8) & 0xff);
      int b= ((smallb.pixels[(j*64)+i]  ) & 0xff);
      drawpoint( temp64.pixels,  i,j, 64, r, g, b);
    }
  }
  temp64.updatePixels(); 
  b.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);  // update the new sculpt image
  b.updatePixels();
}


//---------------------------------
void update_bigred()
{
  //update big red layer
  bigr.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int r= ((smallr.pixels[(j*64)+i] >> 16) & 0xff);
      drawpoint4( bigr.pixels,  i*4,j*4, 256, r, 0, 0);
    }
  }
  bigr.updatePixels();
}
void update_biggreen()
{
  //update big green layer
  bigg.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int g= ((smallg.pixels[(j*64)+i] >> 8) & 0xff);
      drawpoint4( bigg.pixels,  i*4,j*4, 256, 0, g, 0);
    }
  }
  bigg.updatePixels();
}

void update_bigblue()
{
  //update big blue layer
  bigb.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int b= ((smallb.pixels[(j*64)+i]  ) & 0xff);
      drawpoint4( bigb.pixels,  i*4,j*4, 256, 0, 0, b);
    }
  }
  bigb.updatePixels();
}

void layersredgreenblue()
{
  
  //update small red layer - 
  smallr.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
     drawpoint( smallr.pixels,  i,j, 64,   sculptr[(j*sculptsize)+i], 0, 0);
    }
  }    
  smallr.updatePixels();
  
  //update small green layer  
  smallg.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
     drawpoint( smallg.pixels,  i,j, 64,   0, sculptg[(j*sculptsize)+i], 0);
    }
  }    
  smallg.updatePixels();

  //update small red layer - 
  smallb.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
     drawpoint( smallb.pixels,  i,j, 64,   0, 0, sculptb[(j*sculptsize)+i]);
    }
  }    
  smallb.updatePixels();

  update_bigred();
  update_biggreen();
  update_bigblue();

}
