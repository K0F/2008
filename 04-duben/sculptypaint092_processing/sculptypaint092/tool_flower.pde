// tool_flower

//----------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------- flower tool --------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------
void flower_copy(int flowernm)
{
  whatflowercopy=flowernm;
}
      //if(mx>872 && mx<887  && my>492 && my<505 ) {flower_stemxy();}
      //if(mx>891 && mx<906  && my>492 && my<505) {flower_stemxz();}

void flower_stemxy()
{
  flower_draw_xyz=0;  
    stembezier.loadPixels(); //clear screen
  for(int j=0; j<220; j++)
  {
    for(int i=0; i<150; i++)
    {
      drawpoint(stembezier.pixels,  i,j, 150,   0, 0, 0);
    }
  }
  flower_drawbezier(flower_bezx, flower_bezy, flower_bezbufx, flower_bezbufy);
}
void flower_stemzy()
{
  flower_draw_xyz=1;  
  
  stembezier.loadPixels(); //clear screen
  for(int j=0; j<220; j++)
  {
    for(int i=0; i<150; i++)
    {
      drawpoint(stembezier.pixels,  i,j, 150,   0, 0, 0);
    }
  }
  flower_drawbezier(flower_bezz, flower_bezy, flower_bezbufz, flower_bezbufy);    
}

void flower_check_bezierpoints()
{
int tempx=mx-808;
    int tempy=my-269;
  
    float nox=0;
    float noy=0;
    int whatpoint=0;
    float tempdistance=1000.0f;
  
    for (int i=0;i<4;i++)
    {
      if(tempx<=flower_bezx[i]){nox=flower_bezx[i]-tempx;}
      if(tempx>flower_bezx[i]){nox=tempx-flower_bezx[i];}
      if(tempy<=flower_bezy[i]){noy=flower_bezy[i]-tempy;}
      if(tempy>flower_bezy[i]){noy=tempy-flower_bezy[i];}
      float distance=sqrt((nox*nox)+(noy*noy));
      if (distance<tempdistance){whatpoint=i; tempdistance=distance;}
    }
    if (whatpoint!=0)
    {
      flower_bezierpointselect=whatpoint;
      //int flower_draw_xyz=0;
    }
}

void flower_stembezier()
{

    int tempx=mx-808;
    int tempy=my-269;
  
    float nox=0;
    float noy=0;
    int whatpoint=0;
    float tempdistance=1000.0f;
  
    if(flower_draw_xyz==0)
    {
      for (int i=0;i<4;i++)
      {
        if(tempx<=flower_bezx[i]){nox=flower_bezx[i]-tempx;}
        if(tempx>flower_bezx[i]){nox=tempx-flower_bezx[i];}
        if(tempy<=flower_bezy[i]){noy=flower_bezy[i]-tempy;}
        if(tempy>flower_bezy[i]){noy=tempy-flower_bezy[i];}
        float distance=sqrt((nox*nox)+(noy*noy));
        if (distance<tempdistance){whatpoint=i; tempdistance=distance;}
      }
      if (whatpoint!=0)
      {
        flower_bezx[whatpoint]=tempx;
        flower_bezy[whatpoint]=tempy;
        //println(whatpoint+": "+tempx+" - "+tempy);
        flower_bezierpointselect=whatpoint;
    }
  }
    if(flower_draw_xyz==1)
    {
      for (int i=0;i<4;i++)
      {
        if(tempx<=flower_bezz[i]){nox=flower_bezz[i]-tempx;}
        if(tempx>flower_bezz[i]){nox=tempx-flower_bezz[i];}
        if(tempy<=flower_bezy[i]){noy=flower_bezy[i]-tempy;}
        if(tempy>flower_bezy[i]){noy=tempy-flower_bezy[i];}
        float distance=sqrt((nox*nox)+(noy*noy));
        if (distance<tempdistance){whatpoint=i; tempdistance=distance;}
      }
      if (whatpoint!=0)
      {
        flower_bezz[whatpoint]=tempx;
        flower_bezy[whatpoint]=tempy;
        //println(whatpoint+": "+tempx+" - "+tempy);
        flower_bezierpointselect=whatpoint;
    }
  }
    
  stembezier.loadPixels(); //clear screen
  for(int j=0; j<220; j++)
  {
    for(int i=0; i<150; i++)
    {
      drawpoint(stembezier.pixels,  i,j, 150,   0, 0, 0);
    }
  }
  if (flower_draw_xyz==0)
  {
    flower_drawbezier(flower_bezx, flower_bezy, flower_bezbufx, flower_bezbufy);
  }
  if (flower_draw_xyz==1)
  {
    flower_drawbezier(flower_bezz, flower_bezy, flower_bezbufz, flower_bezbufy);    
  }
  //update stem
  int starter=16;
    //  stem_width=stem_width+0.25f;
    //flowerbezbuff=240
  if(leaves4==0){starter=35;}else{starter=41;} //41-64 = 23
  if(leaves3==0 && leaves4==0){starter=28;}//36
  if(leaves2==0 && leaves3==0 && leaves4==0){starter=21;}//43
  if(leaves1==0 && leaves2==0 && leaves3==0 && leaves4==0){starter=16;}//48
  
  
  //println(starter);
  int stepzer=240/(64-starter); //
     
  for(int i=starter+1;i<64;i++)
  {   
      int posr=i-(starter+1);//0 - 1 
      int temprx=flower_bezbufx[posr*stepzer]-75;//240
      int temprz=flower_bezbufz[posr*stepzer]-75;//240
    
      flower_translate_ringxz(starter,i, temprx, temprz);
  }
  
 
  //fix height
  float topy=spy[(starter*64)];
  float boty=spy[(63*64)];
  float disty=(boty-topy)/(64-starter);
  for(int i=starter+1;i<64;i++)
  {
     float distery=disty*(i-starter+1);
     flower_translate_ringy(starter,i, distery);
  }
  
  //generate sculpt image
  generate_scuptxyz();  
}
void flower_translate_ringy(int orgring,int ring, float ringy)
{
  for(int i=0;i<64;i++)
  {
    spy[(ring*64)+i]=spy[(orgring*64)+i]+ringy;   
  }  
}

void flower_translate_ringxz(int orgring,int ring, int ringx, int ringz)
{
  for(int i=0;i<64;i++)
  {
    spx[(ring*64)+i]=spx[(orgring*64)+i]+(float)ringx/2.0f;
    spz[(ring*64)+i]=spz[(orgring*64)+i]+(float)ringz/2.0f;
  }  
}

void flower_drawbezier(int bezzi_x[],int bezzi_y[] , int bezzi_buff_x[],int bezzi_buff_y[])
{  
    float t,t2,t3,step;
    int x,y;//, n=150;
    t=0.0f;
    t2=0.0f;
    t3=0.0f;

    for(int i=0; i<4; i++)
    {
      bezcx[i] =0;
      bezcy[i] =0;
      for(int j=0; j<4; j++)
      {
              bezcx[i] += bezzi_x[j]*beziermat[i][j];
              bezcy[i] += bezzi_y[j]*beziermat[i][j];
      }
    } 

    step = 1.0f/flowerbezbuf;
    for(int i=0; i<flowerbezbuf; i++)
    {
            t += step;
            t2 = t*t;
            t3 = t*t2;
            x = (int)(bezcx[0]*t3 + bezcx[1]*t2 + bezcx[2]*t + bezcx[3]);
            y = (int)(bezcy[0]*t3 + bezcy[1]*t2 + bezcy[2]*t + bezcy[3]);

            if (x>=0 && x<150 && y>=0 && y<220)
	    {
	      bezzi_buff_x[i]=x;
	      bezzi_buff_y[i]=y;
            }
    }

  stembezier.loadPixels();
  for(int i=0; i<flowerbezbuf; i++)
  {
    drawpoint(stembezier.pixels,  bezzi_buff_x[i],bezzi_buff_y[i], 150,   60, 60, 60);
  }
  for (int i=0;i<4;i++)
  {
     drawpoint(stembezier.pixels,  bezzi_x[i],bezzi_y[i], 150,   155, 255, 255);
  }  
  stembezier.updatePixels();
}

