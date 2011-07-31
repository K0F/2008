// Cel_Sculpypaint #0.9.2 release  - Sculpt-paint and manupilator previewer - Elout de Kok ©2007/2008
// SL name: Cel Edman
// 
// provided under the Creative Commons license.
// http://creativecommons.org/licenses/by-nc-sa/1.0/

// processing 0135 beta enviroment.
// -> http://processing.org/download/index.html (download processing for free)

// Read tech notes on 2nd-life forums about sculpted prims -> http://wiki.secondlife.com/wiki/Sculpted_Prims
// To be short: Am image becomes 3D object - where for every pixel R=X G=Y Z=B 

// -------other opensource used in sculptypaint------------------
// Sphere routine by Toxi http://toxi.co.uk/
// ARCBALL by arielm - June 23, 2003 http://www.chronotext.org
// Filechooser 'hack' by Tom Carden http://www.tom-carden.co.uk/

//import processing.dxf.*;
import processing.opengl.*;
import javax.swing.*; //for filechooser

//int dxfrecord=0;

////int tttester=0;


// My sculpt 3D-image 
PImage b;                             //this is the sculptimage!

//buttons etc
PImage loadbutton, abouttxt,scroll, rgb_layers,witselect,toolbuttons,paintmodeselect, draw512,draw512buffer,resetsphere,drawwh,rendermodeselect;
PImage flower_on, flower_off, flower_buttons,flowerselect16_8_4, lockselect, resetcube,stairbuttons,resizesculpt,arch_buttons,render64,render64select;
PImage bigr, bigg, bigb, rendertyper,gridinvert;
PImage smallr, smallg, smallb,temp64,tempload;
PImage gridflat,bezierpix,bezierpix2,bezierpix3,bezierbuttons,pointtoolpix,pointtoolbuttons,stembezier;
PImage arch_transbuttons, arch_multiply,arch_rotatebuttons;

PImage mask1,colorbar_r,colorbar_g,colorbar_b,colorbar_rgb, white_rgb,buttons_texture,witselect18,select64,select128;
PImage textureimg,textureimg_buffer, textureimg512,textureimg512_buffer,texdetail,texture_512detail;
PImage texbake_r, texbake_g, texbake_b, texbake_m1;

PImage stone_buttons, stone_gridselector;
PImage loadtexture,buff128,select8_8,redselect8_8, texture_normalbuff;

PImage morph_getimage, morph_image1, morph_image2,morph_buttons;

PImage sub_pasteimage;
//
PImage buttons_subtool;

PImage undo_back, undo_forward;

//testing
PImage piper_drawimage,piper_backgroundimage;

//for mouse and rotation
int mx,my,sx=140,sy=120, midx,midy;
float zangle;
float zpos=350.0f; //250 camera-position
int mousereleased=0;
float extrax,extray,extraz;

int showgrid=1;

// Max Texture size atm 2nd life is using - 64 by 64 pixels
int sculptsize=64; 

// Extra show the color of XYZ data
int [] sculptr = new int[sculptsize*sculptsize];
int [] sculptg = new int[sculptsize*sculptsize];
int [] sculptb = new int[sculptsize*sculptsize];

//3d object
float [] spx = new float[sculptsize*sculptsize];
float [] spy = new float[sculptsize*sculptsize];
float [] spz = new float[sculptsize*sculptsize];

//original
float [] ospx = new float[sculptsize*sculptsize];
float [] ospy = new float[sculptsize*sculptsize];
float [] ospz = new float[sculptsize*sculptsize];

//undo buffer
int undostepsmax=16;
int undostep=0;
int undostep_forward=0;
int undostep_back=15;
float [] spx_undo = new float[(sculptsize*sculptsize)*undostepsmax];
float [] spy_undo = new float[(sculptsize*sculptsize)*undostepsmax];
float [] spz_undo = new float[(sculptsize*sculptsize)*undostepsmax];

//interpolate to 32*32 xyz - Since SL seems to render sculpts as 32*32 atm 
float [] spx32 = new float[sculptsize*sculptsize];
float [] spy32 = new float[sculptsize*sculptsize];
float [] spz32 = new float[sculptsize*sculptsize];
// buffer
float [] spxbuf = new float[sculptsize*sculptsize];
float [] spybuf = new float[sculptsize*sculptsize];
float [] spzbuf = new float[sculptsize*sculptsize];
// buffer2
float [] spxbuf2 = new float[sculptsize*sculptsize];
float [] spybuf2 = new float[sculptsize*sculptsize];
float [] spzbuf2 = new float[sculptsize*sculptsize];
// bezierbuffers
float [] spxbez1 = new float[sculptsize*sculptsize];
float [] spybez1 = new float[sculptsize*sculptsize];
float [] spzbez1 = new float[sculptsize*sculptsize];

float [] spxbez2 = new float[sculptsize*sculptsize];
float [] spybez2 = new float[sculptsize*sculptsize];
float [] spzbez2 = new float[sculptsize*sculptsize];

float [] spxbez3 = new float[sculptsize*sculptsize];
float [] spybez3 = new float[sculptsize*sculptsize];
float [] spzbez3 = new float[sculptsize*sculptsize];


int savecounter=1;
PFont myfont;
String savename="c_sculpty";
String savenum;
int savefade=0;
int savefadecounter=0;

int drawselect=0;
int selx;
int sely;

//toxi sphere
float[] cx,cz,sphereX,sphereY,sphereZ;
int currRes=0;
boolean filled=true;
//for the precalculated circle buffer
float [] cosd = new float[sculptsize];
float [] sind = new float[sculptsize];


//drawing tool data
int ringx;
int ringy;
float minx=0,miny=0,minz=0,maxx=0,maxy=0,maxz=0;  //min and max of xyz model data
float sizex, sizey, sizez;
float fcurx,fcury;
int mousedragger=0;
int drawtype=0; //draw widht or height
int lockselector=0; //lock parts 0,4,8,16,32

//flower general data
//leaves on or off
int leaves1=1;
int leaves2=0;
int leaves3=0;
int leaves4=0;
int leavestype1=1; // 16, 8, 4
int leavestype2=1;
int leavestype3=1;
int leavestype4=1;
float stemtopheight;
int floweronce=1; //not used anymore atm
float stem_height=3.5f;
float stem_width=2.0f;

//copy / paste flower
int whatflowercopy=1;

float [] fl_4_stemscale = new float[5];  
float [] fl_4_s5 = new float[5]; 
float [] fl_4_s6 = new float[5]; 
float [] fl_4_s7 = new float[5]; 
  
float [] fl_4_sh1 = new float[5];  
float [] fl_4_sh2 = new float[5]; 
float [] fl_4_sh3 = new float[5]; 
float [] fl_4_sh4 = new float[5]; 
float [] fl_4_sh5 = new float[5];  
float [] fl_4_sh6 = new float[5]; 

float [] fl_4_p1 = new float[5];  
float [] fl_4_p2 = new float[5];  
float [] fl_4_p3 = new float[5];  
float [] fl_4_p4 = new float[5];  
    
    
float []   fl_8_stemscale =new float[5];  
float []   fl_8_s5 =new float[5];  
float []   fl_8_s6 =new float[5];  

float []   fl_8_sh1 =new float[5];  
float []   fl_8_sh2 =new float[5];  
float []   fl_8_sh3 =new float[5];  
float []   fl_8_sh4 =new float[5];  
float []   fl_8_sh5 =new float[5];  

float []  fl_8_p1=new float[5];  
float []  fl_8_p2=new float[5];  
float []  fl_8_p3=new float[5];  
float []  fl_8_p4=new float[5];  


  
float []   fl_16_stemscale=new float[5];  
float []   fl_16_s6=new float[5];  

float []   fl_16_sh1=new float[5];  
float []   fl_16_sh2=new float[5];  
float []   fl_16_sh3=new float[5];  
float []   fl_16_sh4=new float[5];

int [] flower_bezx = {75,75,75,75};
int [] flower_bezy = {10,75,150,210};
int [] flower_bezz = {75,75,75,75};

int flowerbezbuf=240;

int [] flower_bezbufx = new int[flowerbezbuf];
int [] flower_bezbufy = new int[flowerbezbuf];
int [] flower_bezbufz = new int[flowerbezbuf];
int flower_bezierpointselect;
int flower_draw_xyz=0;

//stonetool
int grid_pincher_type_w=1;    //0,1,2 -- 8,16,32
int grid_pincher_type_h=1;    //0,1,2 -- 8,16,32
int grid_extruder_type_w=1;   //0,1,2 -- 8,16,32
int grid_extruder_type_h=1;   //0,1,2 -- 8,16,32
int flat_top=1;
int flat_bottom=63;


//stair tool
int stairtype=8;
int stairmax=12;
int stairoffset=11;


//arch tool
int render64_32_16 = 64;
int archdrawmode=0; //0=scale rings || 1=translate rings
int archmirrory=0; // 0=no mirror   || 1=mirror Y 
int arch_rotscalearound=1; // 0 around 0,0,0 | 1 around ring | 2 around selected rings
int [] arch_ringselect=new int[32]; //selected rings
float arch_rsx=0.0f;
float arch_rsy=0.0f;
float arch_rsz=0.0f;
float arch_mirrsx=0.0f;
float arch_mirrsy=0.0f;
float arch_mirrsz=0.0f;
int arch_stepsize=1;   //0 small | 1 medium | 2 large

float arch_stepscaling=0.05f;
float arch_steprotate=(float)(PI/8.0f); //22.5 degrees
float arch_steptranslate=5.0; //translation

int arch_showmirrorbox=0;


int rendertype=1; //1 sphere - 2 torus - 3 plane - 4 cylinder

//----matrix
float [] mat0=new float[16];
float [] mat1=new float[16];
float [] mat2=new float[16];

float [] ringx1=new float[64];
float [] ringy1=new float[64];
float [] ringz1=new float[64];

//bezier stuff
public int[][] beziermat = 
{
  {-1,3,-3,1},
  {3,-6,3,0},
  {-3,3,0,0},
  {1,0,0,0}
};

int [] bezcx = new int[4];
int [] bezcy = new int[4];
int [] bezcz = new int[4];

// point selector
int pointselectx=16;
int pointselecty=16;
int symmetry_x=0;
int symmetry_y=0;
int symmetry_z=0;
int smoothpoint=0;
int [] point_mul=new int[32*32];
int select_multiple=1;
int point_mx1,point_my1,point_mx2,point_my2; //to select a bunch
int point_mxmycount=0;
int point_rotscalearound=0; // 0= around 0,0,0 // 1= selected


