// Texture Tool

void selecttexturetool()
{

}

void texture_shaderotate(int xy_or_z, float plus_or_min)// x=0 y=1 z=2 
{
  
  if (xy_or_z==0){bakerotate_x=bakerotate_x+plus_or_min;}
  if (xy_or_z==1){bakerotate_y=bakerotate_y+plus_or_min;}
  if (xy_or_z==2){bakerotate_z=bakerotate_z+plus_or_min;}

 // println(bakerotate_x+" - "+bakerotate_y+" - "+bakerotate_z);

  //copy 3dmodel to buffer  
  for (int i=0;i<64*64;i++)
  {
      spxbuf2[i]=spx[i];
      spybuf2[i]=spy[i];
      spzbuf2[i]=spz[i];
  }
  //now get the matrix ready for rotation    
  matbasic(mat1);
  matrotx(mat1, bakerotate_x);//rotate around X
  matbasic(mat2);
  matrotx(mat2, bakerotate_y); //rotate around X
  addmat(mat0,mat1,mat2);
  matcopy(mat1, mat0);
  matbasic(mat2);
  matrotz(mat2,bakerotate_z);//rotate around Z
  addmat(mat0,mat1,mat2); // my rotation matrix on x,y and z is now in mat0
  texture_finmat_shaderrotate(mat0);//rotate the buffer now
  
  //and bake the texture now based on the 3dbuffer rotation
  texture_bake(1);
  
  //finmat(mat0,0,points);  
}

//rotate the whole buffer 
void texture_finmat_shaderrotate(float matrix[])
{
  float xo,yo,zo;
  for (int i=0; i<64*64; i++)
  {
     xo=spxbuf2[i];
     yo=spybuf2[i];
     zo=spzbuf2[i];     
     spxbuf2[i]=xo*matrix[0]+yo*matrix[1]+zo*matrix[2]+matrix[3];
     spybuf2[i]=xo*matrix[4]+yo*matrix[5]+zo*matrix[6]+matrix[7];
     spzbuf2[i]=xo*matrix[8]+yo*matrix[9]+zo*matrix[10]+matrix[11];
  }
}

void texture_normalmap_test()
{
  texture_bake_r=true;
  texture_bake_g=true;
  texture_bake_b=true;
  
  texture_bake_rgrey=false;
  texture_bake_ggrey=false;
  texture_bake_bgrey=false;

  texture_bake(0);
  
  //switch blue to green and invert blue channel
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    { 
      int vr= ((texture_normalbuff.pixels[(j*64)+i] >> 16) & 0xff);
      int vg= ((texture_normalbuff.pixels[(j*64)+i] >> 8) & 0xff);
      int vb= ((texture_normalbuff.pixels[(j*64)+i]  ) & 0xff);
      drawpoint2(texbake_m1.pixels, i, j, 64, vr, vb, 255-vg);// normal texture image  
    }
  }

  
  if(texturesize==0)
  {
    textureimg.copy(texbake_m1, 0, 0, 64, 64, 0, 0, 256, 256);
    textureimg.updatePixels();  
  }  
  if(texturesize==1)
  {
    textureimg512.copy(texbake_m1, 0, 0, 64, 64, 0, 0, 512, 512);
    textureimg512.updatePixels();  
  } 
  
}

/*
void rotate_normalmap()
{
  println("rotator!");
  
  matbasic(mat1);
  matrotx(mat1, 1.1);
  
   texture_matmodel(mat1);

  
}

void texture_matmodel(float matrix[])
{
  for (int j=0; j<64; j++)
  {
    for (int i=0; i<64; i++)
    {
     float xo=spx[(j*64)+i];
     float yo=spy[(j*64)+i];
     float zo=spz[(j*64)+i];     
     spx[(j*64)+i]=(xo*matrix[0]+yo*matrix[1]+zo*matrix[2]+matrix[3]);
     spy[(j*64)+i]=xo*matrix[4]+yo*matrix[5]+zo*matrix[6]+matrix[7];
     spz[(j*64)+i]=xo*matrix[8]+yo*matrix[9]+zo*matrix[10]+matrix[11];
    }
  }
}
*/
void texture_bake(int model_or_buffer)
{
  
  texture_lighton=false; //turn off lightning


  if(model_or_buffer==0)
  {
    texture_vector(0);
  }
  if(model_or_buffer==1)
  {
    texture_vector(1);
  }
  
  //bake the texture
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    { 
      int vr= ((texture_normalbuff.pixels[(j*64)+i] >> 16) & 0xff);
      int vg= ((texture_normalbuff.pixels[(j*64)+i] >> 8) & 0xff);
      int vb= ((texture_normalbuff.pixels[(j*64)+i]  ) & 0xff);
      if (texture_bake_r==false){vr=0;}
      if (texture_bake_g==false){vg=0;}
      if (texture_bake_b==false){vb=0;}
      
      if (texture_bake_rgrey==true)
      {
        vg=(vr+vg)/2;
        vb=(vr+vb)/2;
      }
      if (texture_bake_ggrey==true)
      {
        vr=(vr+vg)/2;
        vb=(vg+vb)/2;
      }
      if (texture_bake_bgrey==true)
      {
        vr=(vb+vr)/2;
        vg=(vb+vg)/2;
      }
      
      if (texture_bake_rgrey==true && texture_bake_ggrey==true && texture_bake_bgrey==true)
      {
        vr=(vr+vg+vb)/3;
        vg=vr;
        vb=vr;        
      }      
      
      
      drawpoint2(texbake_m1.pixels, i, j, 64, vr, vg, vb);// normal texture image      
    }
  }

  //find max color white
  int maxr=0;
  int maxg=0;
  int maxb=0;
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    { 
      int vr= ((texbake_m1.pixels[(j*64)+i] >> 16) & 0xff);
      int vg= ((texbake_m1.pixels[(j*64)+i] >> 8) & 0xff);
      int vb= ((texbake_m1.pixels[(j*64)+i]  ) & 0xff);
      if(vr>maxr){maxr=vr;}
      if(vg>maxg){maxg=vg;}
      if(vb>maxb){maxb=vb;}
    }
  }
  if (texture_bake_r==false){maxr=0;}else{maxr=255-maxr;}
  if (texture_bake_g==false){maxg=0;}else{maxg=255-maxg;}
  if (texture_bake_b==false){maxb=0;}else{maxb=255-maxb;}
  
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    { 
      int vr= ((texbake_m1.pixels[(j*64)+i] >> 16) & 0xff)+maxr;
      int vg= ((texbake_m1.pixels[(j*64)+i] >> 8) & 0xff)+maxg;
      int vb= ((texbake_m1.pixels[(j*64)+i]  ) & 0xff)+maxb;
      drawpoint2(texbake_m1.pixels, i, j, 64, vr, vg, vb);// normal texture image            
    }
  }
  
  if(texturesize==0)
  {
    textureimg.copy(texbake_m1, 0, 0, 64, 64, 0, 0, 256, 256);
    textureimg.updatePixels();  
  }  
  if(texturesize==1)
  {
    textureimg512.copy(texbake_m1, 0, 0, 64, 64, 0, 0, 512, 512);
    textureimg512.updatePixels();  
  }         
}