void flower_texture_paste(int flowernm)
{
  int cstart=0, pstart=0;
  
  if(whatflowercopy==1){ cstart=60;}
  if(whatflowercopy==2){ cstart=88;}
  if(whatflowercopy==3){ cstart=116;}
  if(whatflowercopy==4){ cstart=144;}
  
  if(flowernm==1){ pstart=60;}
  if(flowernm==2){ pstart=88;}
  if(flowernm==3){ pstart=116;}
  if(flowernm==4){ pstart=144;}
  

  gridflat.loadPixels(); 
  for (int j=cstart;j<cstart+20 ;j++)
  {  
    for (int i=0;i<256;i++)
    {  
      int posi=(j*256)+i;
      int desti=( (pstart + (j-cstart))   *256)+i;
      int r=(gridflat.pixels[posi] >> 16) & 0xff;
      int g=(gridflat.pixels[posi] >>  8) & 0xff;
      int b=gridflat.pixels[posi] & 0xff;
      gridflat.pixels[desti] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
    }
  }
  gridflat.updatePixels();
}

void flower_paste(int flowernm)
{
  //new  
  if (flowernm==1)
  {
    flower_resetleaves(16, 20,1);
    leaves1=1; //put it on
    if(whatflowercopy==1){leavestype1=leavestype1;} //set correct flowertype
    if(whatflowercopy==2){leavestype1=leavestype2;}
    if(whatflowercopy==3){leavestype1=leavestype3;}
    if(whatflowercopy==4){leavestype1=leavestype4;}
    flower_modleaves_1(1);
    flower_texture_paste(1);
  }
  if (flowernm==2)
  {    
    flower_resetleaves(23, 27, 2);
    leaves2=1;
    if(whatflowercopy==1){leavestype2=leavestype1;} //set correct flowertype
    if(whatflowercopy==2){leavestype2=leavestype2;}
    if(whatflowercopy==3){leavestype2=leavestype3;}
    if(whatflowercopy==4){leavestype2=leavestype4;}    
    flower_modleaves_2(1);
    flower_texture_paste(2);
  }
  if (flowernm==3)
  {
      flower_resetleaves(30, 34, 3);
      leaves3=1;
      if(whatflowercopy==1){leavestype3=leavestype1;} //set correct flowertype
      if(whatflowercopy==2){leavestype3=leavestype2;}
      if(whatflowercopy==3){leavestype3=leavestype3;}
      if(whatflowercopy==4){leavestype3=leavestype4;}    
      flower_modleaves_3(1);
      flower_texture_paste(3);
  }
  if (flowernm==4)
  {
    flower_resetleaves(37, 41, 4);
    leaves4=1;
    if(whatflowercopy==1){leavestype4=leavestype1;} //set correct flowertype
    if(whatflowercopy==2){leavestype4=leavestype2;}
    if(whatflowercopy==3){leavestype4=leavestype3;}
    if(whatflowercopy==4){leavestype4=leavestype4;}    
    flower_modleaves_4(1);
    flower_texture_paste(4);
  }
}
        
void stem_height_min()
{
  stem_height=stem_height-0.5f;
  if(stem_height<0){stem_height=0.1f;}
  stem_adjustheight();
  generate_scuptxyz();  
}
void stem_height_plus()
{
  stem_height=stem_height+0.5f;
  stem_adjustheight();
  generate_scuptxyz();
}

  //do the rest of the stem

void stem_adjustheight()
{
  for (int i=43;i<64;i++)
  {
    modringheight(0, 1, i,i+1,stemtopheight+14.0f+(stem_height*(i-42)));
  }
  //fix closing bottom
  modringheight(0, 1, 63,63+1,stemtopheight+14.0f+(stem_height*(62-42)));

}
    
void stem_width_min()
{
    int starter=16;
    stem_width=stem_width-0.25f;
    if(stem_width<0){stem_width=0.1f;}    
    
    if(leaves4==0){starter=35;}else{starter=41;}
    if(leaves3==0){starter=28;}
    if(leaves2==0){starter=21;}
    if(leaves1==0){starter=16;}
    
    for(int i=starter;i<63;i++)
    {
      scaleringxy(i, stem_width);
    }
    scaleringxy(63, 0.01f);//fix hole at end
   //generate sculpt image
    generate_scuptxyz();
}
void stem_width_plus()
{
    int starter=16;
    stem_width=stem_width+0.25f;
    
    if(leaves4==0){starter=35;}else{starter=41;}
    if(leaves3==0){starter=28;}
    if(leaves2==0){starter=21;}
    if(leaves1==0){starter=16;}
 
    
    for(int i=starter;i<63;i++)
    {
      scaleringxy(i, stem_width);
    }
    scaleringxy(63, 0.01f);//fix hole at end
   //generate sculpt image
    generate_scuptxyz();
    
}  
       
       
// Reset to flower form, switching between drawing tool and slide rgb layers can be interresting, but also create a mess..
void flower_reset()
{
    flower_randtop();
    flowertexture_paint1(15, 64);
    leaves1=1;
    leaves2=0;
    leaves3=0;
    leaves4=0;
    leavestype1=1;
    for(int i=16;i<64;i++)
    {
      scaleringxy(i, stem_width);
    }
    draw6_8(16,0,1,0); //16,17,18,19 -- creates leave 1

    flowertexture_whole();

    rendermodez=3;

   //generate sculpt image
    generate_scuptxyz();
}

//--------------texture part-----------------------
void flowertexture_whole()
{
  /*
  gridflat.loadPixels(); 
  for (int j=0;j<256;j++)
  {  
    for (int i=0;i<256;i++)
    {  
      gridflat.pixels[(j*256)+i] =  ( (0xff<<24) | (0<<16) | (0<<8) | 0);
    }
  }
  gridflat.updatePixels();
  */
  flowertexture_root();
  flowertexture_top();
  flowertexture_leaf1();
  flowertexture_leaf2();
  flowertexture_leaf3();
  flowertexture_leaf4();
  
}

void flowertexture_paint1(int start, int end)
{
  gridflat.loadPixels();
  int r1=(int)random(256);
  int g1=(int)random(256);
  int b1=(int)random(256);
  
  int r2=(int)random(256);
  int g2=(int)random(256);
  int b2=(int)random(256);
  
  int verloop=(end-start)*4; //15*4 - 60  
  int j1=0;
  int j2=verloop;
  
  for(int j=start*4;j<end*4;j++)
  {
     int r3=((r1*j1)+(r2*j2)) / verloop;    
     int g3=((g1*j1)+(g2*j2)) / verloop;    
     int b3=((b1*j1)+(b2*j2)) / verloop;    
     j1++;
     j2--;
     for(int i=0;i<256;i++)
     {
      drawpoint2( gridflat.pixels,  i, j, 256, r3, g3, b3);     
     }
  }
  gridflat.updatePixels();  
}
void flowertexture_paint2(int start, int end, int r1, int g1, int b1)
{
  gridflat.loadPixels();    
  for(int j=start*4;j<end*4;j++)
  {
     for(int i=0;i<256;i++)
     {
      drawpoint2( gridflat.pixels,  i, j, 256, r1, g1, b1);     
     }
  }
  gridflat.updatePixels();
}