// texture tool
int color_tex_r=155;
int color_tex_g=200;
int color_tex_b=255;
int brush_size=64;
int color_pickdraw=0; //0 draw mode 1 color pick
int brush_opacity=128;
int brushtype=0;
int renderyesno=0;
int texturesize=0; //0=256 1=512 (2=1024deleted)
int textureviewdetail=0;
//filtering
int deelmat=16;
int[][] filtermat = {
           {1,2,1},
           {2,4,2},
           {1,2,1}};//gauss
int texture_tex512x=0;   //512-texture detail
int texture_tex512y=0;
int texture_512drawing=0;
boolean texture_lighton=true;

// bake stuff
boolean texture_bake_r=true;
boolean texture_bake_g=true;
boolean texture_bake_b=true;

boolean texture_bake_rgrey=true;
boolean texture_bake_ggrey=true;
boolean texture_bake_bgrey=true;

//for rotating the shading
float bakerotate=(float)(PI/16.0f); //rotate 22.5 degrees
float bakerotate_x=0.0f; 
float bakerotate_y=0.0f; 
float bakerotate_z=0.0f; 



//morph tool
float [] morph_spx1 = new float[sculptsize*sculptsize];
float [] morph_spy1 = new float[sculptsize*sculptsize];
float [] morph_spz1 = new float[sculptsize*sculptsize];
float [] morph_spx2 = new float[sculptsize*sculptsize];
float [] morph_spy2 = new float[sculptsize*sculptsize];
float [] morph_spz2 = new float[sculptsize*sculptsize];
int morph_mixvalue=0; //a
int [] morph_mul=new int[32*32]; //lock buttons



//sub tool
int sub_mx1,sub_my1,sub_mx2,sub_my2; 
int sub_mxmycount_a=0;
int sub_mxmycount_b=0;
int [] sub_copybuf=new int[32*32]; //lock buttons
int [] sub_pastebuf=new int[32*32]; //lock buttons

//pipertool wip - testing
int [] pipe_x=new int[32];
int [] pipe_y=new int[32];
int [] pipe_z=new int[32];
int [] pipe_xyzstatus=new int[32]; //move, follow or locked
int pipe_whatpoint=0;
int pipe_clickstatus=0;

//float [] piper_normalbuff_x = new float[sculptsize*sculptsize];
//float [] piper_normalbuff_y = new float[sculptsize*sculptsize];
//float [] piper_normalbuff_z = new float[sculptsize*sculptsize];



ArcBall arcball;
  
int warningfade=0;
int warningfadecounter=0;
String warningtext="test";
  

int paintmode=8; // 0=rgb layer | 1=drawing tool | 2=flower tool | 3=rock generator | 4=stairs 
                  //| 5=arch | 6=point | 7=texture | 8=morph | 9=test
int rendermodez=0; //0 color / 1 solid / 2 wire / 3 textured

//This is the scale of the Sculptie we draw!
float scaler=2.5f;//2.5;//4.0f;//2.5f; //3

int rotatedrag=0;

void setup() 
{

  // select now a 64*64 sculpt-image
  b = loadImage("data/torus.png");

  loadbutton= loadImage("data/loadbutton.png");
  abouttxt= loadImage("data/text.png");
  scroll= loadImage("data/scroll.png");
  rgb_layers= loadImage("data/load_rgb_layers.png");
  
  toolbuttons=loadImage("data/toolbuttons.png");
  //drawingtool=loadImage("data/drawingtool.png");
  //editrgb=loadImage("data/editrgb.png");
  paintmodeselect=loadImage("data/paintmodeselect.png");
  draw512=loadImage("data/draw512.png");
  draw512buffer=loadImage("data/draw512.png");
  resetsphere=loadImage("data/resetsphere.png");
  drawwh=loadImage("data/drawwh.png"); 
  bigr= loadImage("data/grid.png");
  bigg= loadImage("data/grid.png");
  bigb= loadImage("data/grid.png");
  witselect=loadImage("data/witselect.png");
  smallr= loadImage("data/64.png");
  smallg= loadImage("data/64.png");
  smallb= loadImage("data/64.png");  
  temp64= loadImage("data/64.png");
  lockselect= loadImage("data/lockselect.png");

  resizesculpt= loadImage("data/resizesculpt.png");

  rendermodeselect= loadImage("data/rendermodeselect.png");
  rendertyper= loadImage("data/rendertypeselect.png");


  pointtoolpix=loadImage("data/black256.png");
  gridinvert=loadImage("data/black256.png");
  loadtexture=loadImage("data/black256.png");
  

  //flowertool images
  gridflat= loadImage("data/grid.png");
  flower_on= loadImage("data/flower_on.png");
  flower_off= loadImage("data/flower_off.png");
  flower_buttons= loadImage("data/flower_buttons.png");  
  flowerselect16_8_4= loadImage("data/flowerselect16_8_4.png");  
  buff128= loadImage("data/black128.png");
  stembezier= loadImage("data/stembezier.png");

  //Stone buttons
  stone_buttons= loadImage("data/stone_buttons.png");  
  stone_gridselector= loadImage("data/stonegrid_selector.png");  
  resetcube= loadImage("data/resetcube.png");  
  
  //Stair buttons
  stairbuttons = loadImage("data/stairbuttons.png");  
  
  //arch
  arch_buttons = loadImage("data/arch_buttons.png");
  arch_transbuttons = loadImage("data/arch_transbuttons.png");
  arch_rotatebuttons = loadImage("data/arch_rotatebuttons.png");
  arch_multiply = loadImage("data/arch_multiply.png");


  render64 = loadImage("data/render64.png");  
  render64select = loadImage("data/render64select.png");  
  int render64_32_16=64;

  select8_8 = loadImage("data/select8_8.png");
  redselect8_8 = loadImage("data/redselect8_8.png");
  
  pointtoolbuttons = loadImage("data/pointtoolbuttons.png");
  
  //texture tool
  mask1  =  loadImage("data/msk1.gif");
  colorbar_r=loadImage("data/black256_16.png");
  colorbar_g=loadImage("data/black256_16.png");
  colorbar_b=loadImage("data/black256_16.png");  
  textureimg_buffer=loadImage("data/black256.png");
  textureimg=loadImage("data/black256.png");
  textureimg512=loadImage("data/draw512.png");
  textureimg512_buffer=loadImage("data/draw512.png");
  ///textureimg1024=loadImage("data/black1024.gif");
  witselect18=loadImage("data/witselect18_18.png");
  colorbar_rgb=loadImage("data/black_16_16.png");
  white_rgb=loadImage("data/white1_16.png");
  buttons_texture=loadImage("data/buttons_texture.png");
  texdetail=loadImage("data/black256.png");
  select64=loadImage("data/select64_64.png");
  select128=loadImage("data/select128_128.png");
  texture_512detail=loadImage("data/texture_512detail.png");
  //texture baking
  texture_normalbuff= loadImage("data/64.png");  
  texbake_r = loadImage("data/64.png");  
  texbake_g = loadImage("data/64.png");  
  texbake_b = loadImage("data/64.png");  
  texbake_m1 = loadImage("data/64.png");
  

  //morph tool  
  morph_image1= loadImage("data/morph_a.png");
  morph_image2= loadImage("data/morph_b.png");
  morph_buttons= loadImage("data/buttons_morph.png");

  //sub tool
  buttons_subtool= loadImage("data/buttons_subtool.png");
  sub_pasteimage= loadImage("data/64.png");

  //pipetool testing fase
  piper_drawimage=loadImage("data/black256.png");
  piper_backgroundimage=loadImage("data/black256.png");
  
  
  undo_back=loadImage("data/undo_back.png");
  undo_forward=loadImage("data/undo_forward.png");

  // flip the flower texture - else it might rendered wrong
  flipimage_h256();
  
  
  size(960, 600, P3D);
  midx=width/2;
  midy=height/2;

  noStroke();
  
  getimagedata();  
  layersredgreenblue();
  
  myfont = loadFont("Kartika-48.vlw");
  
  //precalculate a circle between -1 and 1 : set up cos/sin table
  for(int i=0; i<sculptsize; i++) 
  {
    cosd[i]=( cos ( (float)i*360/sculptsize * PI / 180.0f));
    sind[i]=( sin ( (float)i*360/sculptsize * PI / 180.0f));
  }
    
  layersredgreenblue();
  selectdrawingtool(); 
  
  //created the drawing backbuffer
  setup512canvas();

  //rotation of sculpt at start
  mx=357;
  my=127;
  if ( mx > midx){sx=0-((midx-mx)/2);}
  else{sx=((mx-midx)/2);}
  if ( my > midy){sy=0-((midy-my)/2);}
  else{sy=((my-midy)/2);}
  
  
  mx=808+75;
  my=269+10;
  flower_stembezier();
  flower_draw_xyz=1;
  mx=808+75;
  my=269+10;
  flower_stembezier();
  flower_draw_xyz=0;
  
  pointtoolpix.loadPixels();
  pointtoolpix.copy(b, 0, 0, 64, 64, 0, 0, 256, 256);    
  pointtoolpix.updatePixels();
 
  point_clearmultiple();
  //clear archselect
  for(int i=0;i<32;i++){arch_ringselect[i]=0;}
    
  drawcolorbars();

  reset_to_cube();
  morph_copyto_b();
  
  //start with a sphere and drawing tool
  reset_to_sphere();    
  //toxi_sphere();    
  generate_scuptxyz();
  flipimage_256();
  morph_copyto_a();
  //fix morphbuttons again
  morph_image1= loadImage("data/morph_a.png");
  morph_image2= loadImage("data/morph_b.png");
  
  //pipetool
    for(int i=0;i<32;i++)
    {
      pipe_x[i]=((i*7)+16);
      pipe_y[i]=128;
      pipe_z[i]=0;
      pipe_xyzstatus[i]=0; //0=follow 1=move 2=locked
    }
    pipe_xyzstatus[0]=1;  // 0=follow 1=move 2=locked
    pipe_xyzstatus[31]=1; // 0=follow 1=move 2=locked
    selectpipertool();
    arcball = new ArcBall(235, 300, 400);
      //ArcBall(float center_x, float center_y, float radius)

}