void texture_vector(int modelorbuffer)// create the shading texture based on 3dmodel or 3dmodel buffer
{
//  vector3f v1,v2,v3;
  vector3f v1 = new vector3f();
  vector3f v2 = new vector3f();
  vector3f v3 = new vector3f();
  
  //calculate normals 
  for (int j=0;j<63;j++)
  {
    for (int i=0;i<63;i++)
    {
      if(modelorbuffer==0)
      {
        v1.vector3f_points_to_vector(spx[(j*64)+i],spy[(j*64)+i],spz[(j*64)+i], spx[(j*64)+i+1],spy[(j*64)+i+1],spz[(j*64)+i+1]);
        v2.vector3f_points_to_vector(spx[(j*64)+i+1],spy[(j*64)+i+1],spz[(j*64)+i+1], spx[((j+1)*64)+i],spy[((j+1)*64)+i],spz[((j+1)*64)+i]);
      }
      if(modelorbuffer==1)
      {
        v1.vector3f_points_to_vector(spxbuf2[(j*64)+i],spybuf2[(j*64)+i],spzbuf2[(j*64)+i], spxbuf2[(j*64)+i+1],spybuf2[(j*64)+i+1],spzbuf2[(j*64)+i+1]);
        v2.vector3f_points_to_vector(spxbuf2[(j*64)+i+1],spybuf2[(j*64)+i+1],spzbuf2[(j*64)+i+1], spxbuf2[((j+1)*64)+i],spybuf2[((j+1)*64)+i],spzbuf2[((j+1)*64)+i]);
      }
      v3.vector3f_crossproduct(v1,v2); // cross product: surface normal
      v3.vector3f_normalize(); //unit normal vector: vector now between -1 and +1

      int vr=(int)((v3.x+1.0f) * 127.5f);
      int vg=(int)((v3.y+1.0f) * 127.5f);
      int vb=(int)((v3.z+1.0f) * 127.5f);
      drawpoint2(texture_normalbuff.pixels, i, j, 64, vr, vg, vb);// normal texture image      
    }
  }
  //calculate normals - right line
  if(rendertype!=3) //dont do for plane type
  {
    for (int j=0;j<63;j++)
    {
      for (int i=63;i<64;i++)
      {
        if(modelorbuffer==0)
        {
          v1.vector3f_points_to_vector(spx[(j*64)+i],spy[(j*64)+i],spz[(j*64)+i], spx[(j*64)+0],spy[(j*64)+0],spz[(j*64)+0]);
          v2.vector3f_points_to_vector(spx[(j*64)+0],spy[(j*64)+0],spz[(j*64)+0], spx[((j+1)*64)+0],spy[((j+1)*64)+0],spz[((j+1)*64)+0]);      
        }
        if(modelorbuffer==1)
        {
          v1.vector3f_points_to_vector(spxbuf2[(j*64)+i],spybuf2[(j*64)+i],spzbuf2[(j*64)+i], spxbuf2[(j*64)+0],spybuf2[(j*64)+0],spzbuf2[(j*64)+0]);
          v2.vector3f_points_to_vector(spxbuf2[(j*64)+0],spybuf2[(j*64)+0],spzbuf2[(j*64)+0], spxbuf2[((j+1)*64)+0],spybuf2[((j+1)*64)+0],spzbuf2[((j+1)*64)+0]);      
        }
        
        v3.vector3f_crossproduct(v1,v2); // cross product: surface normal
        v3.vector3f_normalize(); //unit normal vector: vector now between -1 and +1
        int vr=(int)((v3.x+1.0f) * 127.5f);
        int vg=(int)((v3.y+1.0f) * 127.5f);
        int vb=(int)((v3.z+1.0f) * 127.5f);
        drawpoint2(texture_normalbuff.pixels, i, j, 64, vr, vg, vb);// normal texture image      
      }
    }
  }
  if (rendertype==3)//plane type copy 62 to 63
  {
    for (int j=0;j<64;j++)
    {
      for (int i=63;i<64;i++)
      { 
        int vr= ((texture_normalbuff.pixels[((j)*64)+i-1] >> 16) & 0xff);
        int vg= ((texture_normalbuff.pixels[((j)*64)+i-1] >> 8) & 0xff);
        int vb= ((texture_normalbuff.pixels[((j)*64)+i-1]  ) & 0xff);
        drawpoint2(texture_normalbuff.pixels, i, j, 64, vr, vg, vb);// normal texture image      
      }
    }
  }

  // bottom line just copy 62 to 63
  for (int j=63;j<64;j++)
  {
    for (int i=0;i<64;i++)
    { 
      int vr= ((texture_normalbuff.pixels[((j-1)*64)+i] >> 16) & 0xff);
      int vg= ((texture_normalbuff.pixels[((j-1)*64)+i] >> 8) & 0xff);
      int vb= ((texture_normalbuff.pixels[((j-1)*64)+i]  ) & 0xff);
      drawpoint2(texture_normalbuff.pixels, i, j, 64, vr, vg, vb);// normal texture image      
    }
  }

}