void flowertexture_whitelines(int start, int end)
{
  gridflat.loadPixels();

  int r2=(int)random(256);
  int g2=(int)random(256);
  int b2=(int)random(256);
      
  //whitelines
  int step1=((int) random(4));
  int step2=0;
  if(step1==1){step2=2;}
  if(step1==2){step2=4;}
  if(step1==3){step2=8;}

  if(step1!=0)
  {
    for(int j=start*4;j<end*4;j++)
    {
       for(int i=0;i<256;i=i+step2)
       {
        addpoint( gridflat.pixels,  i+j*256, r2/10, g2/10, b2/10);     
       }
    }
  }  
  gridflat.updatePixels();  
}
void flowertexture_darkerlines(int start, int end)
{
  gridflat.loadPixels();
  
  int r2=(int)random(256);
  int g2=(int)random(256);
  int b2=(int)random(256);
  
 //darker lines
  int step1=((int) random(4));
  int step2=0;
  if(step1==1){step2=2;}
  if(step1==2){step2=4;}
  if(step1==3){step2=8;}

  
  if(step1!=0)
  {

    for(int j=start*4;j<end*4;j++)
    {
       for(int i=0;i<256;i=i+step2)
       {
        minpoint( gridflat.pixels,  i+j*256, r2/4, g2/4, b2/4);     
       }
    }
  }   
  gridflat.updatePixels();  
}


void addpoint(int output[],int posi, int r, int g, int b)
{
  r=r+((output[posi] >> 16) & 0xff);
  g=g+((output[posi] >>  8) & 0xff);
  b=b+(output[posi] & 0xff);
  if (r>255){r=255;}
  if (g>255){g=255;}
  if (b>255){b=255;}
  output[posi] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
}
void mixpoint(int output[],int posi, int r, int g, int b)
{
  r=(r+((output[posi] >> 16) & 0xff))/2;
  g=(g+((output[posi] >>  8) & 0xff))/2;
  b=(b+(output[posi] & 0xff))/2;
  output[posi] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
}

void minpoint(int output[],int posi, int r, int g, int b)
{
  r=((output[posi] >> 16) & 0xff)-r;
  g=((output[posi] >>  8) & 0xff)-g;
  b=(output[posi] & 0xff)-b;
  if (r<0){r=0;}
  if (g<0){g=0;}
  if (b<0){b=0;}
  output[posi] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
}
void flowertexture_rand3(int start, int end, int r, int g, int b)
{
  int tea=(int)random(3);
  for(int j=start,stepz=1;j<end;j++) // back mid
  {
    for(int i=0;i<256;i++)
    {      
      if(tea==0){addpoint( gridflat.pixels,  i+j*256, r+stepz, g+stepz, b+stepz);}
      if(tea==1){minpoint( gridflat.pixels,  i+j*256, r/4+stepz, g/4+stepz, b/4+stepz);}
      if(tea==2){mixpoint( gridflat.pixels,  i+j*256, r+stepz, g+stepz, b+stepz);}
    }
    stepz++;
  }  
}

void flowertexture_top()
{
  flowertexture_paint1(0, 15);
}

void flowertexture_leafsetrand(int s)
{
  gridflat.loadPixels();  
  int r2=(int)random(256);
  int g2=(int)random(256);
  int b2=(int)random(256);
  flowertexture_rand3(s, s+1, r2, g2, b2); // top start
  flowertexture_rand3(s+1, s+2, r2, g2, b2); // top mid 
  flowertexture_rand3(s+2, s+3, r2, g2, b2); // top and sides
  // for(int j=16*4,stepz=1;j<19*4;j++)    // sides
  flowertexture_rand3(s+3, s+4, r2, g2, b2); // top and sides 16

  flowertexture_rand3(s+4, s+5, r2, g2, b2); // top and sides
  flowertexture_rand3(s+5, s+6, r2, g2, b2); // top and sides
  flowertexture_rand3(s+6, s+7, r2, g2, b2); // top and sides
  flowertexture_rand3(s+7, s+8, r2, g2, b2); // top and sides
  flowertexture_rand3(s+8, s+9, r2, g2, b2); // top and sides
  flowertexture_rand3(s+9, s+10, r2, g2, b2); // top and sides
  flowertexture_rand3(s+10, s+11, r2, g2, b2); // top and sides
  flowertexture_rand3(s+11, s+12, r2, g2, b2); // top and sides
  flowertexture_rand3(s+12, s+13, r2, g2, b2); // top and sides
  flowertexture_rand3(s+13, s+14, r2, g2, b2); // top and sides
  flowertexture_rand3(s+14, s+15, r2, g2, b2); // top and sides
  flowertexture_rand3(s+15, s+16, r2, g2, b2); // top and sides


  
  flowertexture_rand3(s+16, s+17, r2, g2, b2); //backtop
  flowertexture_rand3(s+17, s+18, r2, g2, b2); //backmid
  flowertexture_rand3(s+18, s+19, r2, g2, b2); //back
  gridflat.updatePixels();  
}

void flowertexture_leaf1()
{
  flowertexture_paint1(15, 20);
  flowertexture_whitelines(15, 20);
  flowertexture_darkerlines(15, 20);
  flowertexture_leafsetrand(60);
  fix_between_rings();
}

void flowertexture_leaf2()
{
  flowertexture_paint1(22, 27);
  flowertexture_whitelines(22, 27);
  flowertexture_darkerlines(22, 27);
  flowertexture_leafsetrand(88);
  fix_between_rings();  
}
void flowertexture_leaf3()
{
  flowertexture_paint1(29, 34);
  flowertexture_whitelines(29, 34);
  flowertexture_darkerlines(29, 34);  
  flowertexture_leafsetrand(116);
  fix_between_rings();  
}
void flowertexture_leaf4()
{
  flowertexture_paint1(36, 41);
  flowertexture_whitelines(36, 41);
  flowertexture_darkerlines(36, 41);
  flowertexture_leafsetrand(144);
  fix_between_rings();
}
void flowertexture_root()
{
  flowertexture_paint1(41, 64);
  fix_between_rings();
}
void fix_between_rings()
{
  //fix rings between flowers. get top stem color
  gridflat.loadPixels();  
  int r1=(gridflat.pixels[79*256] >> 16) & 0xff;
  int g1=(gridflat.pixels[79*256] >>  8) & 0xff;
  int b1= gridflat.pixels[79*256] & 0xff;    
  flowertexture_paint2(20, 22, r1, g1, b1);

  r1=(gridflat.pixels[107*256] >> 16) & 0xff;
  g1=(gridflat.pixels[107*256] >>  8) & 0xff;
  b1= gridflat.pixels[107*256] & 0xff;      
  flowertexture_paint2(27, 29, r1, g1, b1);
  
  r1=(gridflat.pixels[135*256] >> 16) & 0xff;
  g1=(gridflat.pixels[135*256] >>  8) & 0xff;
  b1= gridflat.pixels[135*256] & 0xff;      
  flowertexture_paint2(34, 36, r1, g1, b1);  
}