void draw() 
{
  //clear with a background color, little touch of blue used now
  background(0,0,50);
 // noSmooth();

  if(texture_lighton==true){lights();}
  

  //all white so the images are viewed correctly
  fill(255,  255, 255, 255);
 
  //show the 64*64 sculpt image top left corner
  image(b, 0, 0);

  // Testing: show my 64*64 back-buffer 
  // image(temp64, 0, 65);
  
  //Draw the about text 
  image(abouttxt, width-310, height-21);

  //paintmode select buttons
  image(toolbuttons, 425, 548);

  image(resizesculpt, 2, 538);
  
  image(render64, 81, 583);    //render modes
  if(render64_32_16==64){image(render64select, 113, 582);}//64
  if(render64_32_16==32){image(render64select, 152, 582);}//32
  if(render64_32_16==16){image(render64select, 191, 582);}//16

  if(rendermodez==0){image(rendermodeselect, 232, 582);}//color
  if(rendermodez==1){image(rendermodeselect, 271, 582);}//solid
  if(rendermodez==2){image(rendermodeselect, 310, 582);}//wire
  if(rendermodez==3){image(rendermodeselect, 349, 582);}//texture
  
  if(rendertype==1){image(rendertyper, 423, 582);}//sphere
  if(rendertype==2){image(rendertyper, 462, 582);}//torus
  if(rendertype==3){image(rendertyper, 501, 582);}//plane
  if(rendertype==4){image(rendertyper, 540, 582);}//cylinder

  if (showgrid==1){image(rendertyper, 585, 582);}//showgrid
  if(texture_lighton==true){image(lockselect, 629, 582);}//basic lightning
     

  image(loadbutton, 66, 2);
  
 if (undostep_back>0){image(undo_back, 192, 2);}
 if (undostep_forward>0){image(undo_forward, 227, 2);}
//undostep=0;
//int undostep_forward=0;
//int undostep_back=0;

  //------------Sub tool----------------------
  if(paintmode==9) 
  {   
     image(paintmodeselect, 667, 563);
     
     image(buttons_subtool, 436, 4);
    
    // noSmooth();
     image(b, 440, 8, 256,256);
     image(sub_pasteimage, 702, 8, 256,256);
     
    //for 3D cursor and highlite on model
    if(mx>439 && mx<695 && my>7 && my<262)
    {
      selx=(mx-440)/4;
      sely=(my-8)/4;
      image(witselect, selx-2, sely-2);
      drawselect=1;
    }
   /*else if(mx>701 && mx<956 && my>7 && my<262)
    {
      selx=(mx-702)/4;
      sely=(my-8)/4;
      image(witselect, selx-2, sely-2);
      drawselect=1;
    }*/    
    else 
    {
      drawselect=0;
      selx=pointselectx*2;
      sely=pointselecty*2;
    }

    //draw locked items copybuf
    for(int j=0;j<32;j++)
    {
        for(int i=0;i<32;i++)
        {
           if(sub_copybuf[(j*32)+i]==1)
           {  
               image(select8_8, 440+(i*8), 8+(j*8));
           }      
        }
    }
    //draw locked items pastebuf
    for(int j=0;j<32;j++)
    {
        for(int i=0;i<32;i++)
        {
           if(sub_pastebuf[(j*32)+i]==1)
           {  
               image(select8_8, 702+(i*8), 8+(j*8));
           }      
        }
    }
    
           //int [] sub_copybuf=new int[32*32]; //lock buttons
      //int [] sub_pastebuf=new int[32*32]; //lock buttons    

     
  }
   //----Morph tool-----   
  if(paintmode==8) 
  {    
     image(paintmodeselect, 586, 563);
     image(morph_buttons, 616, 4);
     image(resetcube, 668, 455);
     
          
     image(morph_image1, 779, 25);
     image(morph_image2, 873, 25);
          
     image(white_rgb,778+morph_mixvalue, 135); //slider

     image(b, 700, 168, 256,256);
     
    //Testing: Mouse over big sculpt layer? show the current point in white on 3D object    
    if(mx>701 && mx<956 && my>167 && my<424)
    {
      selx=(mx-701)/4;
      sely=(my-169)/4;
      image(witselect, selx-2, sely-2);
      //println(selx+", "+sely);
      drawselect=1;
    }else{drawselect=0;}
    
    //draw locked items
    for(int j=0;j<32;j++)
    {
        for(int i=0;i<32;i++)
        {
           if(morph_mul[(j*32)+i]==1)//morph_mul=new int[32*32]
           {  
               image(select8_8, 700+(i*8), 168+(j*8));
           }      
        }
    }
    
     
  }
  
   //----Texture tool-----   
  if(paintmode==7) 
  {
     image(paintmodeselect, 505, 563);

     if(texture_bake_r==true){image(rendertyper, 544, 201);}
     if(texture_bake_g==true){image(rendertyper, 585, 201);}
     if(texture_bake_b==true){image(rendertyper, 626, 201);}

     if(texture_bake_rgrey==true){image(rendertyper, 544, 218);}
     if(texture_bake_ggrey==true){image(rendertyper, 585, 218);}
     if(texture_bake_bgrey==true){image(rendertyper, 626, 218);}

     if(texturesize==0)
     {
       image(textureimg, 701, 4);
       if(textureviewdetail==0)
       {
         image(textureimg, 701, 275 , 128, 128); // seamless preview
         image(textureimg, 701+128, 275 , 128, 128);
         image(textureimg, 701, 275+128 , 128, 128);
         image(textureimg, 701+128, 275+128 , 128, 128);
       }
       if(textureviewdetail==1)
       {
         image(textureimg, 701, 275);
       }
     }
     if(texturesize==1)
     {
       image(textureimg512, 701, 4, 256, 256);
       if(textureviewdetail==0)
       {
         image(textureimg512, 701, 275 , 128, 128); // seamless preview
         image(textureimg512, 701+128, 275 , 128, 128);
         image(textureimg512, 701, 275+128 , 128, 128);
         image(textureimg512, 701+128, 275+128 , 128, 128);     
       }
       if(textureviewdetail==1)
       {
         image(texdetail, 701, 275);
       }       
     }
     /*
     if(texturesize==2)
     {
       image(textureimg1024, 701, 4, 256, 256);
       if(textureviewdetail==0)
       {
         image(textureimg1024, 701, 275 , 128, 128); // seamless preview
         image(textureimg1024, 701+128, 275 , 128, 128);
         image(textureimg1024, 701, 275+128 , 128, 128);
         image(textureimg1024, 701+128, 275+128 , 128, 128);     
       }
       if(textureviewdetail==1)
       {
         image(texdetail, 701, 275);
       }       
     }
     */
          
     if(textureviewdetail==1)
     {
       if(texturesize==1)
       {
         image(select128, 701+(texture_tex512x/2), 4+(texture_tex512y/2)); //512 detail
       }
     }
          
     image(colorbar_r,440, 4);
     image(colorbar_g,440, 22);
     image(colorbar_b,440, 40);
     
     image(colorbar_rgb,680, 58);
     
     image(white_rgb,440+color_tex_r, 4);
     image(white_rgb,440+color_tex_g, 22);
     image(white_rgb,440+color_tex_b, 40);
     
     
     image(buttons_texture,496, 57);
     
     image(white_rgb,567+brush_size, 77);
     image(white_rgb,567+brush_opacity, 96);
     
     
     //color_pickdraw=0
     if(color_pickdraw==0){image(rendertyper, 605, 59);} //draw or color pick?
     if(color_pickdraw==1){image(rendertyper, 565, 59);}
     
     if(renderyesno==0){image(rendertyper, 565, 152);} //show 3D model
     if(renderyesno==1){image(rendertyper, 606, 152);} //hide 3D model
     
         
     if(brushtype==0){ image(witselect18, 566, 115);}
     if(brushtype==1){ image(witselect18, 584, 115);}
     if(brushtype==2){ image(witselect18, 602, 115);}
     if(brushtype==3){ image(witselect18, 620, 115);}
     if(brushtype==4){ image(witselect18, 638, 115);}
     if(brushtype==5){ image(witselect18, 656, 115);}
     
     
     if(texturesize==0){image(rendertyper, 565, 135);} ////texturesize=0; //0=256 1=512 2=1024
     if(texturesize==1){image(rendertyper, 606, 135);} ////texturesize=0; //0=256 1=512 2=1024
     //if(texturesize==2){image(rendertyper, 647, 135);} ////texturesize=0; //0=256 1=512 2=1024
     
     if(textureviewdetail==0){image(paintmodeselect, 610, 516);}
     if(textureviewdetail==1){image(paintmodeselect, 528, 516);image(texture_512detail, 565, 532);}
//     texture_512detail    //text info image 


    if(mx>701 && mx<956 && my>4 && my<259)
    {
      selx=(mx-701)/4;
      sely=(my-4)/4;
      image(witselect, selx-2, sely-2);
      //println(selx+", "+sely);
      drawselect=1;
    }
    else
    {
      drawselect=0;
      //selx=pointselectx*2;
      //sely=pointselecty*2;
    }
  
  }
  
   //----Point tool-----   
  if(paintmode==6) 
  {

     image(paintmodeselect, 424, 563);
     image(pointtoolpix, 701, 8);
     image(pointtoolbuttons, 567,4);
     
     image(resetcube, 668, 455);

     if(symmetry_x==1){image(stone_gridselector, 639, 115);}
     if(symmetry_y==1){image(stone_gridselector, 657, 115);}
     if(symmetry_z==1){image(stone_gridselector, 675, 115);}

    if (arch_stepsize==0){image(rendertyper, 569, 146);} //step small
    if (arch_stepsize==1){image(rendertyper, 611, 146);} //step medium
    if (arch_stepsize==2){image(rendertyper, 653, 146);} //step large
    
    if (point_rotscalearound==0){image(rendertyper, 611, 243);} //rotate-scale around 0,0,0
    if (point_rotscalearound==1){image(rendertyper, 653, 243);} //rotate-scale around selected

//image(rendertyper, 611, 243);
    
    //Testing: Mouse over big sculpt layer? show the current point in white on 3D object
    drawselect=0;
    if(select_multiple==1)
    {
      for(int j=0;j<32;j++)
      {
        for(int i=0;i<32;i++)
        {
           if(point_mul[(j*32)+i]==1)
           {  
               image(select8_8, 701+(i*8), 8+(j*8));
           }      
        }
      }
    }
    
    if(mx>701 && mx<956 && my>8 && my<263)
    {
      selx=(mx-701)/4;
      sely=(my-8)/4;
      image(witselect, selx-2, sely-2);
      //println(selx+", "+sely);
      drawselect=1;
    }
    else
    {
      drawselect=0;
      selx=pointselectx*2;
      sely=pointselecty*2;
    }

    // if(point_mxmycount==1)
    // {
       // image(witselect, point_mx1, point_my1, point_mx1-point_mx2, point_my1-point_my2);
    // }
     

    
  }
  
   //----Arch tool-----
  if(paintmode==5) 
  {
    image(paintmodeselect, 829, 547);
    image(arch_buttons, 593, 2);
    
/////    image(arch_transbuttons, 612, 2);
    
    if(archdrawmode==0)//scale mode
    {
      image(paintmodeselect, 664, 500); 
    }
    if(archdrawmode==1) //translate mode
    {
      image(paintmodeselect, 664, 483); 
      image(arch_transbuttons, 772, 2);
    }           
    if(archdrawmode==2) //rotate mode
    {
      image(paintmodeselect, 664, 466); 
      image(arch_rotatebuttons, 772, 2);
    }
    
    if(archmirrory==1){image(rendertyper, 619, 500);} // mirror Y    
    
    if(arch_rotscalearound==0){image(rendertyper, 619, 444);} // rot/scale around 0,0,0
    if(arch_rotscalearound==1){image(rendertyper, 661, 444);} // rot/scale around ring
    if(arch_rotscalearound==2){image(rendertyper, 703, 444);} // rot/scale around selected
    
    if (arch_stepsize==0){image(rendertyper, 619, 408);} //step small
    if (arch_stepsize==1){image(rendertyper, 661, 408);} //step medium
    if (arch_stepsize==2){image(rendertyper, 703, 408);} //step large



    if(mx>752 && mx<959 && my>2 && my<514)//show those mouseover rings
    {       
          drawselect=2;
          selx=((mx-772)/16)*2;
          sely=((my-2)/16)*2;      
          int curx=mx-772;
          int cury=my-2;
          ringy=(cury/16)*2;
          //println("ring: " + ringy);
    }else{drawselect=0;}
    //select multiply rings?
    for(int i=0;i<32;i++)
    {
      if(arch_ringselect[i]==1)
      {
        image(arch_multiply, 750, 5+(i*16));        
      }
    }   
    
  }
   //----Stairs tool-----
  if(paintmode==4) 
  {
    image(paintmodeselect, 748, 547);
    
    image(stairbuttons, 620, 10);    
    image(gridflat, 701, 8);
    
    if(stairtype==16){image(stone_gridselector, 645, 9);}
    if(stairtype==8){image(stone_gridselector, 663, 9);}
    if(stairtype==4){image(stone_gridselector, 681, 9);}
        
  }
   //----Stone tool-----
  if(paintmode==3) 
  {
    image(paintmodeselect, 667, 547);
    image(gridflat, 701, 8);
//    image(resetsphere, 668, 534); 
    image(stone_buttons, 614, 8);
    
    image(resetcube, 668, 455);
          

        
    if(grid_pincher_type_w==0){image(stone_gridselector, 647, 102);}
    if(grid_pincher_type_w==1){image(stone_gridselector, 664, 102);}
    if(grid_pincher_type_w==2){image(stone_gridselector, 681, 102);}
    
    if(grid_pincher_type_h==0){image(stone_gridselector, 647, 115);}
    if(grid_pincher_type_h==1){image(stone_gridselector, 664, 115);}
    if(grid_pincher_type_h==2){image(stone_gridselector, 681, 115);}

    if(grid_extruder_type_w==0){image(stone_gridselector, 647, 150);}
    if(grid_extruder_type_w==1){image(stone_gridselector, 664, 150);}
    if(grid_extruder_type_w==2){image(stone_gridselector, 681, 150);}
    
    if(grid_extruder_type_h==0){image(stone_gridselector, 647, 163);}
    if(grid_extruder_type_h==1){image(stone_gridselector, 664, 163);}
    if(grid_extruder_type_h==2){image(stone_gridselector, 681, 163);}

  }
  
   //----flower tool-----
  if(paintmode==2) 
  {
     image(paintmodeselect, 586, 547);
     //image(loadbutton, 75, 2);
     
     image(gridflat, 701, 8);
     image(flower_buttons, 533, 10);
     
     image(stembezier, 807, 269);
     if(flower_draw_xyz==0){image(flowerselect16_8_4, 871, 491);}
     if(flower_draw_xyz==1){image(flowerselect16_8_4, 890, 491);}
     if(flower_bezierpointselect!=0)
     {
       if(flower_draw_xyz==0){image(select8_8, flower_bezx[flower_bezierpointselect]+807-4,flower_bezy[flower_bezierpointselect]+269-4);}
       if(flower_draw_xyz==1){image(select8_8, flower_bezz[flower_bezierpointselect]+807-4,flower_bezy[flower_bezierpointselect]+269-4);}       
     }
     if(mx>807 && mx<956 && my>269 && my<488 )
     {
       flower_check_bezierpoints();
     }
     

     // flower leaves 1-4 on or off?!
     if(leaves1==1)
     {
       image(flower_on, 509, 44);
       if(leavestype1==0){image(flowerselect16_8_4, 640, 43);}     
       if(leavestype1==1){image(flowerselect16_8_4, 659, 43);}     
       if(leavestype1==2){image(flowerselect16_8_4, 678, 43);}            
     }  
     else{image(flower_off, 509, 44);}
     if(leaves2==1)
     {
       image(flower_on, 509, 77);
       if(leavestype2==0){image(flowerselect16_8_4, 640, 76);}     
       if(leavestype2==1){image(flowerselect16_8_4, 659, 76);}     
       if(leavestype2==2){image(flowerselect16_8_4, 678, 76);}            
     }  
     else{image(flower_off, 509, 77);}
     if(leaves3==1)
     {
       image(flower_on, 509, 111);
       if(leavestype3==0){image(flowerselect16_8_4, 640, 110);}     
       if(leavestype3==1){image(flowerselect16_8_4, 659, 110);}     
       if(leavestype3==2){image(flowerselect16_8_4, 678, 110);}            
     } 
     else{image(flower_off, 509, 111);}
     if(leaves4==1)
     {
       image(flower_on, 509,144);
       if(leavestype4==0){image(flowerselect16_8_4, 640, 143);}     
       if(leavestype4==1){image(flowerselect16_8_4, 659, 143);}     
       if(leavestype4==2){image(flowerselect16_8_4, 678, 143);}            
     }  
     else{image(flower_off, 509, 144);}
     
     if(mousereleased==1)
     {
       if(mx>568 && mx<581 && my>59 && my<71){flowerminplus(1, 1); } // min
       if(mx>583 && mx<596 && my>59 && my<71){flowerminplus(1, -1);}
       if(mx>568 && mx<581 && my>92 && my<104){flowerminplus(2, 1);} // min
       if(mx>583 && mx<596 && my>92 && my<104){flowerminplus(2, -1);}
       if(mx>568 && mx<581 && my>126 && my<138){flowerminplus(3, 1); } // min
       if(mx>583 && mx<596 && my>126 && my<138){flowerminplus(3, -1);} 
       if(mx>568 && mx<581 && my>159 && my<171){flowerminplus(4, 1);} // min
       if(mx>583 && mx<596 && my>159 && my<171){flowerminplus(4, -1);}
 
       if(mx>601 && mx<614 && my>269 && my<282) {stem_height_min();}
       if(mx>616 && mx<629 && my>269 && my<282) {stem_height_plus();}
       if(mx>601 && mx<614 && my>286 && my<299) {stem_width_min();}
       if(mx>616 && mx<629 && my>286 && my<299) {stem_width_plus();}      
     }
  }
  
  // ---------Drawing tool---------
  if(paintmode==1) 
  {
    drawselect=0;
    image(paintmodeselect, 505, 547);
    image(draw512, 438, 8);
    image(resetsphere, 438, 525);
    image(drawwh, 534, 525);
    //image(loadbutton, 75, 2);
        
    if(lockselector==1){image(lockselect, 543, 524);}
    if(lockselector==2){image(lockselect, 560, 524);}
    if(lockselector==3){image(lockselect, 577, 524);}
    if(lockselector==4){image(lockselect, 594, 524);}
    
    
    if(drawtype==0)
    {
      image(paintmodeselect, 613, 524);
    }
    if(drawtype==1)
    {
      image(paintmodeselect, 695, 524);
    }
    //check the drawing area // dont draw when rotating the 3d model
    if(rotatedrag!=1)
    {
      if(mx>438 && mx<950 && my>8 && my<520)
      {
        drawselect=2;
        selx=(mx-438)/8;
        sely=(my-8)/8;      
        int curx=mx-438;
        int cury=my-8;
        ringy=cury/8;
        fcurx=((float)curx-256) / (512/sizex);
        fcury=((float)cury-256) / (512/sizey);
        //println("ring: " + ringy+ " scale "+fcury);
      }
    }
    
  }
  
  // ------Edit RGB layers-------
  if(paintmode==0) 
  {
    //image(loadbutton, 75, 2);
    image(paintmodeselect, 424, 547);    
    //rgb scroll image
    image(scroll, 422, 228);
    //load rgb layers
    image(rgb_layers, 424, 365);
    // big r,g,b layers
    image(bigr, 432, 4);
    image(bigg, 701, 4);
    image(bigb, 701, 274);  
    //small rgb layers
    image(smallr, 433, 294);
    image(smallg, 518, 294);
    image(smallb, 603, 294);  
    
    //Testing: Mouse over big red layer? show the current point in white on 3D object
    drawselect=0;
    if(mx>432 && mx<687 && my>4 && my<259)
    {
      selx=(mx-432)/4;
      sely=(my-4)/4;
      image(witselect, selx-2, sely-2);
      //println(selx+", "+sely);
      drawselect=1;
    }      
  }
  
  
  if (mousereleased==1)
  {  
    if(mx>13 && mx<26 && my>552 && my<565){extray=extray+0.1;} // rotate sculpt
    if(mx>43 && mx<57 && my>552 && my<565){extray=extray-0.1;} 
    if(mx>27 && mx<42 && my>536 && my<550){extrax=extrax+0.1;} 
    if(mx>27 && mx<42 && my>567 && my<581){extrax=extrax-0.1;}
    //extraz
    if(mx>14 && mx<27 && my>539 && my<551){extraz=extraz-0.1;} // rotate sculpt
    if(mx>43 && mx<56 && my>566 && my<579){extraz=extraz+0.1;} // rotate sculpt
  
  }


  // warning text      
  if(warningfade==1)
  {
    textFont(myfont, 21);
    text("Warning: "+warningtext, 260, 70); 
    warningfadecounter++;
    if(warningfadecounter>60)
    {
      warningfade=0;
      warningfadecounter=0;
    }
  }

  
  // fades the saving text      
  if(savefade==1)
  {
    textFont(myfont, 21);
    if(paintmode==2)
    {
      //string tempsave=(string)(savecounter-1);
      text("Saved Flowersculpt & Texture # "+str(savecounter-1), 260, 70); 
    }
    else
    {
      text("Saved "+savename, 260, 70);
    }
    text("In the Sculptypaint Folder", 260, 90);
    
    savefadecounter++;
    if(savefadecounter>60)
    {
      savefade=0;
      savefadecounter=0;
    }
  }
  
  
  // Position the 3D object   
  translate(midx-80, midy, zpos); 
  
  //check mouse-position for rotation of the object
  mx=mouseX;
  my=mouseY;
  
  
  //rotateX(extrax);
  //rotateY(extray);
  //rotateZ(extraz);




if(renderyesno==0)//start show 3D
{

  arcball.run();
  
  //draw the sculpt 3D
  pushMatrix();
    //if(dxfrecord==1)
   // {
    //  beginRaw(DXF, savename);
   // }
    
    if(rendermodez==3)
    {
      drawsculpt_textured();      
    }
    else
    {
      drawsculpt();    
    }
    
   // if(dxfrecord==1)
    //{
    //  endRaw();
    //  dxfrecord=0;
      //println("saved dxf");
    //}


  if (showgrid==1)//showgrid
  {
      stroke(0,255,0 ,100);
      line(0, 100, 0,  0, -100, 0);
      stroke(255,0,0,100);
      line( 100, 0,  0, -100, 0, 0);
      stroke(0,0,255,100);
      line(0,0, 100, 0,  0, -100);
  }
  
  if(mx>597 && mx<732 && my>175 && my<220 && paintmode==5)
  {
       if(mx>597 && mx<663 && my>175 && my<188) {arch_showmirrorbox(1);}
       if(mx>666 && mx<732 && my>175 && my<188) {arch_showmirrorbox(2);}
       if(mx>597 && mx<663 && my>191 && my<204) {arch_showmirrorbox(3);}
       if(mx>666 && mx<732 && my>191 && my<204) {arch_showmirrorbox(4);}
       if(mx>597 && mx<663 && my>207 && my<220) {arch_showmirrorbox(5);}
       if(mx>666 && mx<732 && my>207 && my<220) {arch_showmirrorbox(6);}
  }
  
 
 
  popMatrix();
}//end show 3D


//3d cursor                  
if(drawselect==1)
{
  if(paintmode==6 || paintmode==7 || paintmode==8 || paintmode==9)
  {
    if(selx>=0 && sely>=0 && selx<64 &&sely<64)
    {
      pushMatrix();
      translate(spx[(sely*64)+selx], spy[(sely*64)+selx], spz[(sely*64)+selx]); 
    
      stroke(255,255,255 ,100);
      line(0, 25, 0,  0, -25, 0);
      stroke(255,255,255,100);
      line( 25, 0,  0, -25, 0, 0);
      stroke(255,255,255,100);
      line(0,0, 25, 0,  0, -25);
      popMatrix();
    }
  }
}

    


 // saveFrame("zzcreendump-####.tga");

  //just add a little delay so system can handle other stuff as well
  delay(45);
}