static class vector3f
{
  float x, y, z;

  vector3f()
  {
  }

  vector3f(float x, float y, float z)
  {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void vector3f_points_to_vector(float x1,float y1,float z1, float x2,float y2,float z2)
  {
    x=x1-x2;
    y=y1-y2;
    z=z1-z2;
  }
  
  void vector3f_crossproduct(vector3f vec1, vector3f vec2)
  {
    x=vec1.y*vec2.z - vec1.z*vec2.y;
    y=vec1.z*vec2.x - vec1.x*vec2.z;
    z=vec1.x*vec2.y - vec1.y*vec2.x;
  }  
  void vector3f_normalize()
  {
    float v_length = vector3f_length();
    if(v_length == 0.0f){ v_length = 1.0f;} // no divide by 0 error
    x /= v_length;
    y /= v_length;
    z /= v_length;
  }

  float vector3f_length()
  {
    return (float) sqrt( (x * x) + (y * y) + (z * z) );
  }  
}

void texture_colorpick(int x, int y, int background[],int w)
{
  int offset=(y*w)+x;
  color_tex_r = (background[offset] >> 16) & 0xff;
  color_tex_g = (background[offset] >>  8) & 0xff;
  color_tex_b =  background[offset] & 0xff;
  
  drawcolorbar_rgb();
}

void drawcolorbars()
{
  colorbar_r.loadPixels();
  colorbar_g.loadPixels();
  colorbar_b.loadPixels();
  for (int j=0;j<16;j++)
  {
    for (int i=0;i<256;i++)
    {
      drawpoint2( colorbar_r.pixels,  i,j, 256,  i, 0, 0);
      drawpoint2( colorbar_g.pixels,  i,j, 256,  0, i, 0);
      drawpoint2( colorbar_b.pixels,  i,j, 256,  0, 0, i);      
    }  
  }
  //greylines
  
  for (int j=0;j<1;j++)
  {
    for (int i=0;i<256;i++)
    {
      drawpoint2( colorbar_r.pixels,  i,j, 256,  100, 100, 100);
      drawpoint2( colorbar_g.pixels,  i,j, 256,  100, 100, 100);
      drawpoint2( colorbar_b.pixels,  i,j, 256,  100, 100, 100);
    }
  }
  for (int j=15;j<16;j++)
  {
    for (int i=0;i<256;i++)
    {
      drawpoint2( colorbar_r.pixels,  i,j, 256,  100, 100, 100);
      drawpoint2( colorbar_g.pixels,  i,j, 256,  100, 100, 100);
      drawpoint2( colorbar_b.pixels,  i,j, 256,  100, 100, 100);
    }
  }
  
  colorbar_b.updatePixels();
  colorbar_g.updatePixels();
  colorbar_r.updatePixels();
  
  drawcolorbar_rgb();
}

void drawcolorbar_rgb()
{
  colorbar_rgb.loadPixels();
  for (int j=0;j<16;j++)
  {
    for (int i=0;i<16;i++)
    {
      drawpoint2( colorbar_rgb.pixels,  i,j, 16,  color_tex_r, color_tex_g, color_tex_b);
    }
  }  
  colorbar_rgb.updatePixels();

}

void drawsprite3( int mask[], int background[], int xpos, int ypos, int xsize, int ysize, int xscale, int yscale, double cr2, double cg2, double  cb2, int texturescale)
{
int xcut=0;
int ycut=0;

int wxx=texturescale; //256
int wyy=texturescale;
int offset,softset, duhx, duhy;

double cr1,cg1,cb1,mo; //cr2,cg2,cb2,
double cr3,cg3,cb3;

double xs4,ys4,supuh;
double ii, jj, xsi;

int ax1=xpos-(xscale/2);
int ay1=ypos-(yscale/2);

xs4=(double) xsize/xscale;
ys4=(double) ysize/yscale;

	for (int i=0;i<yscale;i++)
	{
	for (int j=0;j<xscale;j++)
		{

			xcut=0;
			ycut=0;
			if ((j+ax1) < 0){ xcut=1;}	//kleiner
			if ((i+ay1) < 0){ ycut=1;}

			if ((j+ax1) > (wxx-1)){xcut=2;}	//groter
			if ((i+ay1) > (wyy-1)){ycut=2;}	//

			offset= ((i+ay1) * wyy) + (j+ax1);

			if (xcut==1 && ycut==0) {offset= ((i+ay1) * wyy) + (j+ax1)+(wxx);}
			if (xcut==2 && ycut==0)	{offset= ((i+ay1) * wyy) + (j+ax1)-(wxx);}

			if (xcut==0 && ycut==1)	{offset= ((i+ay1+wyy) * wyy) + (j+ax1);}
			if (xcut==0 && ycut==2)	{offset= ((i+ay1-wyy) * wyy) + (j+ax1);}


			if (xcut==1 && ycut==1)	{offset= ((i+ay1+wyy) * wyy) + (j+ax1)+(wxx);}
			if (xcut==1 && ycut==2)	{offset= ((i+ay1-wyy) * wyy) + (j+ax1)+(wxx);}

			if (xcut==2 && ycut==1)	{offset= ((i+ay1+wyy) * wyy) + (j+ax1)-(wxx);}
			if (xcut==2 && ycut==2)	{offset= ((i+ay1-wyy) * wyy) + (j+ax1)-(wxx);}
			

			ii=(double) i;
			jj=(double) j;
			xsi=(double) xsize;

			duhy= (int) (ii*ys4);
			duhx= (int) (jj*xs4);

			softset= (duhy * xsize) + duhx;

			if (softset<0){softset=0;}
			if (softset>(xsize*ysize)-1){softset=(xsize*ysize)-1;}


			mo = mask[softset]  & 0xff;
                        mo=mo-(255-(brush_opacity*2));
                        //if(mo<0){mo=0;}

			
			if (mo>0)
			{
			  //cr2 = (sprite[softset] >> 16) & 0xff; // color
		          //cg2 = (sprite[softset] >>  8) & 0xff;
			  //cb2 =  sprite[softset] & 0xff;
			  //cr2 = ; // color
		          //cg2 = ;
			  //cb2 = ;


			  cr1 = (background[offset] >> 16) & 0xff;
		          cg1 = (background[offset] >>  8) & 0xff;
			  cb1 =  background[offset] & 0xff;
                          
                          
			  cr1 =(((cr2-cr1)/256)* mo) + cr1;
			  cg1 =(((cg2-cg1)/256)* mo) + cg1;
			  cb1 =(((cb2-cb1)/256)* mo) + cb1;//brush_opacity

                          /*      
			  cr3 =(((cr2-cr1)/256)* mo) + cr1;
			  cg3 =(((cg2-cg1)/256)* mo) + cg1;
			  cb3 =(((cb2-cb1)/256)* mo) + cb1;//brush_opacity

                          cr1 = ((cr3*brush_opacity)  +  (cr1*(128-brush_opacity)))  / 128;
                          cg1 = ((cg3*brush_opacity)  +  (cg1*(128-brush_opacity)))  / 128;
                          cg1 = ((cb3*brush_opacity)  +  (cb1*(128-brush_opacity)))  / 128;
                          */


			  int colr=(int)cr1;
			  int colg=(int)cg1;
			  int colb=(int)cb1;

	                  background[offset] =  ( (0xff<<24) | (colr<<16) | (colg<<8) | colb);
			}
		}
	}

}

//------------filter it matrixxxx time-------------------------	
//filter2(pix1, 256, 256);

void filter256(int filterimg[],int pix3[], int fw, int fh)
{
  int rrr1,ggg1,bbb1,vindex,rr,gg,bb;

  for (int index2=0, y=0; y<(fh-2);y++) 
  { 
    for (int x=0;x<(fw-2);x++) 
    {			
      index2= x + (y * fw);
      rr=0; 
      gg=0;	
      bb=0;
      for (int xxx=0;xxx<3;xxx++) 
      {
        for (int yyy=0;yyy<3;yyy++) 
        {
          vindex=(index2 + xxx) + (yyy * fw);
          rrr1 = (filterimg[vindex] >> 16) & 0xff;
          ggg1 = (filterimg[vindex] >>  8) & 0xff;
          bbb1 = (filterimg[vindex]) & 0xff;

          rr = (rrr1 * filtermat[xxx][yyy]) + rr;
          gg = (ggg1 * filtermat[xxx][yyy]) + gg;
          bb = (bbb1 * filtermat[xxx][yyy]) + bb;
        } 
      }

      rr= rr / deelmat;
      gg= gg / deelmat;
      bb= bb / deelmat;
      if (rr > 255){rr=255;} 
      if (gg > 255){gg=255;} 
      if (bb > 255){bb=255;}
      if (rr < 0){rr=0;}
      if (gg < 0){gg=0;} 
      if (bb < 0){bb=0;}
      vindex=(index2+1)+(fw);
      pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
    } 
  }
			
  // top line ---
  for (int x=0, index2=0;x<(256-2);x++) 
  {			
    index2= x;
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<3;xxx++) 
    {			
      for (int yyy=0;yyy<2;yyy++) 
      {			
        vindex=(index2 + xxx) + (yyy * 256);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
        ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
        rr = (rrr1 * filtermat[xxx][yyy+1]) + rr;
	gg = (ggg1 * filtermat[xxx][yyy+1]) + gg;
	bb = (bbb1 * filtermat[xxx][yyy+1]) + bb;	
      } 
    }
    index2= x + (255 * 256);
    for (int xxx=0;xxx<3;xxx++) 
    {					
      vindex=(index2 + xxx);
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[xxx][0]) + rr;
      gg = (ggg1 * filtermat[xxx][0]) + gg;
      bb = (bbb1 * filtermat[xxx][0]) + bb;
    }
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=(x+1);
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 