//flower 3D shape
void flowerminplus(int leave, int inc) //change hight of flowerleaves
{
  if(leave==1)
  {
    if(leavestype1==0)
    {    
      for (int i=0; i<8; i++){flower_hightmod(16, 20, inc,(i*8),(i*8)+2);}      
    }
    if(leavestype1==1)
    {    
      for (int i=0; i<4; i++){ flower_hightmod(16, 20, inc,(i*16),(i*16)+6);}
    }
    if(leavestype1==2)
    {    
      for (int i=0; i<4; i++){ flower_hightmod(16, 20, inc,(i*16),(i*16)+12);}
    }
  }
  if(leave==3)
  {
    if(leavestype3==0)
    {    
      for (int i=0; i<8; i++){ flower_hightmod(30, 34, inc,(i*8),(i*8)+2);}      
    }
    if(leavestype3==1)
    {    
      for (int i=0; i<4; i++){ flower_hightmod(30, 34, inc,(i*16)+4,(i*16)+4+6);}
    }
    if(leavestype3==2)
    {    
      for (int i=0; i<4; i++){ flower_hightmod(30, 34, inc,(i*16),(i*16)+12);}
    }
  }

  if(leave==2)
  {
    if(leavestype2==0)
    {    
      for (int i=0; i<8; i++){flower_hightmod(23, 27, inc,(i*8)+2,(i*8)+4);}      
    } 
    if(leavestype2==1)
    {    
      for (int i=0; i<4; i++){ flower_hightmod(23, 27, inc,(i*16)+8,(i*16)+8+6);}
      //fix the last leave
      /*
      flower_hightmod_part(23, 27,inc,0);
      flower_hightmod_part(23, 27,inc,1);
      flower_hightmod_part(23, 27,inc,60);
      flower_hightmod_part(23, 27,inc,61);
      flower_hightmod_part(23, 27,inc,62);
      flower_hightmod_part(23, 27,inc,63);*/    
    }
    if(leavestype2==2)
    {    
      for (int i=0; i<3; i++){ flower_hightmod(23, 27, inc,(i*16)+8,(i*16)+8+12);}
      //fix the last leave
      flower_hightmod_part(23, 27,inc,0);
      flower_hightmod_part(23, 27,inc,1);
      flower_hightmod_part(23, 27,inc,2);
      flower_hightmod_part(23, 27,inc,3);

      flower_hightmod_part(23, 27,inc,56);
      flower_hightmod_part(23, 27,inc,57);
      flower_hightmod_part(23, 27,inc,58);
      flower_hightmod_part(23, 27,inc,59);
      
      flower_hightmod_part(23, 27,inc,60);
      flower_hightmod_part(23, 27,inc,61);
      flower_hightmod_part(23, 27,inc,62);
      flower_hightmod_part(23, 27,inc,63);
    }
  }
  if(leave==4)
  {
    if(leavestype4==0)
    {    
      for (int i=0; i<8; i++){flower_hightmod(37, 41, inc,(i*8)+2,(i*8)+4);}      
    }
    if(leavestype4==1)
    {    
      for (int i=0; i<3; i++){ flower_hightmod(37, 41, inc,(i*16)+12,(i*16)+12+6);}
      //fix the last leave
      
      flower_hightmod_part(37, 41,inc,0);
      flower_hightmod_part(37, 41,inc,1);
      flower_hightmod_part(37, 41,inc,60);
      flower_hightmod_part(37, 41,inc,61);
      flower_hightmod_part(37, 41,inc,62);
      flower_hightmod_part(37, 41,inc,63);  
    }
    if(leavestype4==2)
    {    
      for (int i=0; i<3; i++){ flower_hightmod(37, 41, inc,(i*16)+8,(i*16)+8+12);}
      //fix the last leave
      flower_hightmod_part(37, 41,inc,0);
      flower_hightmod_part(37, 41,inc,1);
      flower_hightmod_part(37, 41,inc,2);
      flower_hightmod_part(37, 41,inc,3);

      flower_hightmod_part(37, 41,inc,56);
      flower_hightmod_part(37, 41,inc,57);
      flower_hightmod_part(37, 41,inc,58);
      flower_hightmod_part(37, 41,inc,59);
      
      flower_hightmod_part(37, 41,inc,60);
      flower_hightmod_part(37, 41,inc,61);
      flower_hightmod_part(37, 41,inc,62);
      flower_hightmod_part(37, 41,inc,63);

    }
  }
  generate_scuptxyz();
   
}

void flower_hightmod_part(int from, int to, float incr, int num)
{
  for (int i=from; i<to;i++)
  {
    spy[(i*64)+num]=spy[(i*64)+num]+incr;
  }
}

void flower_hightmod(int from, int to, float inc, int xstart, int xend)
{
    for (int j=from; j<to; j++)
    {
      for (int i=xstart; i<xend; i++)
      {
        spy[(j*64)+i]=spy[(j*64)+i]+inc;
      }
    } 
}      

void flower_modleaves_1(int neworcopy)
{
  if(leavestype1==0){draw2_16(16,0,1, neworcopy);}//16 leaves - 16,17,18
  if(leavestype1==1){draw6_8(16,0,1,neworcopy);}//8 leaves  
  if(leavestype1==2){draw4_16(16,0, 1, neworcopy);}//4 leaves - startring, offset, what leave, new or copy  
  generate_scuptxyz();   //generate sculpt image
   
}

void flower_modleaves_2(int neworcopy)
{
  if(leavestype2==0){draw2_16(23,2,2,neworcopy);}//16 leaves - 20,21,22
  if(leavestype2==1){draw6_8(23,8,2,neworcopy);}//8 leaves  
  if(leavestype2==2){draw4_16(23,8,2, neworcopy);}//4 leaves  
  generate_scuptxyz();   //generate sculpt image
  //getimagedata();      // redraw the 3D object
}

void flower_modleaves_3(int neworcopy)
{
  if(leavestype3==0){draw2_16(30,0,3,neworcopy);}//16 leaves -  
  if(leavestype3==1){draw6_8(30,4,3,neworcopy);}//8 leaves  
  if(leavestype3==2){draw4_16(30,0,3, neworcopy);}//4 leaves  
  generate_scuptxyz();   //generate sculpt image
  //getimagedata();      // redraw the 3D object
}

void flower_modleaves_4(int neworcopy)
{
  if(leavestype4==0){draw2_16(37,2,4,neworcopy);}//16 leaves - 
  if(leavestype4==1){draw6_8(37,12,4,neworcopy);}//8 leaves 
  if(leavestype4==2){draw4_16(37,8,4, neworcopy);}//4 leaves 
  generate_scuptxyz();  //generate sculpt image
  //getimagedata();      // redraw the 3D object
}


void flower_resetleaves(int from, int too,int partz)
{
  for(int i=from;i<too;i++)
  {
    scaleringxy(i, 2);
  }
  //reset the height again as well
  adjustflowerleavehight_part(partz);
}