void mouseDragged() 
{
  
  if(rotatedrag==1) // mouserotate sculpt
  {
  
        if ( mx > midx){sx=0-((midx-mx)/2);}
      else{sx=((mx-midx)/2);}
      if ( my > midy){sy=0-((midy-my)/2);}
      else{sy=((my-midy)/2);}
      
    arcball.mouseDragged();
  }
  
  if(paintmode==1) // Drawing tool
  { 
    if(rotatedrag!=1) //dont draw when draggin 3d model
    {
     if(drawtype==0) // draw width
     { 
      if(mx>438+256 && mx<950 && my>8 && my<520)
      {
        scaleringxy(ringy, fcurx);
      }
     }    
     if(drawtype==1) //draw height
     {
      if(mx>438 && mx<950 && my>8 && my<520)
      {
        scaleringxz(ringy, fcurx);
      }
     }
    }  
    
  }
  //-------------------------------------------------------
  // ---------------------------------texture tool------------------------------
  if(paintmode==7) 
  {
    if(color_pickdraw==0)
    {
      if(mx>700 && mx<957 && my>4 && my<260)
      {      
        if(texturesize==0)
        {
          textureimg.loadPixels();
          drawsprite3(mask1.pixels, textureimg.pixels, mx-700, my-4, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b,256);
          textureimg.updatePixels();
        }
        if(texturesize==1)
        {
          textureimg512.loadPixels();
          drawsprite3(mask1.pixels, textureimg512.pixels, (mx-700)*2, (my-4)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 512);
          textureimg512.updatePixels();
        }
        //if(texturesize==2)
        //{
        //  textureimg1024.loadPixels();
        //  drawsprite3(mask1.pixels, textureimg1024.pixels, (mx-700)*4, (my-4)*4, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 1024);
        //  textureimg1024.updatePixels();
        //}      
      }
      
       //draw on seamless textured preview
       
      if(texturesize==0)
      {       
        if(mx>700 && mx<828 && my>275 && my<403)
        {
          textureimg.loadPixels();
          drawsprite3(mask1.pixels, textureimg.pixels, (mx-700)*2, (my-275)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256 );
          textureimg.updatePixels();
        }
        if(mx>828 && mx<956 && my>275 && my<403)
        {
          textureimg.loadPixels();
          drawsprite3(mask1.pixels, textureimg.pixels, (mx-828)*2, (my-275)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256);
          textureimg.updatePixels();
        }
        if(mx>700 && mx<828 && my>403 && my<531)
        {
          textureimg.loadPixels();
          drawsprite3(mask1.pixels, textureimg.pixels, (mx-700)*2, (my-403)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256);
          textureimg.updatePixels();
        }
        if(mx>828 && mx<956 && my>403 && my<531)
        {
          textureimg.loadPixels();
          drawsprite3(mask1.pixels, textureimg.pixels, (mx-828)*2, (my-403)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256 );
          textureimg.updatePixels();
        }
      }
      
      
      
    }    
  }  
  
  if(mx>13 && mx<26 && my>552 && my<565){extray=extray+0.1;} // rotate sculpt
  if(mx>43 && mx<57 && my>552 && my<565){extray=extray-0.1;} 
  if(mx>27 && mx<42 && my>536 && my<550){extrax=extrax+0.1;} 
  if(mx>27 && mx<42 && my>567 && my<581){extrax=extrax-0.1;} 
  
}
void mouseReleased()
{
  mousedragger=0; 
  rotatedrag=0;
  mousereleased=0;
  
  
  
  if(paintmode==5)//arch tool
  {
      //multiply rings selected
      if(point_mxmycount==1)
      {
        point_my2=my;
        if(point_my2<3){point_my2=3;}
        if(point_my2>514){point_my2=514;}
        int tty1=(point_my1-3)/16; //3 - 512 // 32 rings
        int tty2=(point_my2-3)/16;
        if(tty1>tty2){tty1=tty2; tty2=(point_my1-3)/16;}
        
        for(int j=tty1;j<tty2+1;j++)
        {
            if (arch_ringselect[j]==1){arch_ringselect[j]=0;}
            else {arch_ringselect[j]=1;}      
        }        
         //now check if mirror y is selected
        /*       
        if(archmirrory==1)
        {
          for(int j=tty1;j<tty2+1;j++)
          {
            if (arch_ringselect[31-j]==1){arch_ringselect[31-j]=0;}
            else {arch_ringselect[31-j]=1;}      
          }
        } 
        */
      }
      //-----------------
      point_mxmycount=0;
        
  }       
  //--------------------------
  if(paintmode==6)//point tool
  {
    if(select_multiple==1)
    {
      if(point_mxmycount==1)
      {      
        point_mx2=mx;
        point_my2=my;
        if(point_mx2<702){point_mx2=702;}
        if(point_mx2>955){point_mx2=955;}
        if(point_my2<9){point_my2=9;}
        if(point_my2>262){point_my2=262;}
        
        int ttx1=(point_mx1-702)/8;
        int ttx2=(point_mx2-702)/8;
        int tty1=(point_my1-9)/8;
        int tty2=(point_my2-9)/8;
        if(ttx1>ttx2){ttx1=ttx2; ttx2=(point_mx1-701)/8;}
        if(tty1>tty2){tty1=tty2; tty2=(point_my1-8)/8;}
        for(int j=tty1;j<tty2+1;j++)
        {
          for(int i=ttx1;i<ttx2+1;i++)
          {
            if (point_mul[(j*32)+i]==1){point_mul[(j*32)+i]=0;}
            else {point_mul[(j*32)+i]=1;}
          }        
        }

        point_mxmycount=0;
      }
    }
  }
    //if(mx>701 && mx<956 && my>8 && my<263)

  if(paintmode==7)//texture sketch
  {
      if(texture_512drawing==1)
      {
        texdetail.copy(textureimg512, texture_tex512x, texture_tex512y, texture_tex512x+256,texture_tex512y+256, 0, 0, 256, 256);
        texdetail.updatePixels();
        texture_512drawing=0;
      }   
  }    
  //--------------------------
  
  if(paintmode==8)//morph tool - select multiply lock buttons
  {
      if(point_mxmycount==1)
      {      
        point_mx2=mx;
        point_my2=my;
        if(point_mx2<700){point_mx2=700;}
        if(point_mx2>955){point_mx2=955;}
        if(point_my2<168){point_my2=168;}
        if(point_my2>423){point_my2=423;}        
        int ttx1=(point_mx1-700)/8;
        int ttx2=(point_mx2-700)/8;
        int tty1=(point_my1-168)/8;
        int tty2=(point_my2-168)/8;
        if(ttx1>ttx2){ttx1=ttx2; ttx2=(point_mx1-700)/8;}
        if(tty1>tty2){tty1=tty2; tty2=(point_my1-168)/8;}
        for(int j=tty1;j<tty2+1;j++)
        {
          for(int i=ttx1;i<ttx2+1;i++)
          {
            if (morph_mul[(j*32)+i]==1){morph_mul[(j*32)+i]=0;}
            else {morph_mul[(j*32)+i]=1;}
          }        
        }                
        //println("x1: "+ttx1+" y1: "+tty1+" x2: "+ttx2+" y2: "+tty2);
        point_mxmycount=0;
      }      
  }

  if(paintmode==9)//sub tool - select multiply lock buttons
  {
      if(sub_mxmycount_a==1) //left copybuffer
      {      
        sub_mx2=mx;
        sub_my2=my;
        if(sub_mx2<440){sub_mx2=440;}
        if(sub_mx2>695){sub_mx2=695;}
        if(sub_my2<8){sub_my2=8;}
        if(sub_my2>263){sub_my2=263;}        
        int ttx1=(sub_mx1-440)/8;
        int ttx2=(sub_mx2-440)/8;
        int tty1=(sub_my1-8)/8;
        int tty2=(sub_my2-8)/8;
        if(ttx1>ttx2){ttx1=ttx2; ttx2=(sub_mx1-440)/8;}
        if(tty1>tty2){tty1=tty2; tty2=(sub_my1-8)/8;}
        for(int j=tty1;j<tty2+1;j++)
        {
          for(int i=ttx1;i<ttx2+1;i++)
          {
            if (sub_copybuf[(j*32)+i]==1){sub_copybuf[(j*32)+i]=0;}
            else {sub_copybuf[(j*32)+i]=1;}
          }        
        }                
        sub_mxmycount_a=0;
      }
      if(sub_mxmycount_b==1) //right pastebuffer
      {      
        sub_mx2=mx;
        sub_my2=my;
        if(sub_mx2<702){sub_mx2=702;}
        if(sub_mx2>957){sub_mx2=957;}
        if(sub_my2<8){sub_my2=8;}
        if(sub_my2>263){sub_my2=263;}        
        int ttx1=(sub_mx1-702)/8;
        int ttx2=(sub_mx2-702)/8;
        int tty1=(sub_my1-8)/8;
        int tty2=(sub_my2-8)/8;
        if(ttx1>ttx2){ttx1=ttx2; ttx2=(sub_mx1-702)/8;}
        if(tty1>tty2){tty1=tty2; tty2=(sub_my1-8)/8;}
        for(int j=tty1;j<tty2+1;j++)
        {
          for(int i=ttx1;i<ttx2+1;i++)
          {
            if (sub_pastebuf[(j*32)+i]==1){sub_pastebuf[(j*32)+i]=0;}
            else {sub_pastebuf[(j*32)+i]=1;}
          }        
        }                
        sub_mxmycount_b=0;
      }
      
  }
  


      //if(mx>699 && mx<956 && my>167 && my<424)
      //{      
        //select multiply is handled now in mouserelease       
       // point_mx1=mx;
       // point_my1=my;
       // point_mx2=mx;
       // point_my2=my;
       // point_mxmycount=1;      
      //}  
  //--------------------------
}