  // bottom line ---       
  for (int x=0, index2=0;x<(256-2);x++)
  {			
    index2= x + ((256-2) * 256);
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<3;xxx++) 
    {			
      for (int yyy=0;yyy<2;yyy++) 
      {			
        vindex=(index2 + xxx) + (yyy * 256);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
	ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
	rr = (rrr1 * filtermat[xxx][yyy]) + rr;
	gg = (ggg1 * filtermat[xxx][yyy]) + gg;
	bb = (bbb1 * filtermat[xxx][yyy]) + bb;
	
      } 
    }
    index2= x ;
    for (int xxx=0;xxx<3;xxx++) 
    {					
      vindex=(index2 + xxx);
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[xxx][2]) + rr;
      gg = (ggg1 * filtermat[xxx][2]) + gg;
      bb = (bbb1 * filtermat[xxx][2]) + bb;
    } 				
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=(x+1) + (255*256);
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 

  // left line ---       
  for (int y=0, index2=0;y<(256-2);y++) 
  {
    index2= (y*256);
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<2;xxx++) 
    {			
      for (int yyy=0;yyy<3;yyy++) 
      {			
        vindex=(index2 + xxx) + (yyy * 256);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
        ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
        rr = (rrr1 * filtermat[xxx+1][yyy]) + rr;
	gg = (ggg1 * filtermat[xxx+1][yyy]) + gg;
	bb = (bbb1 * filtermat[xxx+1][yyy]) + bb;
      } 
    }
    index2= (y*256)+ 255;
    for (int yyy=0;yyy<3;yyy++) 
    {					
      vindex=(index2 + (yyy*256));
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[0][yyy]) + rr;
      gg = (ggg1 * filtermat[0][yyy]) + gg;
      bb = (bbb1 * filtermat[0][yyy]) + bb;
    }
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=((y+1) * 256) ;
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 

  // right line ---       
  for (int y=0, index2=0;y<(256-2);y++) 
  {			
    index2= (y*256) + (256-2);
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<2;xxx++) 
    {
      for (int yyy=0;yyy<3;yyy++) 
      {
        vindex=(index2 + xxx) + (yyy * 256);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
	ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
        rr = (rrr1 * filtermat[xxx][yyy]) + rr;
	gg = (ggg1 * filtermat[xxx][yyy]) + gg;
	bb = (bbb1 * filtermat[xxx][yyy]) + bb;
      } 
    }
    index2= (y*256);				
    for (int yyy=0;yyy<3;yyy++) 
    {
      vindex=(index2 + (yyy*256));
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[2][yyy]) + rr;
      gg = (ggg1 * filtermat[2][yyy]) + gg;
      bb = (bbb1 * filtermat[2][yyy]) + bb;
    }
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=((y+1) * 256) + 255;
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 
			
  // 0 , 0
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=256;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=1 + 256;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;
  vindex=256-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=255 + 256;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=256 * 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(256 * 255) + 1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(256 * 255) + 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;
  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=0;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);

  // 255 , 0
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=256;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;			
  vindex=256-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=256-2;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=255 + 256;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=(256-2) + 256;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=256 * 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(256 * 255) + 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(256 * 255) + (256-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;

  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=256-1;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);

  // 255 , 255
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;
  vindex=256-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=256-2;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=256 * 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=256 * (256-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(256 * 255) + 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=(256 * 255) + (256-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=(256 * (256-2)) + 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(256 * (256-2)) + (256-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;
  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=(256*255) + 255;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);

  // 0, 255
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;
  vindex=256-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=256 * 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=(256 * 255)+1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=256 * (256-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(256 * (256-2))+1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(256 * 255) + 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=(256 * (256-2)) + 255;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;
  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=256 * 255;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
}

//------------filter it matrixxxx time 512 -------------------------	

void filter512(int filterimg[],int pix3[], int fw, int fh)
{
  int rrr1,ggg1,bbb1,vindex,rr,gg,bb;

  for (int index2=0, y=0; y<(fh-2);y++) 
  { 
    for (int x=0;x<(fw-2);x++) 
    {			
      index2= x + (y * fw);
      rr=0; 
      gg=0;	
      bb=0;
      for (int xxx=0;xxx<3;xxx++) 
      {
        for (int yyy=0;yyy<3;yyy++) 
        {
          vindex=(index2 + xxx) + (yyy * fw);
          rrr1 = (filterimg[vindex] >> 16) & 0xff;
          ggg1 = (filterimg[vindex] >>  8) & 0xff;
          bbb1 = (filterimg[vindex]) & 0xff;

          rr = (rrr1 * filtermat[xxx][yyy]) + rr;
          gg = (ggg1 * filtermat[xxx][yyy]) + gg;
          bb = (bbb1 * filtermat[xxx][yyy]) + bb;
        } 
      }

      rr= rr / deelmat;
      gg= gg / deelmat;
      bb= bb / deelmat;
      if (rr > 255){rr=255;} 
      if (gg > 255){gg=255;} 
      if (bb > 255){bb=255;}
      if (rr < 0){rr=0;}
      if (gg < 0){gg=0;} 
      if (bb < 0){bb=0;}
      vindex=(index2+1)+(fw);
      pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
    } 
  }
			
  // top line ---
  for (int x=0, index2=0;x<(512-2);x++) 
  {			
    index2= x;
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<3;xxx++) 
    {			
      for (int yyy=0;yyy<2;yyy++) 
      {			
        vindex=(index2 + xxx) + (yyy * 512);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
        ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
        rr = (rrr1 * filtermat[xxx][yyy+1]) + rr;
	gg = (ggg1 * filtermat[xxx][yyy+1]) + gg;
	bb = (bbb1 * filtermat[xxx][yyy+1]) + bb;	
      } 
    }
    index2= x + (511 * 512);
    for (int xxx=0;xxx<3;xxx++) 
    {					
      vindex=(index2 + xxx);
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[xxx][0]) + rr;
      gg = (ggg1 * filtermat[xxx][0]) + gg;
      bb = (bbb1 * filtermat[xxx][0]) + bb;
    }
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=(x+1);
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 

  // bottom line ---       
  for (int x=0, index2=0;x<(512-2);x++)
  {			
    index2= x + ((512-2) * 512);
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<3;xxx++) 
    {			
      for (int yyy=0;yyy<2;yyy++) 
      {			
        vindex=(index2 + xxx) + (yyy * 512);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
	ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
	rr = (rrr1 * filtermat[xxx][yyy]) + rr;
	gg = (ggg1 * filtermat[xxx][yyy]) + gg;
	bb = (bbb1 * filtermat[xxx][yyy]) + bb;
	
      } 
    }
    index2= x ;
    for (int xxx=0;xxx<3;xxx++) 
    {					
      vindex=(index2 + xxx);
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[xxx][2]) + rr;
      gg = (ggg1 * filtermat[xxx][2]) + gg;
      bb = (bbb1 * filtermat[xxx][2]) + bb;
    } 				
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=(x+1) + (511*512);
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 

  // left line ---       
  for (int y=0, index2=0;y<(512-2);y++) 
  {
    index2= (y*512);
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<2;xxx++) 
    {			
      for (int yyy=0;yyy<3;yyy++) 
      {			
        vindex=(index2 + xxx) + (yyy * 512);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
        ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
        rr = (rrr1 * filtermat[xxx+1][yyy]) + rr;
	gg = (ggg1 * filtermat[xxx+1][yyy]) + gg;
	bb = (bbb1 * filtermat[xxx+1][yyy]) + bb;
      } 
    }
    index2= (y*512)+ 511;
    for (int yyy=0;yyy<3;yyy++) 
    {					
      vindex=(index2 + (yyy*512));
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[0][yyy]) + rr;
      gg = (ggg1 * filtermat[0][yyy]) + gg;
      bb = (bbb1 * filtermat[0][yyy]) + bb;
    }
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=((y+1) * 512) ;
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 

  // right line ---       
  for (int y=0, index2=0;y<(512-2);y++) 
  {			
    index2= (y*512) + (512-2);
    rr=0; gg=0;	bb=0;
    for (int xxx=0;xxx<2;xxx++) 
    {
      for (int yyy=0;yyy<3;yyy++) 
      {
        vindex=(index2 + xxx) + (yyy * 512);
        rrr1 = (filterimg[vindex] >> 16) & 0xff;
	ggg1 = (filterimg[vindex] >>  8) & 0xff;
        bbb1 = (filterimg[vindex]) & 0xff;
        rr = (rrr1 * filtermat[xxx][yyy]) + rr;
	gg = (ggg1 * filtermat[xxx][yyy]) + gg;
	bb = (bbb1 * filtermat[xxx][yyy]) + bb;
      } 
    }
    index2= (y*512);				
    for (int yyy=0;yyy<3;yyy++) 
    {
      vindex=(index2 + (yyy*512));
      rrr1 = (filterimg[vindex] >> 16) & 0xff;
      ggg1 = (filterimg[vindex] >>  8) & 0xff;
      bbb1 = (filterimg[vindex]) & 0xff;
      rr = (rrr1 * filtermat[2][yyy]) + rr;
      gg = (ggg1 * filtermat[2][yyy]) + gg;
      bb = (bbb1 * filtermat[2][yyy]) + bb;
    }
    rr= rr / deelmat;
    gg= gg / deelmat;
    bb= bb / deelmat;
    if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
    if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
    vindex=((y+1) * 512) + 511;
    pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);
  } 
			
  // 0 , 0
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=512;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=1 + 512;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;
  vindex=512-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=511 + 512;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=512 * 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(512 * 511) + 1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(512 * 511) + 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;
  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=0;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);

  // 255 , 0
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=512;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;			
  vindex=512-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=512-2;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=511 + 512;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=(512-2) + 512;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=512 * 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(512 * 511) + 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(512 * 511) + (512-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;

  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=512-1;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);

  // 255 , 255
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;
  vindex=512-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=512-2;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=512 * 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=512 * (512-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(512 * 511) + 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=(512 * 511) + (512-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=(512 * (512-2)) + 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(512 * (512-2)) + (512-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;
  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=(512*511) + 511;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);

  // 0, 255
  rr=0; gg=0;	bb=0;
  vindex=0;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][2]) + bb;
  vindex=1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][2]) + bb;
  vindex=512-1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][2]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][2]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][2]) + bb;
  vindex=512 * 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][1]) + bb;
  vindex=(512 * 511)+1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][1]) + bb;
  vindex=512 * (512-2);
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[1][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[1][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[1][0]) + bb;
  vindex=(512 * (512-2))+1;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[2][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[2][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[2][0]) + bb;
  vindex=(512 * 511) + 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][1]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][1]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][1]) + bb;
  vindex=(512 * (512-2)) + 511;
  rr = (((filterimg[vindex] >> 16) & 0xff) * filtermat[0][0]) + rr;
  gg = (((filterimg[vindex] >> 8) & 0xff) * filtermat[0][0]) + gg;
  bb = ((filterimg[vindex] & 0xff) * filtermat[0][0]) + bb;
  rr= rr / deelmat;
  gg= gg / deelmat;
  bb= bb / deelmat;
  if (rr > 255){rr=255;} if (gg > 255){gg=255;} if (bb > 255){bb=255;}
  if (rr < 0){rr=0;} if (gg < 0){gg=0;} if (bb < 0){bb=0;}
  vindex=512 * 511;
  pix3[vindex] = ((0xff << 24) | ( rr << 16) | ( gg << 8) | bb);  
}