void flower_randtop()
{
  //top 0-15
  float topscaler=random(100)/100.0f+0.1f; 
  scaleringxy(0, 0.01*topscaler);
  scaleringxy(1, 0.1*topscaler);
  scaleringxy(2, 1*topscaler);
  scaleringxy(3, 2.2*topscaler);
  scaleringxy(4, 3.6*topscaler);
  scaleringxy(5, 5.4*topscaler);
  scaleringxy(6, 7*topscaler);
  scaleringxy(7, 8*topscaler);
  scaleringxy(8, 9.5*topscaler);
  scaleringxy(9, 10.5*topscaler);
  scaleringxy(10, 11*topscaler);
  scaleringxy(11, 11*topscaler);
  scaleringxy(12, 11*topscaler);
  scaleringxy(13, 10*topscaler);
  scaleringxy(14, 9*topscaler);
  scaleringxy(15, 8*topscaler);
  
  float stepperz=1.1;
  float stepinc=(random(100)/1000.0f)+0.1;
  for(int i=0;i<16;i++)
  {
    modringheight(0, 1, i,i+1,-42+stepperz);
    stepperz=stepperz*(1.01f+stepinc);//.1;//stepinc;
  }
  stemtopheight=spy[64*15];
  adjustflowerleavehight();
  
  //generate new sculpt image
  generate_scuptxyz();
  //getimagedata();      // redraw the 3D object 
}
void adjustflowerleavehight_part(int part)
{
  //now adjust leaves on hight, based on the last top adjustment;
  if (part==1)
  {
    modringheight(0, 1, 16,17,stemtopheight+0.5f); //1
    modringheight(0, 1, 17,18,stemtopheight+1.0f);
    modringheight(0, 1, 18,19,stemtopheight+1.5f);  
    modringheight(0, 1, 19,20,stemtopheight+2.0f);
  }  
  if (part==2)
  {
    modringheight(0, 1, 23,24,stemtopheight+4.0f); //2
    modringheight(0, 1, 24,25,stemtopheight+4.5f);
    modringheight(0, 1, 25,26,stemtopheight+5.0f);
    modringheight(0, 1, 26,27,stemtopheight+5.5f);
  }
  if (part==3)
  {
    modringheight(0, 1, 30,31,stemtopheight+7.5f); //3  
    modringheight(0, 1, 31,32,stemtopheight+8.0f);
    modringheight(0, 1, 32,33,stemtopheight+8.5f);
    modringheight(0, 1, 33,34,stemtopheight+9.0f);
  }  
  if (part==4)
  {  
    modringheight(0, 1, 37,38,stemtopheight+11.0f); //4
    modringheight(0, 1, 38,39,stemtopheight+11.5f);
    modringheight(0, 1, 39,40,stemtopheight+12.0f);  
    modringheight(0, 1, 40,41,stemtopheight+12.5f);
  }
}

void adjustflowerleavehight()
{
  //now adjust leaves on hight, based on the last top adjustment;
  
  modringheight(0, 1, 16,17,stemtopheight+0.5f); //1
  modringheight(0, 1, 17,18,stemtopheight+1.0f);
  modringheight(0, 1, 18,19,stemtopheight+1.5f);  
  modringheight(0, 1, 19,20,stemtopheight+2.0f);
  
  modringheight(0, 1, 20,21,stemtopheight+2.5f);  
  modringheight(0, 1, 21,22,stemtopheight+3.0f);
  modringheight(0, 1, 22,23,stemtopheight+3.5f);
  
  modringheight(0, 1, 23,24,stemtopheight+4.0f); //2
  modringheight(0, 1, 24,25,stemtopheight+4.5f);
  modringheight(0, 1, 25,26,stemtopheight+5.0f);
  modringheight(0, 1, 26,27,stemtopheight+5.5f);
  
  modringheight(0, 1, 27,28,stemtopheight+6.0f);  
  modringheight(0, 1, 28,29,stemtopheight+6.5f);  
  modringheight(0, 1, 29,30,stemtopheight+7.0f);
  
  modringheight(0, 1, 30,31,stemtopheight+7.5f); //3  
  modringheight(0, 1, 31,32,stemtopheight+8.0f);
  modringheight(0, 1, 32,33,stemtopheight+8.5f);
  modringheight(0, 1, 33,34,stemtopheight+9.0f);
  
  modringheight(0, 1, 34,35,stemtopheight+9.5f);
  modringheight(0, 1, 35,36,stemtopheight+10.0f);
  modringheight(0, 1, 36,37,stemtopheight+10.5f);
  
  modringheight(0, 1, 37,38,stemtopheight+11.0f); //4
  modringheight(0, 1, 38,39,stemtopheight+11.5f);
  modringheight(0, 1, 39,40,stemtopheight+12.0f);  
  modringheight(0, 1, 40,41,stemtopheight+12.5f);

  modringheight(0, 1, 41,42,stemtopheight+13.0f);
  modringheight(0, 1, 42,43,stemtopheight+13.5f);
  
  //do the rest of the stem
  stem_adjustheight();
}
/*
void selectflowertool()
{
}
*/

