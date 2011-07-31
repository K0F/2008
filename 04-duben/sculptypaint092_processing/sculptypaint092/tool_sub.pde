// tool_sub
void selectsubtool()
{

}

void sub_clearcopybuff()
{
  for(int j=0;j<32;j++)
  {
    for(int i=0;i<32;i++)
    {
      sub_copybuf[(j*32)+i]=0;
    }
  }         
}

void sub_clearpastebuff()
{
  for(int j=0;j<32;j++)
  {
    for(int i=0;i<32;i++)
    {
      sub_pastebuf[(j*32)+i]=0;
    }
  }         
}

void sub_getpastebuff()
{
  b.copy(sub_pasteimage, 0, 0, 64, 64, 0, 0, 64, 64);
  b.updatePixels();
  getimagedata();
  generate_scuptxyz();
}

void sub_copytopastebuff()
{  
  //check copybuff
  int wc_x=-1; //width
  int wc_y=-1; //height
  int c_x1=-1;
  int c_y1=-1;  
  int c_x2=-1;
  int c_y2=-1;  
  for(int j=0;j<32;j++) //find min and max selected points in copybuff
  {
    for(int i=0;i<32;i++)
    {
        if(sub_copybuf[(j*32)+i]==1)
        {
          if(c_x1==-1){c_x1=i;}
          if(c_y1==-1){c_y1=j;}
          if(c_x2<i){c_x2=i;}
          if(c_y2<j){c_y2=j;}          
        }        
    }
  }
  wc_x=c_x2-c_x1;
  wc_y=c_y2-c_y1;
  
  //check pastebuff
  int wp_x=-1; //width
  int wp_y=-1; //height
  int p_x1=-1;
  int p_y1=-1;  
  int p_x2=-1;
  int p_y2=-1;  
  for(int j=0;j<32;j++) //find min and max selected points in copybuff
  {
    for(int i=0;i<32;i++)
    {
        if(sub_pastebuf[(j*32)+i]==1)
        {
          if(p_x1==-1){p_x1=i;}
          if(p_y1==-1){p_y1=j;}
          if(p_x2<i){p_x2=i;}
          if(p_y2<j){p_y2=j;}          
        }        
    }
  }
  wp_x=p_x2-p_x1;
  wp_y=p_y2-p_y1;


  if(c_x1==-1 && p_x1==-1) //do nothing if none selected
  {
   warningfade=1;
   warningtext="select points in the Copy and Paste buffer";
  }
  if(c_x1==-1 && p_x1!=-1) //do nothing if none selected
  {
   warningfade=1;
   warningtext="select points in the Copy buffer";
  }
  if(c_x1!=-1 && p_x1==-1) //do nothing if none selected
  {
   warningfade=1;
   warningtext="select points in the Paste buffer";
  }
  
  if(c_x1!=-1 && p_x1!=-1) //both point in copy and paste buffer selected
  {
    
    //same width and height in copy and paste buffer
    if(wc_x==wp_x && wc_y==wp_y)//same width and height in copy and paste buffer
    {
      for(int j=c_y1;j<c_y2+1;j++) //find min and max selected points in copybuff
      {
        for(int i=c_x1;i<c_x2+1;i++)
        {
          if(sub_copybuf[(j*32)+i]==1) //check if copybuff really selected?
          {
            if(sub_pastebuf[( ((j-c_y1)+p_y1) *32)+((i-c_x1)+p_x1)]==1) //check if pastebuff really selected?
            {            
              sub_pasteimage.pixels[(( ((j-c_y1)+p_y1) *2)*64)+( ((i-c_x1)+p_x1) *2)] =  b.pixels[((j*2)*64)+(i*2)];//( (0xff<<24) | (0<<16) | (g<<8) | 0);                    
              sub_pasteimage.pixels[((( ((j-c_y1)+p_y1) *2)+1)*64)+( ((i-c_x1)+p_x1) *2)] =  b.pixels[(((j*2)+1)*64)+(i*2)];//( (0xff<<24) | (0<<16) | (g<<8) | 0);                    
              sub_pasteimage.pixels[(( ((j-c_y1)+p_y1) *2)*64)+(( ((i-c_x1)+p_x1) *2)+1)] =  b.pixels[((j*2)*64)+((i*2)+1)];//( (0xff<<24) | (0<<16) | (g<<8) | 0);                    
              sub_pasteimage.pixels[((( ((j-c_y1)+p_y1) *2)+1)*64)+( (((i-c_x1)+p_x1) *2)+1)] =  b.pixels[(((j*2)+1)*64)+((i*2)+1)];//( (0xff<<24) | (0<<16) | (g<<8) | 0);                    
            }
          }          
        }
      }
      sub_pasteimage.updatePixels();
    }//end same width/height
    else if(wc_x==wp_x && wc_y>wp_y)// y in paste buffer smaller
    {
      //for(int j=c_y1;j<c_y2+1;j++) //find min and max selected points in copybuff
      //{
     // }
      
    }
    else
    {
     warningfade=1;
     warningtext="Select the same width & height in the copy and paste buffer (For the moment)";      
    }    
    //width same, height copy bigger then paste
//    if(wc_x==wp_x && wc_y>wp_y)
//    {
      
//      println("height copy bigger then paste");
//    }    
   // println("copy - x1: "+c_x1+" y1: "+c_y1+" x2: "+c_x2+" y2: "+c_y2+" w: " + wc_x+" h: "+ wc_y);
   // println("paste - x1: "+p_x1+" y1: "+p_y1+" x2: "+p_x2+" y2: "+p_y2+" w: " + wp_x+" h: "+ wp_y);    
  }
  
  
  
  
}


