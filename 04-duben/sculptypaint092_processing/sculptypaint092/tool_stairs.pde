// tool_stairs
//----------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------Stairs tool----------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
void selectstairstool()
{

  
}

void reset_to_stairscube()
{

  tempload = loadImage("data/sculpt_newstairscube_12.png");
  b.copy(tempload, 0, 0, tempload.width, tempload.height, 0, 0, 64, 64);
  getimagedata();      // redraw the 3D object
  generate_scuptxyz();
}

void incdec_stairs(int inkie)
{
//incdec_stairs(-1);


    //48 - 12*4
    //4 8 
    //int stairtype=8;
    //int stairmax=12;
    //int stairoffset=11;
    int inc_or_dec=inkie;
        
    if (stairtype==4){stairmax=15;}
    if (stairtype==8){stairmax=7;}
    if (stairtype==16){stairtype=12;stairmax=5;}
    //stairtype=16;
    //stairmax=3;
    
    int counter=0;
    int laststair=0;
    for(int jj=0;jj<stairmax;jj++) //0-10
    {  
      counter++;
      for(int j=3+(jj*stairtype);j<3+stairtype+(jj*stairtype);j++)//start at 6 step 4
      {
        for(int i=0;i<64;i++)
        {    
          spz[(j*64)+i]=spz[(j*64)+i]-(jj*inc_or_dec);
        }
        laststair=j;
      }
    }
    
    println("--- "+laststair);
    //fix bottom
    if (stairtype==4 || stairtype==12)
    {
      for(int j=63;j<64;j++)
      {
        for(int i=0;i<64;i++)
        {    
          spz[(j*64)+i]=spz[(62*64)+i];
        }        
      }
    }
    //fix bottom
    if (stairtype==8)
    {
      for(int j=59;j<64;j++)
      {
        for(int i=0;i<64;i++)
        {    
          spz[(j*64)+i]=spz[(58*64)+i];
          spy[(j*64)+i]=spy[(58*64)+i];
        }        
      }      
    }
    /*
    
    for(int jj=0;jj<stairmax;jj++)
    {  
      counter++;
      for(int j=8+(jj*stairtype);j<8+stairtype+(jj*stairtype);j++)
      {
        for(int i=0;i<64;i++)
        {    
          spz[(j*64)+i]=spz[(j*64)+i]-(jj*inc_or_dec);
        } 
      }
    }    
    //fix bottom
    if(inc_or_dec==1)
    {
      for(int j=56;j<64;j++)
      {
        for(int i=0;i<64;i++)
        {    
          spz[(j*64)+i]=spz[(j*64)+i]-counter+1;//+inc_or_dec;
        } 
      }
    }
    if(inc_or_dec==-1)
    {
      for(int j=56;j<64;j++)
      {
        for(int i=0;i<64;i++)
        {    
          spz[(j*64)+i]=spz[(j*64)+i]+counter-1;//+inc_or_dec;
        } 
      }
    }
    
    //fix height
    if (stairtype==4){stairoffset=11;} //12
    if (stairtype==8){stairoffset=15;} //6 
    if (stairtype==16){stairoffset=23;}//3
    
    for(int jj=0;jj<stairmax;jj++)
    {  
      for(int j=stairoffset+(jj*stairtype);j<(stairoffset+1)+(jj*stairtype);j++)
      {
        for(int i=0;i<64;i++)
        {
          spy[(j*64)+i]=spy[((j+1)*64)+i];
          spy[((j-1)*64)+i]=spy[((j)*64)+i]-1;          
          spy[((j+2)*64)+i]=spy[((j+1)*64)+i]+1;
        } 
      }
    } 
    
    
    
    // find min and max
    float average=  (spz[0]+spz[(64*64)-1])/2.0;
    //println(average);    
    for(int j=0;j<64;j++)
    {
        for(int i=0;i<64;i++)
        {
          spz[(j*64)+i]=spz[(j*64)+i]-average;
        }
     }
     
     
     //fixbottom y
    for(int j=56;j<64;j++)
    {
        for(int i=0;i<64;i++)
        {
          spy[(j*64)+i]=spy[(55*64)+i];
        }
     }
     */
    //generate sculpt image
    //getimagedata();  
    generate_scuptxyz(); 
    
}




void reset_to_stairscube_oud()
{
    gridflat= loadImage("data/grid.png");
     
    rendertype=1;
   //draw sides of the cube
    cube_drawsides(8,56);

    // draw top - scale xz and reset y
    cube_drawsides(0,8);    
    for(int j=0;j<8;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=((spx[(j*64)+i]*((float)j/7.0f)));
        spy[(j*64)+i]=-48;
        spz[(j*64)+i]=(spz[(j*64)+i]*((float)j/7.0f))/50.0f;
      }
    }

    for(int j=0;j<8;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spz[(j*64)+i]=spz[(j*64)+i]+31.2;//(spz[(j*64)+i]*((float)j/7.0f))/70.0f;
      }
    }
    
    // draw bottom -  scale xz and reset y
    cube_drawsides(56,64);    
    for(int j=56;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=(spx[(j*64)+i]*((float)(63-j)/7.0f)); //0 
        spy[(j*64)+i]=48;
        spz[(j*64)+i]=(spz[(j*64)+i]*((float)(63-j)/7.0f))/50.0f;
      } 
    }
    
    for(int j=56;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spz[(j*64)+i]=spz[(j*64)+i]-31;//31;//(spz[(j*64)+i]*((float)j/7.0f))/70.0f;
      }
    }
    
    
  //generate sculpt image
    generate_scuptxyz();
    
}

void reset_to_stairscube_linemiddle()
{
      rendertype=1;

   //draw sides of the cube
    cube_drawsides(8,56);

    // draw top - scale xz and reset y
    cube_drawsides(0,8);    
    for(int j=0;j<8;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=((spx[(j*64)+i]*((float)j/7.0f))/70.0f);
        spy[(j*64)+i]=-47;
        spz[(j*64)+i]=spz[(j*64)+i]*((float)j/7.0f);
      }
    }

    // draw bottom -  scale xz and reset y
    cube_drawsides(56,64);    
    for(int j=56;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=(spx[(j*64)+i]*((float)(63-j)/7.0f))/70.0f; //0 
        spy[(j*64)+i]=47;
        spz[(j*64)+i]=spz[(j*64)+i]*((float)(63-j)/7.0f);
      } 
    }  
  //generate sculpt image
    generate_scuptxyz(); 
}