void draw4_16(int start_ring, int offset, int leaf, int neworcopy) // 4 leaves
{ 
  float stemscale=0, s5=0,s6=0,s7=0,p1=0,p2=0,p3=0,p4  =0;  
  if(neworcopy==0) //new
  {
    stemscale=random(40)+30.0f;
    s5=random(30)-15.0f;
    s6=random(30)-15.0f;
    s7=random(30)-15.0f;    
    p1=random(50)-25.0f;    
    p2=random(20)-5.0f;
    p3=random(20)-5.0f;
    p4=random(50)-25.0f; 
  }
  if(neworcopy==1) //copy
  {
    stemscale=fl_4_stemscale[whatflowercopy];
    s5=fl_4_s5[whatflowercopy];
    s6=fl_4_s6[whatflowercopy];
    s7=fl_4_s7[whatflowercopy];

    p1=fl_4_p1[whatflowercopy];
    p2=fl_4_p2[whatflowercopy];
    p3=fl_4_p3[whatflowercopy];
    p4=fl_4_p4[whatflowercopy];
    
  }  
  //for copy / paste
  fl_4_stemscale[leaf]=stemscale;  
  fl_4_s5[leaf]=s5;  
  fl_4_s6[leaf]=s6;  
  fl_4_s7[leaf]=s7;
  fl_4_p1[leaf]=p1;
  fl_4_p2[leaf]=p2;
  fl_4_p3[leaf]=p3;
  fl_4_p4[leaf]=p4;

          
  modring(offset,   16, start_ring, start_ring+1, stemscale+s5+p1);  ///1
  modring(offset+1, 16, start_ring, start_ring+1, stemscale+s5+p1);
  
  modring(offset+2, 16, start_ring, start_ring+1, stemscale+s6+p1);
  modring(offset+3, 16, start_ring, start_ring+1, stemscale+s6+p1);
  
  modring(offset+4, 16, start_ring, start_ring+1, stemscale+s7+p1);
  modring(offset+5, 16, start_ring, start_ring+1, stemscale+s7+p1);
  modring(offset+6, 16, start_ring, start_ring+1, stemscale+s7+p1);
  modring(offset+7, 16, start_ring, start_ring+1, stemscale+s7+p1);
  
  modring(offset+8, 16, start_ring, start_ring+1, stemscale+s6+p1);
  modring(offset+9, 16, start_ring, start_ring+1, stemscale+s6+p1);
  
  modring(offset+10, 16, start_ring, start_ring+1, stemscale+s5+p1);
  modring(offset+11, 16, start_ring, start_ring+1, stemscale+s5+p1);


  modring(offset,   16, start_ring+1, start_ring+2, stemscale+s5+p2); //2
  modring(offset+1, 16, start_ring+1, start_ring+2, stemscale+s5+p2);
  
  modring(offset+2, 16, start_ring+1, start_ring+2, stemscale+s6+p2);
  modring(offset+3, 16, start_ring+1, start_ring+2, stemscale+s6+p2);
  
  modring(offset+4, 16, start_ring+1, start_ring+2, stemscale+s7+p2);
  modring(offset+5, 16, start_ring+1, start_ring+2, stemscale+s7+p2);
  modring(offset+6, 16, start_ring+1, start_ring+2, stemscale+s7+p2);
  modring(offset+7, 16, start_ring+1, start_ring+2, stemscale+s7+p2);
  
  modring(offset+8, 16, start_ring+1, start_ring+2, stemscale+s6+p2);
  modring(offset+9, 16, start_ring+1, start_ring+2, stemscale+s6+p2);
  
  modring(offset+10, 16, start_ring+1, start_ring+2, stemscale+s5+p2);
  modring(offset+11, 16, start_ring+1, start_ring+2, stemscale+s5+p2);


  modring(offset,   16, start_ring+2, start_ring+3, stemscale+s5+p3); //3
  modring(offset+1, 16, start_ring+2, start_ring+3, stemscale+s5+p3);
  
  modring(offset+2, 16, start_ring+2, start_ring+3, stemscale+s6+p3);
  modring(offset+3, 16, start_ring+2, start_ring+3, stemscale+s6+p3);
  
  modring(offset+4, 16, start_ring+2, start_ring+3, stemscale+s7+p3);
  modring(offset+5, 16, start_ring+2, start_ring+3, stemscale+s7+p3);
  modring(offset+6, 16, start_ring+2, start_ring+3, stemscale+s7+p3);
  modring(offset+7, 16, start_ring+2, start_ring+3, stemscale+s7+p3);
  
  modring(offset+8, 16, start_ring+2, start_ring+3, stemscale+s6+p3);
  modring(offset+9, 16, start_ring+2, start_ring+3, stemscale+s6+p3);
  
  modring(offset+10, 16, start_ring+2, start_ring+3, stemscale+s5+p3);
  modring(offset+11, 16, start_ring+2, start_ring+3, stemscale+s5+p3);


  modring(offset,   16, start_ring+3, start_ring+4, stemscale+s5+p4); //4
  modring(offset+1, 16, start_ring+3, start_ring+4, stemscale+s5+p4);
  
  modring(offset+2, 16, start_ring+3, start_ring+4, stemscale+s6+p4);
  modring(offset+3, 16, start_ring+3, start_ring+4, stemscale+s6+p4);
  
  modring(offset+4, 16, start_ring+3, start_ring+4, stemscale+s7+p4);
  modring(offset+5, 16, start_ring+3, start_ring+4, stemscale+s7+p4);
  modring(offset+6, 16, start_ring+3, start_ring+4, stemscale+s7+p4);
  modring(offset+7, 16, start_ring+3, start_ring+4, stemscale+s7+p4);
  
  modring(offset+8, 16, start_ring+3, start_ring+4, stemscale+s6+p4);
  modring(offset+9, 16, start_ring+3, start_ring+4, stemscale+s6+p4);
  
  modring(offset+10, 16, start_ring+3, start_ring+4, stemscale+s5+p4);
  modring(offset+11, 16, start_ring+3, start_ring+4, stemscale+s5+p4);

  if(offset==8)//fix the lastparts at start that 'fell off'
  {
    modring(0, 64, start_ring, start_ring+1, stemscale+s6+p1);
    modring(1, 64, start_ring, start_ring+1, stemscale+s6+p1);    
    modring(2, 64, start_ring, start_ring+1, stemscale+s5+p1);
    modring(3, 64, start_ring, start_ring+1, stemscale+s5+p1);
    
    modring(0, 64, start_ring+1, start_ring+2, stemscale+s6+p2);
    modring(1, 64, start_ring+1, start_ring+2, stemscale+s6+p2);
    modring(2, 64, start_ring+1, start_ring+2, stemscale+s5+p2);
    modring(3, 64, start_ring+1, start_ring+2, stemscale+s5+p2);
    
    modring(0, 64, start_ring+2, start_ring+3, stemscale+s6+p3);
    modring(1, 64, start_ring+2, start_ring+3, stemscale+s6+p3);
    modring(2, 64, start_ring+2, start_ring+3, stemscale+s5+p3);
    modring(3, 64, start_ring+2, start_ring+3, stemscale+s5+p3);
  
    modring(0, 64, start_ring+3, start_ring+4, stemscale+s6+p4);
    modring(1, 64, start_ring+3, start_ring+4, stemscale+s6+p4);
    modring(2, 64, start_ring+3, start_ring+4, stemscale+s5+p4);
    modring(3, 64, start_ring+3, start_ring+4, stemscale+s5+p4);

  }
  
  //----height
  float sh1=0, sh2=0, sh3=0, sh4=0, sh5=0, sh6=0;
  if(neworcopy==0) //new
  {
    sh1=(random(60)-30.0f)-40.0f;
    sh2=sh1+random(4)+0.3f; 
    sh3=sh2+random(4)+0.3f;
    sh4=sh3+random(4)+0.3f;
    sh5=(random(16)-8.0f);
    sh6=(random(16)-8.0f);
  }
  if(neworcopy==1) //new
  {
    sh1=fl_4_sh1[whatflowercopy];
    sh2=fl_4_sh2[whatflowercopy];
    sh3=fl_4_sh3[whatflowercopy];
    sh4=fl_4_sh4[whatflowercopy];    
    sh5=fl_4_sh5[whatflowercopy];
    sh6=fl_4_sh6[whatflowercopy];
  }  

  //for copy / paste  
  fl_4_sh1[leaf]=sh1;  
  fl_4_sh2[leaf]=sh2;  
  fl_4_sh3[leaf]=sh3;  
  fl_4_sh4[leaf]=sh4;  
  fl_4_sh5[leaf]=sh5;  
  fl_4_sh6[leaf]=sh6;
    
  //----------------------------------------------------------------
  modringheight(offset,   16, start_ring, start_ring+1, sh1);
  modringheight(offset+1, 16, start_ring, start_ring+1, sh1);
  
  modringheight(offset+2, 16, start_ring, start_ring+1, sh1+sh5);
  modringheight(offset+3, 16, start_ring, start_ring+1, sh1+sh5);
  
  modringheight(offset+4, 16, start_ring, start_ring+1, sh1+sh6);
  modringheight(offset+5, 16, start_ring, start_ring+1, sh1+sh6);
  modringheight(offset+6, 16, start_ring, start_ring+1, sh1+sh6);
  modringheight(offset+7, 16, start_ring, start_ring+1, sh1+sh6);
  
  modringheight(offset+8, 16, start_ring, start_ring+1, sh1+sh5);
  modringheight(offset+9, 16, start_ring, start_ring+1, sh1+sh5);
  
  modringheight(offset+10, 16, start_ring, start_ring+1, sh1);
  modringheight(offset+11, 16, start_ring, start_ring+1, sh1);

  //----------------------------------------------------------------
  modringheight(offset,   16, start_ring+1, start_ring+2, sh2); //2
  modringheight(offset+1, 16, start_ring+1, start_ring+2, sh2);
  
  modringheight(offset+2, 16, start_ring+1, start_ring+2, sh2+sh5);
  modringheight(offset+3, 16, start_ring+1, start_ring+2, sh2+sh5);
  
  modringheight(offset+4, 16, start_ring+1, start_ring+2, sh2+sh6);
  modringheight(offset+5, 16, start_ring+1, start_ring+2, sh2+sh6);
  modringheight(offset+6, 16, start_ring+1, start_ring+2, sh2+sh6);
  modringheight(offset+7, 16, start_ring+1, start_ring+2, sh2+sh6);
  
  modringheight(offset+8, 16, start_ring+1, start_ring+2, sh2+sh5);
  modringheight(offset+9, 16, start_ring+1, start_ring+2, sh2+sh5);
  
  modringheight(offset+10, 16, start_ring+1, start_ring+2, sh2);
  modringheight(offset+11, 16, start_ring+1, start_ring+2, sh2);


  //----------------------------------------------------------------
  modringheight(offset,   16, start_ring+2, start_ring+3, sh3); //3
  modringheight(offset+1, 16, start_ring+2, start_ring+3, sh3);
  
  modringheight(offset+2, 16, start_ring+2, start_ring+3, sh3+sh5);
  modringheight(offset+3, 16, start_ring+2, start_ring+3, sh3+sh5);
  
  modringheight(offset+4, 16, start_ring+2, start_ring+3, sh3+sh6);
  modringheight(offset+5, 16, start_ring+2, start_ring+3, sh3+sh6);
  modringheight(offset+6, 16, start_ring+2, start_ring+3, sh3+sh6);
  modringheight(offset+7, 16, start_ring+2, start_ring+3, sh3+sh6);
  
  modringheight(offset+8, 16, start_ring+2, start_ring+3, sh3+sh5);
  modringheight(offset+9, 16, start_ring+2, start_ring+3, sh3+sh5);
  
  modringheight(offset+10, 16, start_ring+2, start_ring+3, sh3);
  modringheight(offset+11, 16, start_ring+2, start_ring+3, sh3);

 
  //----------------------------------------------------------------
  modringheight(offset,   16, start_ring+3, start_ring+4, sh4); //4
  modringheight(offset+1, 16, start_ring+3, start_ring+4, sh4);
  
  modringheight(offset+2, 16, start_ring+3, start_ring+4, sh4+sh5);
  modringheight(offset+3, 16, start_ring+3, start_ring+4, sh4+sh5);
  
  modringheight(offset+4, 16, start_ring+3, start_ring+4, sh4+sh6);
  modringheight(offset+5, 16, start_ring+3, start_ring+4, sh4+sh6);
  modringheight(offset+6, 16, start_ring+3, start_ring+4, sh4+sh6);
  modringheight(offset+7, 16, start_ring+3, start_ring+4, sh4+sh6);
  
  modringheight(offset+8, 16, start_ring+3, start_ring+4, sh4+sh5);
  modringheight(offset+9, 16, start_ring+3, start_ring+4, sh4+sh5);
  
  modringheight(offset+10, 16, start_ring+3, start_ring+4, sh4);
  modringheight(offset+11, 16, start_ring+3, start_ring+4, sh4);

  if(offset==8)//fix the 4 at start that 'fell off'
  {
    modringheight(0, 16, start_ring, start_ring+1, sh1);
    modringheight(1, 16, start_ring, start_ring+1, sh1);
    modringheight(2, 16, start_ring, start_ring+1, sh1+sh5);
    modringheight(3, 16, start_ring, start_ring+1, sh1+sh5);

    modringheight(0, 16, start_ring+1, start_ring+2, sh2);
    modringheight(1, 16, start_ring+1, start_ring+2, sh2);
    modringheight(2, 16, start_ring+1, start_ring+2, sh2+sh5);
    modringheight(3, 16, start_ring+1, start_ring+2, sh2+sh5);
    
    modringheight(0, 16, start_ring+2, start_ring+3, sh3);
    modringheight(1, 16, start_ring+2, start_ring+3, sh3);  
    modringheight(2, 16, start_ring+2, start_ring+3, sh3+sh5);
    modringheight(3, 16, start_ring+2, start_ring+3, sh3+sh5);  
    
    modringheight(0, 16, start_ring+3, start_ring+4, sh4);
    modringheight(1, 16, start_ring+3, start_ring+4, sh4);
    modringheight(2, 16, start_ring+3, start_ring+4, sh4+sh5);
    modringheight(3, 16, start_ring+3, start_ring+4, sh4+sh5);
  } 


}