void mousePressed() 
{
  arcball.mousePressed();
  
  mousereleased=1;   
  check_mouseclicked(); //check all the buttons; if clicked
  
}






//--------------------------------------------
//---------------------doe de Mat thing-------------------------------
void doedemat()
{
		matbasic(mat1);
		matbasic(mat2);
		matrotx(mat1,45);
		//matroty(mat2,roty);
		//addmat(mat0,mat1,mat2);
		//matcopy(mat1, mat0);
		//matbasic(mat2);
		//matrotz(mat2,rotz);
		//addmat(mat0,mat1,mat2);
		//finmat(mat0,0,points);
}

//---------------------Mat nothin-------------------------------
void matbasic(float matrix[])
{
  for (int i=0; i<16; i++){matrix[i]=0.0f;}
  matrix[0]=1.0f;
  matrix[5]=1.0f;
  matrix[10]=1.0f;
  matrix[15]=1.0f;
}

//---------------------copy Mat -------------------------------
void matcopy(float matrix1[], float matrix2[])
{
  for (int i=0; i<16; i++){matrix1[i]=matrix2[i];}
}
//---------------------Mat translate-------------------------------
void mattranslate(float matrix[], float x, float y,float z)
{
  matrix[3]=x;
  matrix[7]=y;
  matrix[11]=z;
}
//---------------------Mat scale-------------------------------
void matscale(float matrix[], float x, float y,float z)
{
  matrix[0]=x;
  matrix[5]=y;
  matrix[10]=z;
}
//---------------------Mat rotate X-------------------------------
void matrotx(float matrix[], float rotation)
{
  matrix[5]=(float) Math.cos(rotation);
  matrix[6]=(float) -Math.sin(rotation);
  matrix[9]=(float) Math.sin(rotation);
  matrix[10]=(float) Math.cos(rotation);
}
//---------------------Mat rotate Y-------------------------------
void matroty(float matrix[], float rotation)
{
  matrix[0]=(float) Math.cos(rotation);
  matrix[2]=(float) Math.sin(rotation);
  matrix[8]=(float) -Math.sin(rotation);
  matrix[10]=(float) Math.cos(rotation);
}
//---------------------Mat rotate Z-------------------------------
void matrotz(float matrix[], float rotation)
{
  matrix[0]=(float) Math.cos(rotation);
  matrix[1]=(float) -Math.sin(rotation);
  matrix[4]=(float) Math.sin(rotation);
  matrix[5]=(float) Math.cos(rotation);
}
//add a matrix
void addmat(float matrixf[], float matrixa[], float matrixb[])
{
  for (int i = 0; i < 4; i++)
  {
    float a0 = matrixa[i];
    float a1 = matrixa[i+4];
    float a2 = matrixa[i+8];
    float a3 = matrixa[i+12];
    matrixf[i] = a0 * matrixb[0] + a1 * matrixb[1] + a2 * matrixb[2] + a3 * matrixb[3];
    matrixf[i+4] = a0 * matrixb[4] + a1 * matrixb[5] + a2 * matrixb[6] + a3 * matrixb[7];
    matrixf[i+8] = a0 * matrixb[8] + a1 * matrixb[9] + a2 * matrixb[10] + a3 * matrixb[11];
    matrixf[i+12] = a0 * matrixb[12] + a1 * matrixb[13] + a2 * matrixb[14] + a3 * matrixb[15];
   }
}