///filters
void texture_filter01()  //gauss
{
		filtermat[0][0] = 1;	filtermat[1][0] = 2;	filtermat[2][0] = 1;
		filtermat[0][1] = 2;	filtermat[1][1] = 4;	filtermat[2][1] = 2;
		filtermat[0][2] = 1;	filtermat[1][2] = 2;	filtermat[2][2] = 1;
		deelmat=16;
  texture_dothatfilter();
}

void texture_filter02()  //  do filter...x-grad
{  
		filtermat[0][0] = 1;	filtermat[1][0] = 1;	filtermat[2][0] = 1;
		filtermat[0][1] = 1;	filtermat[1][1] = 0;	filtermat[2][1] = -1;
		filtermat[0][2] = -1;	filtermat[1][2] = -1;	filtermat[2][2] = -1;
		deelmat=1;
  texture_dothatfilter();
}

void texture_filter03()//  y-grad
{  
		filtermat[0][0] = -1;	filtermat[1][0] = -1;	filtermat[2][0] = -1;
		filtermat[0][1] = -1;	filtermat[1][1] = 0;	filtermat[2][1] = 1;
		filtermat[0][2] = 1;	filtermat[1][2] = 1;	filtermat[2][2] = 1;
		deelmat=1;
  texture_dothatfilter();
}