void draw6_8(int start_ring, int offset, int leaf, int neworcopy) // was 8 leaves now 4
{
  //width
  float stemscale=0,s5=0,s6=0,p1=0,p2=0,p3=0,p4=0;
  if(neworcopy==0) //new
  {  
    stemscale=random(50)+25.0f;
    s5=random(40)-20.0f;
    s6=random(40)-20.0f;
    
    p1=random(30)-15.0f;
    p2=random(40)-10.0f;
    p3=random(40)-10.0f;
    p4=random(30)-15.0f;  
  }
  if(neworcopy==1) // or copy?
  {
    stemscale=fl_8_stemscale[whatflowercopy];
    s5=fl_8_s5[whatflowercopy];
    s6=fl_8_s6[whatflowercopy];
    p1=fl_8_p1[whatflowercopy];
    p2=fl_8_p2[whatflowercopy];
    p3=fl_8_p3[whatflowercopy];
    p4=fl_8_p4[whatflowercopy];
  }
  fl_8_stemscale[leaf]=stemscale;
  fl_8_s5[leaf]=s5;
  fl_8_s6[leaf]=s6;
  
  fl_8_p1[leaf]=p1;
  fl_8_p2[leaf]=p2;
  fl_8_p3[leaf]=p3;
  fl_8_p4[leaf]=p4;
  
  int aa=16;
  //-------------------------------------------------------------
  modring(offset,   aa, start_ring, start_ring+1, stemscale+s6+p1);
  modring(offset+1, aa, start_ring, start_ring+1, stemscale+s6+p1);
  modring(offset+2, aa, start_ring, start_ring+1, stemscale+s5+p1);
  modring(offset+3, aa, start_ring, start_ring+1, stemscale+s5+p1);
  modring(offset+4, aa, start_ring, start_ring+1, stemscale+s6+p1);
  modring(offset+5, aa, start_ring, start_ring+1, stemscale+s6+p1);

  //-------------------------------------------------------------
  modring(offset,   aa, start_ring+1, start_ring+2, stemscale+s6+p2);
  modring(offset+1, aa, start_ring+1, start_ring+2, stemscale+s6+p2);
  modring(offset+2, aa, start_ring+1, start_ring+2, stemscale+s5+p2);
  modring(offset+3, aa, start_ring+1, start_ring+2, stemscale+s5+p2);
  modring(offset+4, aa, start_ring+1, start_ring+2, stemscale+s6+p2);
  modring(offset+5, aa, start_ring+1, start_ring+2, stemscale+s6+p2);

  //-------------------------------------------------------------
  modring(offset,   aa, start_ring+2, start_ring+3, stemscale+s6+p3);
  modring(offset+1, aa, start_ring+2, start_ring+3, stemscale+s6+p3);
  modring(offset+2, aa, start_ring+2, start_ring+3, stemscale+s5+p3);
  modring(offset+3, aa, start_ring+2, start_ring+3, stemscale+s5+p3);
  modring(offset+4, aa, start_ring+2, start_ring+3, stemscale+s6+p3);
  modring(offset+5, aa, start_ring+2, start_ring+3, stemscale+s6+p3);
  
  //-------------------------------------------------------------
  modring(offset,   aa, start_ring+3, start_ring+4, stemscale+s6+p4);
  modring(offset+1, aa, start_ring+3, start_ring+4, stemscale+s6+p4);
  modring(offset+2, aa, start_ring+3, start_ring+4, stemscale+s5+p4);
  modring(offset+3, aa, start_ring+3, start_ring+4, stemscale+s5+p4);
  modring(offset+4, aa, start_ring+3, start_ring+4, stemscale+s6+p4);
  modring(offset+5, aa, start_ring+3, start_ring+4, stemscale+s6+p4);
  
  if(offset==12)//fix the 2 lastparts that 'fell off'
  {
    modring(0, 64, start_ring, start_ring+1, stemscale+s6+p1);
    modring(1, 64, start_ring, start_ring+1, stemscale+s6+p1);
    
    modring(0, 64, start_ring+1, start_ring+2, stemscale+s6+p2);
    modring(1, 64, start_ring+1, start_ring+2, stemscale+s6+p2);
    
    modring(0, 64, start_ring+2, start_ring+3, stemscale+s6+p3);
    modring(1, 64, start_ring+2, start_ring+3, stemscale+s6+p3);
  
    modring(0, 64, start_ring+3, start_ring+4, stemscale+s6+p4);
    modring(1, 64, start_ring+3, start_ring+4, stemscale+s6+p4);
  }

  //----height
  float sh1=0, sh2=0, sh3=0, sh4=0, sh5=0;
  
  if(neworcopy==0) //new
  {  
    sh1=(random(80)-40.0f)-20.0f;
    sh2=sh1+random(2)+0.4f; 
    sh3=sh2+random(2)+0.4f;
    sh4=sh3+random(2)+0.4f;
    sh5=random(16)-8.0f;
  }
  if(neworcopy==1) //new
  {
    sh1=fl_8_sh1[whatflowercopy];
    sh2=fl_8_sh2[whatflowercopy];
    sh3=fl_8_sh3[whatflowercopy];
    sh4=fl_8_sh4[whatflowercopy];
    sh5=fl_8_sh5[whatflowercopy];
  }  
  fl_8_sh1[leaf]=sh1;
  fl_8_sh2[leaf]=sh2;
  fl_8_sh3[leaf]=sh3;
  fl_8_sh4[leaf]=sh4;
  fl_8_sh5[leaf]=sh5;
    
  modringheight(offset,   aa, start_ring, start_ring+1, sh1+sh5);
  modringheight(offset+1, aa, start_ring, start_ring+1, sh1+sh5);
  modringheight(offset+2, aa, start_ring, start_ring+1, sh1);
  modringheight(offset+3, aa, start_ring, start_ring+1, sh1);
  modringheight(offset+4, aa, start_ring, start_ring+1, sh1+sh5);
  modringheight(offset+5, aa, start_ring, start_ring+1, sh1+sh5);

  modringheight(offset,   aa, start_ring+1, start_ring+2, sh2+sh5);
  modringheight(offset+1, aa, start_ring+1, start_ring+2, sh2+sh5);
  modringheight(offset+2, aa, start_ring+1, start_ring+2, sh2);
  modringheight(offset+3, aa, start_ring+1, start_ring+2, sh2);
  modringheight(offset+4, aa, start_ring+1, start_ring+2, sh2+sh5);
  modringheight(offset+5, aa, start_ring+1, start_ring+2, sh2+sh5);

  modringheight(offset,   aa, start_ring+2, start_ring+3, sh3+sh5);
  modringheight(offset+1, aa, start_ring+2, start_ring+3, sh3+sh5);
  modringheight(offset+2, aa, start_ring+2, start_ring+3, sh3);
  modringheight(offset+3, aa, start_ring+2, start_ring+3, sh3);
  modringheight(offset+4, aa, start_ring+2, start_ring+3, sh3+sh5);
  modringheight(offset+5, aa, start_ring+2, start_ring+3, sh3+sh5);  

  modringheight(offset,   aa, start_ring+3, start_ring+4, sh4+sh5);
  modringheight(offset+1, aa, start_ring+3, start_ring+4, sh4+sh5);
  modringheight(offset+2, aa, start_ring+3, start_ring+4, sh4);
  modringheight(offset+3, aa, start_ring+3, start_ring+4, sh4);
  modringheight(offset+4, aa, start_ring+3, start_ring+4, sh4+sh5);
  modringheight(offset+5, aa, start_ring+3, start_ring+4, sh4+sh5);
 
  if(offset==12)//fix the 2 lastparts that 'fell off'
  {
    modringheight(0, 64, start_ring, start_ring+1, sh1+sh5);
    modringheight(1, 64, start_ring, start_ring+1, sh1+sh5);

    modringheight(0, 64, start_ring+1, start_ring+2, sh2+sh5);
    modringheight(1, 64, start_ring+1, start_ring+2, sh2+sh5);
    
    modringheight(0, 64, start_ring+2, start_ring+3, sh3+sh5);
    modringheight(1, 64, start_ring+2, start_ring+3, sh3+sh5);  
    
    modringheight(0, 64, start_ring+3, start_ring+4, sh4+sh5);
    modringheight(1, 64, start_ring+3, start_ring+4, sh4+sh5);
  }
}