//---------------------fin mat-------------------------------





// reset to cube
void reset_to_cube()
{
   rendertype=1;

   gridflat= loadImage("data/grid.png");
   
   //draw sides of the cube
    cube_drawsides(16,48);

    // draw top - scale xz and reset y
    cube_drawsides(0,16);  
    
    for(int j=0;j<16;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=spx[(j*64)+i]*(((float)(j)+0.1f)/17.0f);
        spy[(j*64)+i]=-32;
        spz[(j*64)+i]=spz[(j*64)+i]*(((float)(j)+0.1f)/17.0f);
      } 
    }

    // draw bottom -  scale xz and reset y
    cube_drawsides(48,64);    
    for(int j=48;j<64;j++)
    {
      for(int i=0;i<64;i++)
      {    
        spx[(j*64)+i]=spx[(j*64)+i]*((63.1f-(float)j)/17.0f); //0 
        spy[(j*64)+i]=30;
        spz[(j*64)+i]=spz[(j*64)+i]*((63.1f-(float)j)/17.0f);
      } 
    }
    
   scale_ring2xz(0, 0.0000009f,0);
   scale_ring2xz(62, 0.000009f,0);
   
   //generate sculpt image
    generate_scuptxyz();
  
  for(int j=0;j<8;j++)
  {
    rotate_rings();
  }
  generate_scuptxyz();
  
}


void cube_drawsides(int starty, int endy)
{
    //side left
    for(int j=starty;j<endy;j++)
    {
      for(int i=0;i<16;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=32;
        spy[(j*64)+i]=(j-32)*2;
        spz[(j*64)+i]=((i-16)*4)+32;
      } 
    }
    
    //front 
    for(int j=starty;j<endy;j++)
    {
      for(int i=16;i<32;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=((32-i)*4)-32;
        spy[(j*64)+i]=(j-32)*2;
        spz[(j*64)+i]=32;
      } 
    }
    
    //side right
    for(int j=starty;j<endy;j++)
    {
      for(int i=32;i<48;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=-32;
        spy[(j*64)+i]=(j-32)*2;
        spz[(j*64)+i]=((48-i)*4)-32;
      } 
    }
    
    //back 
    for(int j=starty;j<endy;j++)
    {
      for(int i=48;i<64;i++)
      {    
        //int posi=(j*64)+i;
        spx[(j*64)+i]=((i-64)*4)+32;
        spy[(j*64)+i]=(j-32)*2;
        spz[(j*64)+i]=-32;
      } 
    }

}







  
void resize_sculpt()
{
  getimagedata();
  generate_scuptxyz();
}
  




//-----------line drawing routine
void gline1(int pixel[],int x,int y, int x2, int y2, int w,int r,int g,int b)
{
		int dx,dy,long_d,short_d;
		int d,add_dh,add_dl;
		int inc_xh,inc_yh,inc_xl,inc_yl;
		int inc_ah,inc_al,adr=0;          

		dx=x2-x; dy=y2-y;                          /* ranges */

		if(dx<0){dx=-dx; inc_xh=-1; inc_xl=-1;}    /* making sure dx and dy >0 */
		else    {        inc_xh=1;  inc_xl=1; }    /* adjusting increments */
		if(dy<0){dy=-dy;	inc_yh=-w;
							inc_yl=-w;}/* to get to the neighboring */
		else {				inc_yh= w; /* point along Y have to add */
							inc_yl= w;}/* or subtract this */

		if(dx>dy){long_d=dx; short_d=dy; inc_yl=0;}/* long range,&making sure either */
		else {long_d=dy; short_d=dx; inc_xl=0;}/* x or y is changed in L case */

		inc_ah=inc_xh+inc_yh;
		inc_al=inc_xl+inc_yl;                      /* increments for point adress */
		adr+=(y*w)+x;							/* address of first point */

		d=2*short_d-long_d;                        /* initial value of d */
		add_dl=2*short_d;                          /* d adjustment for H case */
		add_dh=2*short_d-2*long_d;                 /* d adjustment for L case */

		for(int i=0;i<=long_d;i++)                     /* for all points in longer range */
		{
			pixel[adr] = ( (0xff<<24) | (r<<16) | (g<<8) | b); //( (0xff<<24) | (r<<16) | (g<<8) | b);  
			if(d>=0){adr+=inc_ah; d+=add_dh;}         /* previous point was H type */
			else    {adr+=inc_al; d+=add_dl;}         /* previous point was L type */
		}
}