void texture_filter04()  	//  do filter... laplace 
{  
		filtermat[0][0] = 0;	filtermat[1][0] = 1;	filtermat[2][0] = 0;
		filtermat[0][1] = 1;	filtermat[1][1] = -4;	filtermat[2][1] = 1;
		filtermat[0][2] = 0;	filtermat[1][2] = 1;	filtermat[2][2] = 0;
		deelmat=1;
  texture_dothatfilter();
}

void texture_filter05()  	// do filter... laplace 2
{  
		filtermat[0][0] = 0;	filtermat[1][0] = -1;	filtermat[2][0] = 0;
		filtermat[0][1] = -1;	filtermat[1][1] = 8;	filtermat[2][1] = -1;
		filtermat[0][2] = 0;	filtermat[1][2] = -1;	filtermat[2][2] = 0;
		deelmat=4;
  texture_dothatfilter();
}

void texture_filter06()  	// do filter... gridd
{  
		filtermat[0][0] = -1;	filtermat[1][0] = 1;	filtermat[2][0] = -1;
		filtermat[0][1] = 1;	filtermat[1][1] = 4;	filtermat[2][1] = 1;
		filtermat[0][2] = -1;	filtermat[1][2] = 1;	filtermat[2][2] = -1;
		deelmat=4;
  texture_dothatfilter();
}