void draw2_16(int start_ring, int offset, int leaf,int neworcopy) // 16 leaves
{
  //width
  
  float stemscale=0,s6=0;
  if(neworcopy==0) //new
  {  
    stemscale=random(50)+10.0f;
    s6=random(60)-30.0f;
  }
  
  if(neworcopy==1) //copy
  {
    stemscale=fl_16_stemscale[whatflowercopy];
    s6=fl_16_s6[whatflowercopy];
  }
  fl_16_stemscale[leaf]=stemscale;
  fl_16_s6[leaf]=s6;
 
  

  modring(offset,   8, start_ring, start_ring+1, stemscale+s6);
  modring(offset+1, 8, start_ring, start_ring+1, stemscale+s6);

  modring(offset,   8, start_ring+1, start_ring+2, stemscale+s6);
  modring(offset+1, 8, start_ring+1, start_ring+2, stemscale+s6);

  modring(offset,   8, start_ring+2, start_ring+3, stemscale+s6);
  modring(offset+1, 8, start_ring+2, start_ring+3, stemscale+s6);

  modring(offset,   8, start_ring+3, start_ring+4, stemscale+s6);
  modring(offset+1, 8, start_ring+3, start_ring+4, stemscale+s6);
  
  //----height
  float sh1=0, sh2=0, sh3=0, sh4=0;
  if(neworcopy==0) //new
  {  
    sh1=(random(80)-40.0f)-20.0f;
    sh2=sh1+(random(1)/10.0f)+0.1f;
    sh3=sh2+(random(1)/10.0f)+0.1f;
    sh4=sh3+(random(1)/10.0f)+0.1f;
  }
  if(neworcopy==1) //copy
  {
    sh1=fl_16_sh1[whatflowercopy];
    sh2=fl_16_sh2[whatflowercopy];
    sh3=fl_16_sh3[whatflowercopy];
    sh4=fl_16_sh4[whatflowercopy];
  }
  fl_16_sh1[leaf]= sh1;
  fl_16_sh2[leaf]= sh2;
  fl_16_sh3[leaf]= sh3;
  fl_16_sh4[leaf]= sh4;

  modringheight(offset,   8, start_ring, start_ring+1, sh1);
  modringheight(offset+1, 8, start_ring, start_ring+1, sh1);

  modringheight(offset,   8, start_ring+1, start_ring+2, sh2);
  modringheight(offset+1, 8, start_ring+1, start_ring+2, sh2);

  modringheight(offset,   8, start_ring+2, start_ring+3, sh3);
  modringheight(offset+1, 8, start_ring+2, start_ring+3, sh3);
  
  modringheight(offset,   8, start_ring+3, start_ring+4, sh4);
  modringheight(offset+1, 8, start_ring+3, start_ring+4, sh4);

}

//float stem_height=0.5f;
//float stem_width=2.0f;

void modring(int xstart, int xstep,int y1,int y2,float stemscale)
{
  for (int j=y1;j<y2;j++)
  {
    for (int i=xstart; i<64; i+=xstep)
    {
      spx[(j*64)+i]=cosd[i]*stemscale;
      spz[(j*64)+i]=sind[i]*stemscale;
    }
  }
}
void modring2_16(int xstart, int xstep,int y1,int y2,float stemscale)
{
  xstart=xstart+2;
  for (int j=y1;j<y2;j++)
  {
    for (int i=xstart; i<64; i+=xstep)
    {
      spx[(j*64)+i]=cosd[i]*stemscale;
      spz[(j*64)+i]=sind[i]*stemscale;
    }
  }
}

void modringheight(int xstart, int xstep,int y1,int y2,float theheight)
{
  
  for (int j=y1;j<y2;j++)
  {
    for (int i=xstart; i<64; i+=xstep)
    {
      spy[(j*64)+i]=theheight;
    }
  }
  
}