void setup512canvas()
{
  draw512buffer.loadPixels();
  //clear the drawing canvas
  for (int j=0;j<512;j++)
  {
    for (int i=0;i<512;i++)
    {
      drawpoint2( draw512buffer.pixels,  i, j, 512, 0, 0, 0);  
    }
  }
  //draw grid
  for (int j=0;j<512;j++)
  {
    for (int i=0;i<512;i+=8)
    {
      drawpoint2( draw512buffer.pixels,  i, j, 512, 30, 30, 30);  
    }
  }
  for (int j=0;j<512;j+=8)
  {
    for (int i=0;i<512;i++)
    {
      drawpoint2( draw512buffer.pixels,  i, j, 512, 30, 30, 30);  
    }
  } 
  for (int j=0,i=256;j<512;j++)
  {
      drawpoint2( draw512buffer.pixels,  i, j, 512, 60, 60, 60);  

  } 
  
  draw512buffer.updatePixels();  
  
  selectdrawingtool(); //show the points
   
}
void drawpoint2(int output[],int x, int y, int w, int r, int g, int b)
{
  output[(y*w)+x] =     ( (0xff<<24) | (r<<16) | (g<<8) | b);  
}

//-------------------------------------------------------------------------

void toxi_sphere()
{
  //testing sphere - based on flexible sphere resolutions - http://toxi.co.uk
  float angle_step=180.0/sculptsize;
  float angle=angle_step;
  float rad=PI/180;
  float myscaler2=40.0f;
  int currVert=0;
  for(int i=1; i<=sculptsize; i++) 
  {
    float curradius=sin(angle*rad);
    float currY=-cos(angle*rad);
    for(int j=0; j<sculptsize; j++)
    {
        spx[currVert]=(cosd[j]*curradius)*myscaler2;
        ospx[currVert]=spx[currVert];
        spy[currVert]=(currY)*myscaler2;
        ospy[currVert]=spy[currVert];
        spz[currVert]=(sind[j]*curradius)*myscaler2;
        ospz[currVert]=spz[currVert];
        currVert++;
    }
      angle+=angle_step;
  }  
}  

//-------------------------------------------------------------------------
// Generate sculpt map from a 3d object
// looks at 3D model and create the sculpt map
// I look at min and max xyz coordinates now set bottom to zero and top to 255
void generate_scuptxyz()
{
  float minx=0,miny=0,minz=0,maxx=0,maxy=0,maxz=0;
  
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
 // println("minx " + minx + " miny " + miny +" minz " + minz);
  //println("maxx " + maxx + " maxy " + maxy +" maxz " + maxz);
  float sizex=maxx-minx;
  float sizey=maxy-miny;
  float sizez=maxz-minz;
  //println("size x" + sizex + " size y" + sizey + "size z " + sizez);
  
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    { 
      float tr=  (spx[(j*64)+i]-minx)*(255.0f/sizex);  // stretch between 0-255
      float tg=  (spy[(j*64)+i]-miny)*(255.0f/sizey);
      float tb=  (spz[(j*64)+i]-minz)*(255.0f/sizez);
      
      int r=  (int) tr;
      if((tr-(float)r)>0.5f && r<254){r++;}
      int g=  (int) tg;
      if((tg-(float)g)>0.5f && g<254){g++;}
      int b=  (int) tb;
      if((tb-(float)b)>0.5f && b<254){b++;}
      
      //float testttt=tr-(float)r;
      //if(testttt>0.5f){println("round error");}
      drawpoint( temp64.pixels,  i,j, 64,   r, g, b);
    }
  }
  temp64.updatePixels();
  
  b.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  b.updatePixels();
  if(paintmode==6)
  {
    pointtoolpix.loadPixels();
    pointtoolpix.copy(b, 0, 0, 64, 64, 0, 0, 256, 256);    
    pointtoolpix.updatePixels();    
  } 
 
 //calculate 3d rendermodel as well now draw as 64, 32 or 16
 calc_64_32_16();
 
 //undo buffer time
 undostep++;
 if(undostep>15){undostep=0;}
 
 undostep_back=15;//++;
 //if(undostep_back>15){undostep_back=15;}
 undostep_forward=0;
 
 int undopos=(sculptsize*sculptsize)*undostep;
 
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int pos=(j*64)+i;      
      spx_undo[undopos+pos]= spx[pos];
      spy_undo[undopos+pos]= spy[pos];
      spz_undo[undopos+pos]= spz[pos];
    }  
  }
  //println("undostep: "+undostep+" undoback: "+ undostep_back + " undostep_forward: "+undostep_forward);
  //println("scupt called");
  //undostep_back=15;
  //undostep_forward=0;
//undo buffer
//int undostepsmax=16;
//int undostep=0;
//int undostep_forward=0;
//int undostep_back=0;
//float [] spx_undo = new float[(sculptsize*sculptsize)*undostepsmax];
//float [] spy_undo = new float[(sculptsize*sculptsize)*undostepsmax];
//float [] spz_undo = new float[(sculptsize*sculptsize)*undostepsmax]; 
}

//-------------------------------------------------------------------------
// Fix with undo
void generate_scuptxyz_undo(int backorforward)
{
 //println("undostep: "+undostep+" undoback: "+ undostep_back + " undostep_forward: "+undostep_forward);


  float minx=0,miny=0,minz=0,maxx=0,maxy=0,maxz=0;

  undostep=undostep+backorforward;
  if(undostep<0){undostep=15;}
  if(undostep>15){undostep=0;}
  
  int undopos=(sculptsize*sculptsize)*undostep;
 //undo buffer time
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    {
      int pos=(j*64)+i;
      spx[pos]= spx_undo[undopos+pos];
      spy[pos]= spy_undo[undopos+pos];
      spz[pos]= spz_undo[undopos+pos];
    }
  }
  
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
 // println("minx " + minx + " miny " + miny +" minz " + minz);
  //println("maxx " + maxx + " maxy " + maxy +" maxz " + maxz);
  float sizex=maxx-minx;
  float sizey=maxy-miny;
  float sizez=maxz-minz;
  //println("size x" + sizex + " size y" + sizey + "size z " + sizez);
  
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    for (int i=0;i<64;i++)
    { 
      float tr=  (spx[(j*64)+i]-minx)*(255.0f/sizex);  // stretch between 0-255
      float tg=  (spy[(j*64)+i]-miny)*(255.0f/sizey);
      float tb=  (spz[(j*64)+i]-minz)*(255.0f/sizez);
      
      int r=  (int) tr;
      if((tr-(float)r)>0.5f && r<254){r++;}
      int g=  (int) tg;
      if((tg-(float)g)>0.5f && g<254){g++;}
      int b=  (int) tb;
      if((tb-(float)b)>0.5f && b<254){b++;}
      
      //float testttt=tr-(float)r;
      //if(testttt>0.5f){println("round error");}
      drawpoint( temp64.pixels,  i,j, 64,   r, g, b);
    }
  }
  temp64.updatePixels();
  
  b.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  b.updatePixels();
  if(paintmode==6)
  {
    pointtoolpix.loadPixels();
    pointtoolpix.copy(b, 0, 0, 64, 64, 0, 0, 256, 256);    
    pointtoolpix.updatePixels();    
  } 
 
 //calculate 3d rendermodel as well now draw as 64, 32 or 16
 calc_64_32_16();  
}

//calculate how we draw the model
void calc_64_32_16()
{

  // do all your drawing here  
  if(render64_32_16==64)
  {
      for (int i=0;i<(sculptsize*sculptsize)-1; i++) //1
      {
            spx32[i]=spx[i];
            spy32[i]=spy[i];            
            spz32[i]=spz[i];             
      }    
  }
  if(render64_32_16==32)
  {  
      //convert model to 32*32 size xyz looking model   
      for (int j=0;j<sculptsize-1; j+=2) //1
      {
        for (int i=0;i<sculptsize-1; i+=2) //1
        {
            int p1=(j*sculptsize)+i;
            int p2=((j+1)*sculptsize)+i;
            
            spx32[p1]=(spx[p1]+spx[p1+1]+spx[p2]+spx[p2+1])/4.0f;            
            spx32[p1+1]=spx32[p1];
            spx32[p2]=spx32[p1];
            spx32[p2+1]=spx32[p1];

            spy32[p1]=(spy[p1]+spy[p1+1]+spy[p2]+spy[p2+1])/4.0f;            
            spy32[p1+1]=spy32[p1];
            spy32[p2]=spy32[p1];
            spy32[p2+1]=spy32[p1];
            
            spz32[p1]=(spz[p1]+spz[p1+1]+spz[p2]+spz[p2+1])/4.0f;            
            spz32[p1+1]=spz32[p1];
            spz32[p2]=spz32[p1];
            spz32[p2+1]=spz32[p1];
            
      }
    }
      

  }
  
  if(render64_32_16==16)
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
  }
  
  
}




// When saving the image. I got to flip it horizontal, else the object appears like the maya bug; insideout.

void flipimage_h64()
{
  //println("flippin!");
  temp64.loadPixels();
  for (int j=0;j<64;j++)
  {
    int stepper=63;
    for (int i=0;i<64;i++)
    {
      temp64.pixels[(j*64)+stepper]=b.pixels[(j*64)+i];
      stepper--;
    }
  }
  temp64.updatePixels();
  b.copy(temp64, 0, 0, 64, 64, 0, 0, 64, 64);
  b.updatePixels();
}





void drawpoint(int output[],int x, int y, int w, int r, int g, int b)
{
  output[(y*w)+x] =     ( (0xff<<24) | (r<<16) | (g<<8) | b);  
}
void drawpoint4(int output[],int x, int y, int w, int r, int g, int b)
{
  int t=(y*w)+x;
  
  int tr=r-30; if (tr<0){tr=0;}
  int tg=g-30; if (tg<0){tg=0;}
  int tb=b-30; if (tb<0){tb=0;}
  
  output[t] =     ( (0xff<<24) | (tr<<16) | (tg<<8) | tb);
  output[t+1] =   ( (0xff<<24) | (tr<<16) | (tg<<8) | tb);
  output[t+2] =   ( (0xff<<24) | (tr<<16) | (tg<<8) | tb);
  output[t+3] =   ( (0xff<<24) | (tr<<16) | (tg<<8) | tb);
  t=((y+1)*w)+x;
  output[t] =    ( (0xff<<24) | (tr<<16) | (tg<<8) | tb);
  output[t+1] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  output[t+2] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  output[t+3] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  t=((y+2)*w)+x;
  output[t] =    ( (0xff<<24) | (tr<<16) | (tg<<8) | tb);
  output[t+1] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  output[t+2] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  output[t+3] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  t=((y+3)*w)+x;
  output[t] =    ( (0xff<<24) | (tr<<16) | (tg<<8) | tb);
  output[t+1] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  output[t+2] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
  output[t+3] =  ( (0xff<<24) | (r<<16) | (g<<8) | b);
}