void texture_filter07()  	// do filter... gridh
{  
		filtermat[0][0] = -1;	filtermat[1][0] = 1;	filtermat[2][0] = -1;
		filtermat[0][1] = 1;	filtermat[1][1] = 4;	filtermat[2][1] = 1;
		filtermat[0][2] = -1;	filtermat[1][2] = 1;	filtermat[2][2] = -1;
		deelmat=6; 
  texture_dothatfilter();
}

void texture_filter08()  	// do filter... dowh
{  
		filtermat[0][0] = 1;	filtermat[1][0] = 1;	filtermat[2][0] = 1;
		filtermat[0][1] = 1;	filtermat[1][1] = -4;	filtermat[2][1] = 1;
		filtermat[0][2] = 1;	filtermat[1][2] = 1;	filtermat[2][2] = 1;
		deelmat=4; 
  texture_dothatfilter();
}

void texture_filter09()  	// do filter... growd
{  
		filtermat[0][0] = 1;	filtermat[1][0] = -1;	filtermat[2][0] = 1;
		filtermat[0][1] = -1;	filtermat[1][1] = 4;	filtermat[2][1] = -1;
		filtermat[0][2] = 1;	filtermat[1][2] = -1;	filtermat[2][2] = 1;
		deelmat=4; 
  texture_dothatfilter();
}

void texture_filter10()  	// do filter... growh
{  
		filtermat[0][0] = 1;	filtermat[1][0] = -1;	filtermat[2][0] = 1;
		filtermat[0][1] = -1;	filtermat[1][1] = 4;	filtermat[2][1] = -1;
		filtermat[0][2] = 1;	filtermat[1][2] = -1;	filtermat[2][2] = 1;
		deelmat=6; 
  texture_dothatfilter();
}

void texture_filter11()	// do filter... huhx
{  
		filtermat[0][0] = -1;	filtermat[1][0] = 0;	filtermat[2][0] = 1;
		filtermat[0][1] = 0;	filtermat[1][1] = 4;	filtermat[2][1] = 0;
		filtermat[0][2] = 1;	filtermat[1][2] = 0;	filtermat[2][2] = -1;
		deelmat=4; 
  texture_dothatfilter();
}

void texture_filter12()	// do filter... huhy
{  
		filtermat[0][0] = 1;	filtermat[1][0] = 0;	filtermat[2][0] = -1;
		filtermat[0][1] = 0;	filtermat[1][1] = 4;	filtermat[2][1] = 0;
		filtermat[0][2] = -1;	filtermat[1][2] = 0;	filtermat[2][2] = 1;
		deelmat=4;
  texture_dothatfilter();
}


void texture_filter13()	// do filter... -xgaus
{  
		filtermat[0][0] = 2;	filtermat[1][0] = -1;	filtermat[2][0] = 2;
		filtermat[0][1] = -1;	filtermat[1][1] = 4;	filtermat[2][1] = -1;
		filtermat[0][2] = 2;	filtermat[1][2] = -1;	filtermat[2][2] = 2;
		deelmat=8;
  texture_dothatfilter();
}


void texture_filter14()	// do filter... cpos
{  
		filtermat[0][0] = -1;	filtermat[1][0] = -1;	filtermat[2][0] = -1;
		filtermat[0][1] = -1;	filtermat[1][1] = 8;	filtermat[2][1] = -1;
		filtermat[0][2] = -1;	filtermat[1][2] = -1;	filtermat[2][2] = -1;
		deelmat=1; 
  texture_dothatfilter();
}

void texture_filter15()	// do filter... xgraz
{  
		filtermat[0][0] = 0;	filtermat[1][0] = 0;	filtermat[2][0] = 0;
		filtermat[0][1] = 0;	filtermat[1][1] = 4;	filtermat[2][1] = -1;
		filtermat[0][2] = -1;	filtermat[1][2] = -1;	filtermat[2][2] = -1;
		deelmat=1; 
  texture_dothatfilter();
}