// reads sculpt image, and transform it into a 3d object
void getimagedata()
{         
  //get the image data
  //image(b, 0, 0, sculptsize, sculptsize);
  // get the RGB Data of the 64*64 picture
  for (int j=0;j<sculptsize;j++)
  {
    for (int i=0;i<sculptsize;i++)
    {
        sculptr[(j*sculptsize)+i]=((b.pixels[(j*sculptsize)+i] >> 16) & 0xff); // Red
        sculptg[(j*sculptsize)+i]=((b.pixels[(j*sculptsize)+i] >>  8) & 0xff); // Green
        sculptb[(j*sculptsize)+i]=(b.pixels[(j*sculptsize)+i] & 0xff);         // Blue
    }
  }
  
  // set the X,Y an Z values now
  for (int j=0;j<sculptsize;j++)
  {
    for (int i=0;i<sculptsize;i++)
    {
        spx[(j*sculptsize)+i]=(((float)sculptr[(j*sculptsize)+i]-128.0f)/scaler);
        spy[(j*sculptsize)+i]=(((float)sculptg[(j*sculptsize)+i]-128.0f)/scaler);
        spz[(j*sculptsize)+i]=(((float)sculptb[(j*sculptsize)+i]-128.0f)/scaler);
    }
  }
  
}


//toxi`s xsphere
/*
void xsphere(float radius,  int res) 
{
  res=64;
  float delta=360f/res;
  float rad=PI/180;
  //if (res!=currRes)
  //{
    
    cx=new float[res];
    cz=new float[res];
    // calc unit circle
    for(int i=0; i<res; i++) 
    {
      cx[i]=cos(i*delta*rad); //cx[i]=cos(i*(360f/64)*(PI/180));
      cz[i]=sin(i*delta*rad);
    }
    // computing vertexlist
    // vertexlist starts at south pole
    int vertCount=res*(res-1)+2;
    int currVert=0;
    
    sphereX=new float[vertCount];
    sphereY=new float[vertCount];
    sphereZ=new float[vertCount];

    // radius angle is used for scaling circle
    float angle_step=180.0/res;
    float angle=angle_step;
    //float rad=PI/180;
    float[] ringVertsX=new float[res];
    float[] ringVertsZ=new float[res];

    for(int i=1; i<res; i++) {
      float curradius=sin(angle*rad);
      float currY=-cos(angle*rad);
      for(int j=0; j<res; j++) {
        sphereX[currVert]=cx[j]*curradius;
        sphereY[currVert]=currY;
        sphereZ[currVert++]=cz[j]*curradius;
      }
      angle+=angle_step;
    }
    currRes=res;
  //}

  int v1,v2,v3,v4;
  pushMatrix();
  scale(radius);
  beginShape(TRIANGLES);
  // 1st ring from south pole
  for(int i=1; i<=res; i++) 
  {
    v2=i%res;
    v3=(i+1)%res;
    
    vertex(0,-1,0);
    vertex(sphereX[v2],sphereY[v2],sphereZ[v2]);
    vertex(sphereX[v3],sphereY[v3],sphereZ[v3]);
  }

  // middle rings
  int voff=res;
  for(int i=1; i<res-1; i++) {
    for(int j=0; j<res; j++) {
      //fill(sculptr[((j+1)*sculptsize)+i],  sculptg[((j+1)*sculptsize)+i], sculptb[((j+1)*sculptsize)+i],100);
      v1=voff-res+j;
      v2=voff+j;
      v3=(j+1)%res+voff;
      v4=voff-res+(j+1)%res;
      vertex(sphereX[v1],sphereY[v1],sphereZ[v1]);
      vertex(sphereX[v2],sphereY[v2],sphereZ[v2]);
      vertex(sphereX[v3],sphereY[v3],sphereZ[v3]);
      // 2nd part of quad
      vertex(sphereX[v1],sphereY[v1],sphereZ[v1]);
      vertex(sphereX[v3],sphereY[v3],sphereZ[v3]);
      vertex(sphereX[v4],sphereY[v4],sphereZ[v4]);
    }
    voff+=res;
  }
  // undo the last update
  voff-=res;
  // add the northern cap
  for(int i=1; i<=res; i++) {
    v2=voff+i%res;
    v3=voff+(i+1)%res;
    vertex(0,1,0);
    vertex(sphereX[v2],sphereY[v2],sphereZ[v2]);
    vertex(sphereX[v3],sphereY[v3],sphereZ[v3]);
  }
  endShape();
  popMatrix();
}
*/


void flipimage_h256()
{
  //println("flippin!");
  bigr.loadPixels();
  for (int j=0;j<256;j++)
  {
    int stepper=255;
    for (int i=0;i<256;i++)
    {
      bigr.pixels[(j*256)+stepper]=gridflat.pixels[(j*256)+i];
      stepper--;
    }
  }
  temp64.updatePixels();
  gridflat.copy(bigr, 0, 0, 256, 256, 0, 0, 256, 256);
  gridflat.updatePixels();
}

void flipimage_256()
{
  //gridflat.loadPixels();

  //println("flipflipflip");
  
  gridinvert.loadPixels();
  for (int j=0;j<256;j++)
  {
    int stepper=255;
    for (int i=0;i<256;i++)
    {
      gridinvert.pixels[(j*256)+stepper]=gridflat.pixels[(j*256)+i];
      stepper--;
    }
  }
  gridinvert.updatePixels();
}

// ARCBALL by arielm - June 23, 2003 http://www.chronotext.org
/* CREDITS...
1) v3ga for starting with quaternions in processing!
http://proce55ing.net/discourse/yabb/YaBB.cgi?board=Tools;action=display;num=1054894944
2) Paul Rademacher & other contributors to the GLUI User Interface Library
http://www.cs.unc.edu/~rademach/glui
3) Nick Bobic (great introductionary article on quaternions + source code)
http://www.gamasutra.com/features/19980703/quaternions_01.htm
4) Matrix and Quaternion FAQ
http://skal.planet-d.net/demo/matrixfaq.htm
5) Ken Shoemake, inventor of the ArcBall concept, around 1985 (?)...
*/

class ArcBall
{
  float center_x, center_y, radius;
  Vec3 v_down, v_drag;
  Quat q_now, q_down, q_drag;
  Vec3[] axisSet;
  int axis;

  ArcBall(float center_x, float center_y, float radius)
  {
    this.center_x = center_x;
    this.center_y = center_y;
    this.radius = radius;

    v_down = new Vec3();
    v_drag = new Vec3();

    q_now = new Quat();
    q_down = new Quat();
    q_drag = new Quat();

    axisSet = new Vec3[] {new Vec3(1.0f, 0.0f, 0.0f), new Vec3(0.0f, 1.0f, 0.0f), new Vec3(0.0f, 0.0f, 1.0f)};
    axis = -1;  // no constraints...
  }

  void mousePressed()
  {
    v_down = mouse_to_sphere(mouseX, mouseY);
    q_down.set(q_now);
    q_drag.reset();
  }

  void mouseDragged()
  {
    v_drag = mouse_to_sphere(mouseX, mouseY);
    q_drag.set(Vec3.dot(v_down, v_drag), Vec3.cross(v_down, v_drag));
  }

  void run()
  {
    q_now = Quat.mul(q_drag, q_down);
    applyQuat2Matrix(q_now);
  }

  Vec3 mouse_to_sphere(float x, float y)
  {
    Vec3 v = new Vec3();
    v.x = (x - center_x) / radius;
    v.y = (y - center_y) / radius;

    float mag = v.x * v.x + v.y * v.y;
    if (mag > 1.0f)
    {
      v.normalize();
    }
    else
    {
      v.z = sqrt(1.0f - mag);
    }

    return (axis == -1) ? v : constrain_vector(v, axisSet[axis]);
  }

  Vec3 constrain_vector(Vec3 vector, Vec3 axis)
  {
    Vec3 res = new Vec3();
    res.sub(vector, Vec3.mul(axis, Vec3.dot(axis, vector)));
    res.normalize();
    return res;
  }

  void applyQuat2Matrix(Quat q)
  {
    // instead of transforming q into a matrix and applying it...

    float[] aa = q.getValue();
    rotate(aa[0], aa[1], aa[2], aa[3]);
  }
}

static class Vec3
{
  float x, y, z;

  Vec3()
  {
  }

  Vec3(float x, float y, float z)
  {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void normalize()
  {
    float length = length();
    x /= length;
    y /= length;
    z /= length;
  }

  float length()
  {
    return (float) Math.sqrt(x * x + y * y + z * z);
  }

  static Vec3 cross(Vec3 v1, Vec3 v2)
  {
    Vec3 res = new Vec3();
    res.x = v1.y * v2.z - v1.z * v2.y;
    res.y = v1.z * v2.x - v1.x * v2.z;
    res.z = v1.x * v2.y - v1.y * v2.x;
    return res;
  }

  static float dot(Vec3 v1, Vec3 v2)
  {
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
  }
  
  static Vec3 mul(Vec3 v, float d)
  {
    Vec3 res = new Vec3();
    res.x = v.x * d;
    res.y = v.y * d;
    res.z = v.z * d;
    return res;
  }

  void sub(Vec3 v1, Vec3 v2)
  {
    x = v1.x - v2.x;
    y = v1.y - v2.y;
    z = v1.z - v2.z;
  }
}

static class Quat
{
  float w, x, y, z;

  Quat()
  {
    reset();
  }

  Quat(float w, float x, float y, float z)
  {
    this.w = w;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void reset()
  {
    w = 1.0f;
    x = 0.0f;
    y = 0.0f;
    z = 0.0f;
  }

  void set(float w, Vec3 v)
  {
    this.w = w;
    x = v.x;
    y = v.y;
    z = v.z;
  }

  void set(Quat q)
  {
    w = q.w;
    x = q.x;
    y = q.y;
    z = q.z;
  }

  static Quat mul(Quat q1, Quat q2)
  {
    Quat res = new Quat();
    res.w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z;
    res.x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y;
    res.y = q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z;
    res.z = q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x;
    return res;
  }
  
  float[] getValue()
  {
    // transforming this quat into an angle and an axis vector...

    float[] res = new float[4];

    float sa = (float) Math.sqrt(1.0f - w * w);
    if (sa < EPSILON)
    {
      sa = 1.0f;
    }

    res[0] = (float) Math.acos(w) * 2.0f;
    res[1] = x / sa;
    res[2] = y / sa;
    res[3] = z / sa;

    return res;
  }
}