void texture_filter16()	// do filter... ygraz
{  
		filtermat[0][0] = -1;	filtermat[1][0] = -1;	filtermat[2][0] = -1;
		filtermat[0][1] = -1;	filtermat[1][1] = 4;	filtermat[2][1] = 0;
		filtermat[0][2] = 0;	filtermat[1][2] = 0;	filtermat[2][2] = 0;
		deelmat=1; 
  texture_dothatfilter();
}

void texture_filter17()	// do filter... boox
{  		
		filtermat[0][0] = -1;	filtermat[1][0] = -2;	filtermat[2][0] = -1;
		filtermat[0][1] = 2;	filtermat[1][1] = 4;	filtermat[2][1] = 2;
		filtermat[0][2] = -1;	filtermat[1][2] = -2;	filtermat[2][2] = -1;
		deelmat=2; 
  texture_dothatfilter();
}


void texture_filter18()	// do filter... booy
{  
		filtermat[0][0] = -1;	filtermat[1][0] = 2;	filtermat[2][0] = -1;
		filtermat[0][1] = -2;	filtermat[1][1] = 4;	filtermat[2][1] = -2;
		filtermat[0][2] = -1;	filtermat[1][2] = 2;	filtermat[2][2] = -1;
		deelmat=2; 
  texture_dothatfilter();
}

void texture_filter19()	// do filter... gaus x
{  		
		filtermat[0][0] =  2;	filtermat[1][0] = 0;	filtermat[2][0] = 2;
		filtermat[0][1] =  0;	filtermat[1][1] = 4;	filtermat[2][1] = 0;
		filtermat[0][2] =  2;	filtermat[1][2] = 0;	filtermat[2][2] = 2;
		deelmat=12;
  texture_dothatfilter();
}

void texture_filter20()		// do filter... gaus +
{  		
		filtermat[0][0] =  0;	filtermat[1][0] = 2;	filtermat[2][0] = 0;
		filtermat[0][1] =  2;	filtermat[1][1] = 4;	filtermat[2][1] = 2;
		filtermat[0][2] =  0;	filtermat[1][2] = 2;	filtermat[2][2] = 0;
		deelmat=12; 
  texture_dothatfilter();
}

void texture_filter21()		// do filter... shif /
{  
		filtermat[0][0] =  8;	filtermat[1][0] = 4;	filtermat[2][0] = 1;
		filtermat[0][1] =  4;	filtermat[1][1] = 2;	filtermat[2][1] = -2;
		filtermat[0][2] =  1;	filtermat[1][2] = -2;	filtermat[2][2] = -4;
		deelmat=12; 
  texture_dothatfilter();
}

void texture_filter22()		// do filter... shif \
{  
		filtermat[0][0] =  1;	filtermat[1][0] = 4;	filtermat[2][0] = 8;
		filtermat[0][1] =  -2;	filtermat[1][1] = 2;	filtermat[2][1] = 4;
		filtermat[0][2] =  -4;	filtermat[1][2] = -2;	filtermat[2][2] = 1;
		deelmat=12; 
  texture_dothatfilter();
}

void texture_filter23()		// do filter... moo x
{  
		filtermat[0][0] =  2;	   filtermat[1][0] = -2;	filtermat[2][0] = 2;
		filtermat[0][1] =  -2;   filtermat[1][1] = 4;	filtermat[2][1] = -2;
		filtermat[0][2] =  2;	   filtermat[1][2] = -2;	filtermat[2][2] = 2;
		deelmat=4; 
  texture_dothatfilter();
}
	
void texture_filter24()		// do filter... moo +
{  
		filtermat[0][0] =  -2;  filtermat[1][0] = 2;	filtermat[2][0] = -2;
		filtermat[0][1] =  2;   filtermat[1][1] = 4;	filtermat[2][1] =  2;
		filtermat[0][2] =  -2;  filtermat[1][2] = 2;	filtermat[2][2] = -2;
		deelmat=4;
  texture_dothatfilter();
}

void texture_undofilter()		// undo filter... !!!!
{
    //textureimg  //256
    if(texturesize==0)
    {
      textureimg.loadPixels();
      textureimg.copy(textureimg_buffer, 0, 0, 256, 256, 0, 0, 256, 256);      
      textureimg.updatePixels();
    }
    //textureimg  //256
    if(texturesize==1)
    {
      textureimg512.loadPixels();
      textureimg512.copy(textureimg512_buffer, 0, 0, 512, 512, 0, 0, 512, 512);      
      textureimg512.updatePixels();
    }
    
    if(textureviewdetail==1)
    {
       if(texturesize==1)
       {         
           texdetail.copy(textureimg512, texture_tex512x, texture_tex512y, texture_tex512x+256,texture_tex512y+256, 0, 0, 256, 256);
           texdetail.updatePixels();
       }
    }     
    
}
void texture_dothatfilter()
{
    //textureimg  //256
    if(texturesize==0)
    {
    textureimg_buffer.loadPixels();
    textureimg_buffer.copy(textureimg, 0, 0, 256, 256, 0, 0, 256, 256);      
    filter256(textureimg_buffer.pixels, textureimg.pixels, 256, 256);
    textureimg.updatePixels();
    }

    //textureimg  //512
    if(texturesize==1)
    {
      textureimg512_buffer.loadPixels();
      textureimg512_buffer.copy(textureimg512, 0, 0, 512, 512, 0, 0, 512, 512);      
      filter512(textureimg512_buffer.pixels, textureimg512.pixels, 512, 512);
      textureimg512.updatePixels();
    }
  //println("filtering");

  if(textureviewdetail==1 && texturesize==1)
  {
    texdetail.copy(textureimg512, texture_tex512x, texture_tex512y, texture_tex512x+256,texture_tex512y+256, 0, 0, 256, 256);
    texdetail.updatePixels();
  }
    
}
    

