// general_check_mouse_clicks 
void check_mouseclicked()
{
  if(mx>0 && mx<64 && my>0 && my<64) // used as testing area now and then
  {

    /*
    textureviewdetail=1;
    if(texturesize==1)
    {
      texdetail.copy(textureimg512, 0, 0, 256, 256, 0, 0, 256, 256);
    }
    if(texturesize==2)
    {
      texdetail.copy(textureimg1024, 0, 0, 256, 256, 0, 0, 256, 256);
    }
    texdetail.updatePixels();*/
    
    //textureimg  //256
    /*
    textureimg_buffer.loadPixels();
    textureimg_buffer.copy(textureimg, 0, 0, 256, 256, 0, 0, 256, 256);      
    filter256(textureimg_buffer.pixels, textureimg.pixels, 256, 256);
    textureimg.updatePixels();
    println("filtering");
    */
/*
    //textureimg  //256
    textureimg512_buffer.loadPixels();
    textureimg512_buffer.copy(textureimg512, 0, 0, 512, 512, 0, 0, 512, 512);      
    filter512(textureimg512_buffer.pixels, textureimg512.pixels, 512, 512);
    textureimg512.updatePixels();
    println("filtering");
  */  
  
    //reset_archplanecube();
    
//    reset_archplanecuberounded();

  //stone_mirror_toptowardsbottom();
//stone_mirror_lefttowardsright();

   // stone_forceto32sl();
  
 //texture_vector();
 

  
 // rotate_normalmap();

   warningfade=1;
   warningtext="clicked :) (test)";
   
 //  point_tool_rotate(0,-1.0); // X and min
//   point_tool_rotate(0, 1.0); // X and min
   
  // point_tool_rotate(1);
  // point_tool_rotate(2);
   
   
  } //testing out things in case
  

  
  // the different drawing modes / tools
  if(mx>425 && mx<502 && my>548 && my<561){ selectdrawrgb();paintmode=0; renderyesno=0;}    // rgb layers
  if(mx>506 && mx<583 && my>548 && my<561){ rendermodez=0;paintmode=1;renderyesno=0; if(drawtype==0){drawselect=0;selectdrawingtool();} if(drawtype==1){selectdrawingtool_height();} } //drawing tool
  if(mx>587 && mx<664 && my>548 && my<561){ paintmode=2;drawselect=0;renderyesno=0;}  //flower tool //selectflowertool();
  if(mx>668 && mx<745 && my>548 && my<561){ selectstonetool(); paintmode=3;drawselect=0;renderyesno=0;}  //Stone tool
  if(mx>749 && mx<826 && my>548 && my<561){ selectstairstool(); paintmode=4;drawselect=0;renderyesno=0;}  //Stair tool
  if(mx>830 && mx<907 && my>548 && my<561){ selectarchtool(); paintmode=5;drawselect=0;renderyesno=0;rendermodez=0;}  //Arch tool
  
  if(mx>425 && mx<502 && my>564 && my<577){ selectpointtool(); paintmode=6;renderyesno=0;drawselect=0;}    // Point tool
  if(mx>505 && mx<583 && my>564 && my<577){ selecttexturetool(); paintmode=7;renderyesno=0;drawselect=0;rendermodez=3; }    // Texture tool
  if(mx>587 && mx<664 && my>564 && my<577){ paintmode=8; renderyesno=0;drawselect=0;}    // Morph tool
  if(mx>668 && mx<745 && my>564 && my<577){ selectpipertool(); paintmode=9; renderyesno=0;drawselect=0;}    // test tool
   

  //render 64 / 32 or 16
  if(mx>113 && mx<150  && my>582 && my<596) {render64_32_16=64;calc_64_32_16();}
  if(mx>153 && mx<189  && my>582 && my<596) {render64_32_16=32;calc_64_32_16();}
  if(mx>192 && mx<228  && my>582 && my<596) {render64_32_16=16;calc_64_32_16();}

  if(mx>2 && mx<68 && my>585 && my<597){resize_sculpt(); } // resize sculpt

  //rendermodes solid wireframe etc
  if(mx>232 && mx<271 && my>584 && my<596){rendermodez=0;} //color
  if(mx>271 && mx<310 && my>584 && my<596){rendermodez=1;} //solid
  if(mx>310 && mx<349 && my>584 && my<596){rendermodez=2;} //wire
  if(mx>349 && mx<388 && my>584 && my<596){rendermodez=3;} //texture

  if(mx>424 && mx<461 && my>584 && my<596){rendertype=1;}//sphere
  if(mx>462 && mx<500 && my>584 && my<596){rendertype=2;}//torus
  if(mx>501 && mx<539 && my>584 && my<596){rendertype=3;}//plane
  if(mx>540 && mx<578 && my>584 && my<596){rendertype=4;}//cylinder
  
  if(mx>586 && mx<623 && my>584 && my<596){if(showgrid==0){showgrid=1;}else{showgrid=0;} }//grid
  if(mx>629 && mx<644 && my>583 && my<596){if(texture_lighton==true){texture_lighton=false;}else{texture_lighton=true;}}//basic lightning

  
  
  //rotate model with mouse dragging - not really perfect yet  
  if(mx>0 && mx<406 && my>32 && my<538){rotatedrag=1;}//outdated: updated in arcball
  
  //load / save buttons
  if(mx>67 && mx<176 && my>3 && my<15){loadnew64sculptimage();}
  if(mx>67 && mx<176 && my>18 && my<31){loadnewtexture();}
  if(mx>273 && mx<425 && my>3 && my<15){savesculpt64png();}
  if(mx>273 && mx<425 && my>18 && my<31){savesculpt256tga();}
  if(mx>323 && mx<425 && my>35 && my<47){loadsave_saveobj();} //save as .obj


// if (undostep_back>0){image(undo_back, 192, 2);}
// if (undostep_forward>0){image(undo_forward, 227, 2);}
//undostep=0;
//int undostep_forward=0;
//int undostep_back=0;

  //undo!
  if (undostep_back>0)
  {
    if(mx>191 && mx<224 && my>1 && my<16)
    {
       undostep_forward++;
       undostep_back--;
      generate_scuptxyz_undo(-1);
      //println("undo back");
      
    }
  }
  if (undostep_forward>0)
  {
    if(mx>227 && mx<258 && my>1 && my<16)
    {
       undostep_forward--;
       undostep_back++;
      generate_scuptxyz_undo(1);
     // println("undo forward");
    }
    
  }
  

//  if(mx>13 && mx<26 && my>552 && my<565){extray=extray+0.1;} // rotate sculpt
//  if(mx>43 && mx<57 && my>552 && my<565){extray=extray-0.1;} 
//  if(mx>27 && mx<42 && my>536 && my<550){extrax=extrax+0.1;} 
//  if(mx>27 && mx<42 && my>567 && my<581){extrax=extrax-0.1;}   
//  if(mx>14 && mx<27 && my>539 && my<551){extraz=extraz-0.1;} // rotate sculpt
//  if(mx>43 && mx<56 && my>566 && my<579){extraz=extraz+0.1;} // rotate sculpt
  
  if(paintmode==9) // ---------------------------------mouse Sub tool------------------------------
  {
      if(mx>440 && mx<696 && my>8 && my<264) //left copybox - select multiply is handled now in mouserelease             
      {      
        sub_mx1=mx;
        sub_my1=my;
        sub_mx2=mx;
        sub_my2=my;              
        sub_mxmycount_a=1;
      }
      if(mx>702 && mx<958 && my>8 && my<264) //right pastebox - select multiply is handled now in mouserelease             
      {      
        sub_mx1=mx;
        sub_my1=my;
        sub_mx2=mx;
        sub_my2=my;              
        sub_mxmycount_b=1;
      }

      if(mx>528 && mx<605 && my>277 && my<290){sub_clearcopybuff();} //clear copybuff
      if(mx>791 && mx<868 && my>277 && my<290){sub_clearpastebuff();} //clear pastebuff
      
      if(mx>879 && mx<957 && my>277 && my<290){sub_getpastebuff();} //get the pastebuff model
      
      if(mx>702 && mx<779 && my>277 && my<290){sub_copytopastebuff();} //get the pastebuff model
      
      
    // pipe_clickstatus++;
    // if(pipe_clickstatus>1){ pipe_clickstatus=0; }
  }
  
  if(paintmode==8) // ---------------------------------mouse Morph tool------------------------------
  {
    
      if(mx>778 && mx<843 && my>4 && my<17){morph_copyto_a();}
      if(mx>872 && mx<937 && my>4 && my<17){morph_copyto_b();}
    
      if(mx>778 && mx<843 && my>95 && my<108){morph_get_a();}
      if(mx>872 && mx<937 && my>95 && my<108){morph_get_b();}
      
      if(mx>777 && mx<938 && my>134 && my<151){morph_mixvalue=mx-778; morph_mix_ab(morph_mixvalue);}
      
      if(mx>668 && mx<744 && my>470 && my<483){reset_to_torus(); flipimage_256();} // reset to torus
      if(mx>667 && mx<744 && my>485 && my<497){reset_to_pyramid();flipimage_256(); } // reset to pyramid
      if(mx>667 && mx<744 && my>500 && my<512){ reset_to_cylinder();flipimage_256();} // reset to cylinder
      if(mx>667 && mx<744 && my>515 && my<528){ reset_to_cube();flipimage_256();} // reset to cube
      if(mx>667 && mx<744 && my>529 && my<542){reset_to_sphere();flipimage_256();} // reset to sphere
      if(mx>667 && mx<744 && my>455 && my<468){stone_resetplane();flipimage_256();} // reset to plane      
      if(mx>747 && mx<760 && my>455 && my<468){stone_resetplane_triangle();flipimage_256();} // reset to plane - triangle
      if(mx>762 && mx<775 && my>455 && my<468){stone_resetplane_round(); flipimage_256();} // reset to plane - roundish   
      if(mx>747 && mx<760 && my>515 && my<528){stone_reset_archplanecube(); flipimage_256();}

      if(mx>879 && mx<956 && my>432 && my<445){morph_clearmultiple();}
      
      if(mx>699 && mx<956 && my>167 && my<424)
      {      
        //select multiply is handled now in mouserelease       
        point_mx1=mx;
        point_my1=my;
        point_mx2=mx;
        point_my2=my;
        point_mxmycount=1;      
      }
      
      if(mx>616 && mx<693 &&  my>4 && my<17){morph_smooth();}   //smooth sculpt +locked    
      if(mx>616 && mx<693 && my>21 && my<34){morph_smooth_torus();}   //smooth sculpt torus +locked   
      if(mx>616 && mx<693 && my>38 && my<51){morph_smooth_plane();}   //smooth sculpt plane +locked
      
      
    
  }
  
  if(paintmode==7) // ---------------------------------mouse texture sketch------------------------------
  {
    //baking stuff
    if(mx>566 && mx<643 && my>327 && my<340){texture_normalmap_test();} // normalmap test
    

    if(mx>545 && mx<582 && my>202 && my<215){ if(texture_bake_r==true){texture_bake_r=false;}else{texture_bake_r=true;} texture_bake(0);} // red
    if(mx>586 && mx<623 && my>202 && my<215){ if(texture_bake_g==true){texture_bake_g=false;}else{texture_bake_g=true;} texture_bake(0);} // green
    if(mx>627 && mx<664 && my>202 && my<215){ if(texture_bake_b==true){texture_bake_b=false;}else{texture_bake_b=true;} texture_bake(0);} // blue
    
    if(mx>545 && mx<582 && my>219 && my<232){if(texture_bake_rgrey==true){texture_bake_rgrey=false;}else{texture_bake_rgrey=true;} texture_bake(0);} // grey - red 
    if(mx>586 && mx<623 && my>219 && my<232){if(texture_bake_ggrey==true){texture_bake_ggrey=false;}else{texture_bake_ggrey=true;} texture_bake(0);} // grey - green
    if(mx>627 && mx<664 && my>219 && my<232){if(texture_bake_bgrey==true){texture_bake_bgrey=false;}else{texture_bake_bgrey=true;} texture_bake(0);} // grey - blue

    if(mx>573 && mx<638 && my>237 && my<250){texture_bake(0);} // bake texture
    
    if(mx>542 && mx<555 && my>258 && my<271){texture_shaderotate(0,-bakerotate);} // shading rotate X  x=0 y=1 z=2 
    if(mx>566 && mx<579 && my>258 && my<271){texture_shaderotate(0, bakerotate);} // shading rotate X  x=0 y=1 z=2 
    if(mx>587 && mx<600 && my>258 && my<271){texture_shaderotate(1,-bakerotate);} // shading rotate Y  x=0 y=1 z=2 
    if(mx>611 && mx<624 && my>258 && my<271){texture_shaderotate(1, bakerotate);} // shading rotate Y  x=0 y=1 z=2 
    if(mx>631 && mx<644 && my>258 && my<271){texture_shaderotate(2,-bakerotate);} // shading rotate Z  x=0 y=1 z=2 
    if(mx>655 && mx<668 && my>258 && my<271){texture_shaderotate(2, bakerotate);} // shading rotate Z  x=0 y=1 z=2 
  
    
    
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
          texture_512drawing=1;
        }
        /*
        if(texturesize==2)
        {
          textureimg1024.loadPixels();
          drawsprite3(mask1.pixels, textureimg1024.pixels, (mx-700)*4, (my-4)*4, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 1024);
          textureimg1024.updatePixels();
        }
        */
      }
      
//     if(texturesize==0){image(textureimg, 701, 4);}
//     if(texturesize==1){image(textureimg512, 701, 4, 256, 256);}
//     if(texturesize==2){image(textureimg1024, 701, 4, 256, 256);}      
  
       //draw on seamless textured preview
       /*
      if(mx>700 && mx<828 && my>275 && my<403)
      {
        textureimg.loadPixels();
        drawsprite3(mask1.pixels, textureimg.pixels, (mx-700)*2, (my-275)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256 );
        textureimg.updatePixels();
      }
      if(mx>828 && mx<956 && my>275 && my<403)
      {
        textureimg.loadPixels();
        drawsprite3(mask1.pixels, textureimg.pixels, (mx-828)*2, (my-275)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256 );
        textureimg.updatePixels();
      }
      if(mx>700 && mx<828 && my>403 && my<531)
      {
        textureimg.loadPixels();
        drawsprite3(mask1.pixels, textureimg.pixels, (mx-700)*2, (my-403)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256 );
        textureimg.updatePixels();
      }
      if(mx>828 && mx<956 && my>403 && my<531)
      {
        textureimg.loadPixels();
        drawsprite3(mask1.pixels, textureimg.pixels, (mx-828)*2, (my-403)*2, 64,64,  brush_size,brush_size,  color_tex_r,color_tex_g,color_tex_b, 256 );
        textureimg.updatePixels();
      }*/      
    }
    if(color_pickdraw==1)//get color
    { 
      if(mx>700 && mx<957 && my>4 && my<260)
      {
        if(texturesize==0)
        {
          texture_colorpick(mx-700,my-4,textureimg.pixels, 256); //texture_colorpick(int x, int y, int background[],int w)
        }
        if(texturesize==1)
        {
          texture_colorpick((mx-700)*2,(my-4)*2,textureimg512.pixels, 512); //texture_colorpick(int x, int y, int background[],int w)
        }
       // if(texturesize==2)
       // {
       //   texture_colorpick((mx-700)*4,(my-4)*4,textureimg1024.pixels, 1024); //texture_colorpick(int x, int y, int background[],int w)
       // }        
      }
    }    
    if(mx>440 && mx<696 && my>4 && my<20){color_tex_r=mx-440; drawcolorbar_rgb();}    
    if(mx>440 && mx<696 && my>22 && my<38){color_tex_g=mx-440; drawcolorbar_rgb();}    
    if(mx>440 && mx<696 && my>40 && my<56){color_tex_b=mx-440; drawcolorbar_rgb();}   
    if(mx>566 && mx<695 && my>78 && my<92){brush_size=mx-566;}    
    if(mx>566 && mx<695 && my>96 && my<111){brush_opacity=mx-566;}
    
    if(mx>606 && mx<643 && my>60 && my<73){color_pickdraw=0;}
    if(mx>566 && mx<603 && my>60 && my<73){color_pickdraw=1;}
    
    if(mx>567 && mx<582 && my>116 && my<131){mask1=loadImage("data/msk1.gif");brushtype=0;}
    if(mx>585 && mx<600 && my>116 && my<131){mask1=loadImage("data/msk2.gif");brushtype=1;}
    if(mx>603 && mx<618 && my>116 && my<131){mask1=loadImage("data/msk3.gif");brushtype=2;}
    if(mx>621 && mx<636 && my>116 && my<131){mask1=loadImage("data/msk4.gif");brushtype=3;}
    if(mx>639 && mx<654 && my>116 && my<131){mask1=loadImage("data/msk5.gif");brushtype=4;}
    if(mx>657 && mx<672 && my>116 && my<131){mask1=loadImage("data/msk6.gif");brushtype=5;}
    
    if(mx>566 && mx<603 && my>153 && my<166){renderyesno=0;}
    if(mx>607 && mx<644 && my>153 && my<166){renderyesno=1;}

    if(mx>566 && mx<603 && my>136 && my<149){texturesize=0;}
    if(mx>606 && mx<643 && my>136 && my<149){texturesize=1;}
    //if(mx>647 && mx<686 && my>136 && my<149){texturesize=2;}
    
    if(mx>565 && mx<630 && my>175 && my<188){savetexturetga();} // save texture 


    if(mx>566 && mx<647 && my>493 && my<508){texture_undofilter();} // undo last filter

    if(mx>523 && mx<562 && my>375 && my<390){texture_filter01();}
    if(mx>565 && mx<604 && my>375 && my<390){texture_filter02();}
    if(mx>607 && mx<646 && my>375 && my<390){texture_filter03();}
    if(mx>649 && mx<688 && my>375 && my<390){texture_filter04();}

    if(mx>523 && mx<562 && my>393 && my<408){texture_filter05();}
    if(mx>565 && mx<604 && my>393 && my<408){texture_filter06();}
    if(mx>607 && mx<646 && my>393 && my<408){texture_filter07();}
    if(mx>649 && mx<688 && my>393 && my<408){texture_filter08();}
    
    if(mx>523 && mx<562 && my>411 && my<426){texture_filter09();}
    if(mx>565 && mx<604 && my>411 && my<426){texture_filter10();}
    if(mx>607 && mx<646 && my>411 && my<426){texture_filter11();}
    if(mx>649 && mx<688 && my>411 && my<426){texture_filter12();}

    if(mx>523 && mx<562 && my>430 && my<444){texture_filter13();}
    if(mx>565 && mx<604 && my>430 && my<444){texture_filter14();}
    if(mx>607 && mx<646 && my>430 && my<444){texture_filter15();}
    if(mx>649 && mx<688 && my>430 && my<444){texture_filter16();}

    if(mx>523 && mx<562 && my>447 && my<462){texture_filter17();}
    if(mx>565 && mx<604 && my>447 && my<462){texture_filter18();}
    if(mx>607 && mx<646 && my>447 && my<462){texture_filter19();}
    if(mx>649 && mx<688 && my>447 && my<462){texture_filter20();}
    
    if(mx>523 && mx<562 && my>465 && my<480){texture_filter21();}
    if(mx>565 && mx<604 && my>465 && my<480){texture_filter22();}
    if(mx>607 && mx<646 && my>465 && my<480){texture_filter23();}
    if(mx>649 && mx<688 && my>465 && my<480){texture_filter24();}
    
    if(mx>611 && mx<688 && my>517 && my<530){textureviewdetail=0;} //seamless preview
    if(mx>529 && mx<606 && my>517 && my<530)
    {
      textureviewdetail=1;
      texdetail.copy(textureimg512, texture_tex512x, texture_tex512y, texture_tex512x+256,texture_tex512y+256, 0, 0, 256, 256);
      texdetail.updatePixels();
    } //512 detail
    
    
    if(textureviewdetail==1)
    {
       if(texturesize==1)
       {
         if(mx>700 && mx<957 && my>274 && my<531)//512 detail preview clicked
         {      
           texture_tex512x=mx-701;   //512-texture detail
           texture_tex512y=my-275;
           texdetail.copy(textureimg512, texture_tex512x, texture_tex512y, texture_tex512x+256,texture_tex512y+256, 0, 0, 256, 256);
           texdetail.updatePixels();
         }
       }
    } 


  }

  if(paintmode==6) // ---------------------------------mouse point tool------------------------------
  {
    //if(mx>701 && mx<778 && my>270 && my<283){if(smoothpoint==1){smoothpoint=0;}else{smoothpoint=1;}}
    //if(mx>781 && mx<859 && my>270 && my<283){if(select_multiple==1){select_multiple=0;}else{select_multiple=1;}}
    if(mx>781 && mx<859 && my>270 && my<283){point_clearmultiple();} 

    if(mx>863 && mx<940 && my>270 && my<283) {stone_smooth();}
    if(mx>863 && mx<940 && my>287 && my<300){stone_smooth_torus();}
    if(mx>863 && mx<940 && my>303 && my<317){stone_smooth_plane();}
    
    
    if(mx>611 && mx<650 && my>243 && my<258) {point_rotscalearound=0;} //rotate-scale around 0,0,0
    if(mx>653 && mx<692 && my>243 && my<258) {point_rotscalearound=1;} //rotate-scale around selected
    

 //  point_tool_rotate(0,-1.0); // X and min
//   point_tool_rotate(0, 1.0); // X and min

    if(mx>644 && mx<665 && my>179 && my<192){point_tool_rotate(0, -1.0f);}//rotate around X
    if(mx>669 && mx<690 && my>179 && my<192){point_tool_rotate(0,  1.0f);}
    
    if(mx>644 && mx<665 && my>195 && my<208){point_tool_rotate(1, -1.0f);}//rotate around Y
    if(mx>669 && mx<690 && my>195 && my<208){point_tool_rotate(1,  1.0f);}

    if(mx>644 && mx<665 && my>211 && my<224){point_tool_rotate(2, -1.0f);}//rotate around Z
    if(mx>669 && mx<690 && my>211 && my<224){point_tool_rotate(2,  1.0f);}


    if(mx>644 && mx<665 && my>8 && my<21){point_tool_scalex(1.0f-arch_stepscaling);}
    if(mx>669 && mx<690 && my>8 && my<21){point_tool_scalex(1.0f+arch_stepscaling);}
    
    if(mx>644 && mx<665 && my>24 && my<37){point_tool_scaley(1.0f-arch_stepscaling);}
    if(mx>669 && mx<690 && my>24 && my<37){point_tool_scaley(1.0f+arch_stepscaling);}
    
    if(mx>644 && mx<665 && my>40 && my<53){point_tool_scalez(1.0f-arch_stepscaling);}
    if(mx>669 && mx<690 && my>40 && my<53){point_tool_scalez(1.0f+arch_stepscaling);}

    if(mx>644 && mx<665 && my>60 && my<73){point_tool_translatex(-1.0f*arch_steptranslate);}
    if(mx>669 && mx<690 && my>60 && my<73){point_tool_translatex(1.0f*arch_steptranslate);}
    
    if(mx>644 && mx<665 && my>76 && my<89){point_tool_translatey(-1.0f*arch_steptranslate);}
    if(mx>669 && mx<690 && my>76 && my<89){point_tool_translatey(1.0f*arch_steptranslate);}
    
    if(mx>644 && mx<665 && my>92 && my<105){point_tool_translatez(-1.0f*arch_steptranslate);}
    if(mx>669 && mx<690 && my>92 && my<105){point_tool_translatez(1.0f*arch_steptranslate);}
    
    
       if(mx>569 && mx<607 && my>146 && my<161) //step small
       {
         arch_stepsize=0;
         arch_stepscaling=0.005f; //scaling  
         arch_steptranslate=0.25; //translation
         arch_steprotate=(float)(PI/360.0f); ////rotate xx-small degrees
       } 
       if(mx>612 && mx<649 && my>146 && my<161) //step medium
       {
         arch_stepsize=1;
         arch_stepscaling=0.05f; //scaling  
         arch_steptranslate=5.0; //translation
         arch_steprotate=(float)(PI/16.0f); //rotate 22.5 degrees  //(float)(PI/8.0f); //rotate 22.5 degrees
       } 
       if(mx>654 && mx<691 && my>146 && my<161) //step large   
       {
         arch_stepsize=2;
         arch_stepscaling=0.15f; //scaling  
         arch_steptranslate=10.0; //translation
         arch_steprotate=(float)(PI/4.0f); //rotate 45 degrees
       }     
    
//if(mx>773 && mx<788 && my>2 && my<514){scale_ring2xz(ringy, 1.0f-arch_stepscaling, 0);}//scale rings xz
//if(mx>793 && mx<808 && my>2 && my<514){scale_ring2xz(ringy, 1.0f+arch_stepscaling, 0);}
//if(mx>823 && mx<838 && my>2 && my<514){translate_ring2x(ringy, -1.0f*arch_steptranslate); }//translate rings x
//if(mx>843 && mx<858 && my>2 && my<514){translate_ring2x(ringy, 1.0f*arch_steptranslate); }
    
    

    if(mx>640 && mx<655 && my>116 && my<127){ if(symmetry_x==0){symmetry_x=1;} else{symmetry_x=0;} }
    if(mx>658 && mx<673 && my>116 && my<127){ if(symmetry_y==0){symmetry_y=1;} else{symmetry_y=0;} }
    if(mx>676 && mx<691 && my>116 && my<127){ if(symmetry_z==0){symmetry_z=1;} else{symmetry_z=0;} }

    if(mx>701 && mx<956 && my>8 && my<263)
    {
      
      selx=(mx-701)/4;
      sely=(my-8)/4;
      if(select_multiple==0)
      {    
        pointselectx=selx/2;
        pointselecty=sely/2;
      }
      /*
      if(select_multiple==1)
      {
        int ppx=selx/2;
        int ppy=sely/2;
        if (point_mul[(ppy*32)+ppx]==1){point_mul[(ppy*32)+ppx]=0;}
        else {point_mul[(ppy*32)+ppx]=1;}
      }
      */
      //select multiply is handled now in mouserelease 
      if(smoothpoint==1){point_smooth1();}
      
      point_mx1=mx;
      point_my1=my;
      point_mx2=mx;
      point_my2=my;
      point_mxmycount=1;
      
    }
    //int point_mx1,point_my1,point_mx2,point_my2; //to select a bunch
    
      if(mx>668 && mx<744 && my>470 && my<483){reset_to_torus(); flipimage_256();} // reset to torus
      if(mx>667 && mx<744 && my>485 && my<497){reset_to_pyramid();flipimage_256(); } // reset to pyramid
      if(mx>667 && mx<744 && my>500 && my<512){ reset_to_cylinder();flipimage_256();} // reset to cylinder
      if(mx>667 && mx<744 && my>515 && my<528){ reset_to_cube();flipimage_256();} // reset to cube
      if(mx>667 && mx<744 && my>529 && my<542){reset_to_sphere();flipimage_256();} // reset to sphere
      if(mx>667 && mx<744 && my>455 && my<468){stone_resetplane();flipimage_256();} // reset to plane      
      if(mx>747 && mx<760 && my>455 && my<468){stone_resetplane_triangle();flipimage_256();} // reset to plane - triangle
      if(mx>762 && mx<775 && my>455 && my<468){stone_resetplane_round(); flipimage_256();} // reset to plane - roundish    
      if(mx>747 && mx<760 && my>515 && my<528){stone_reset_archplanecube(); flipimage_256();}
    
  }
  
  if(paintmode==5) // ---------------------------------mouse arch tool------------------------------
  {
       int p=0;
       if(mx>619 && mx<657 && my>444 && my<459) {arch_rotscalearound=0;} //rot/scale around 0,0,0
       if(mx>662 && mx<699 && my>444 && my<459) {arch_rotscalearound=1;} //rot/scale around ring
       if(mx>704 && mx<742 && my>444 && my<459) {arch_rotscalearound=2;} //rot/scale around selected rings

       if(mx>750 && mx<763 && my>2 && my<514)//select multiply rings
       {         
         //int whatring=(my-2)/16;
         //if(arch_ringselect[whatring]==1){arch_ringselect[whatring]=0;}else{arch_ringselect[whatring]=1;}
         
         //ringselect now handled in mouserelease section 
         //point_mx1=mx;
         point_my1=my;
        // point_mx2=mx;
         point_my2=my;
         point_mxmycount=1;       
       }
       if(mx>619 && mx<658 && my>500 && my<514){ if(archmirrory==0){archmirrory=1;}else{archmirrory=0;} }//mirror Y on or off
       
       
       
       //----scale rings----
       if(archdrawmode==0)
       {
         if(arch_ringselect[ringy/2]==0)//no multiple rings selected
         {
           if(mx>773 && mx<788 && my>2 && my<514){p=1; scale_ring2xz(ringy, 1.0f-arch_stepscaling, 0);}//scale rings xz
           if(mx>793 && mx<808 && my>2 && my<514){p=1; scale_ring2xz(ringy, 1.0f+arch_stepscaling, 0);}
           if(mx>823 && mx<838 && my>2 && my<514){p=1; scale_ring2x(ringy, 1.0f-arch_stepscaling, 0);}//scale rings x
           if(mx>843 && mx<858 && my>2 && my<514){p=1; scale_ring2x(ringy, 1.0f+arch_stepscaling, 0);}
           if(mx>873 && mx<888 && my>2 && my<514){p=1; scale_ring2z(ringy, 1.0f-arch_stepscaling, 0);}//scale rings z
           if(mx>893 && mx<908 && my>2 && my<514){p=1; scale_ring2z(ringy, 1.0f+arch_stepscaling, 0);}
           if(mx>923 && mx<938 && my>2 && my<514){p=1; scale_ring2y(ringy, 1.0f-arch_stepscaling, 0);}//scale rings y
           if(mx>943 && mx<958 && my>2 && my<514){p=1; scale_ring2y(ringy, 1.0f+arch_stepscaling, 0);}           
           if(archmirrory==1)//mirrored?! ringy: 0 - 62 mid 32
           { 
             int tempringy= 62-ringy;
             if(mx>773 && mx<788 && my>2 && my<514){p=1; scale_ring2xz(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings xz
             if(mx>793 && mx<808 && my>2 && my<514){p=1; scale_ring2xz(tempringy, 1.0f+arch_stepscaling, 1);}//scale rings
             if(mx>823 && mx<838 && my>2 && my<514){p=1; scale_ring2x(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings x
             if(mx>843 && mx<858 && my>2 && my<514){p=1; scale_ring2x(tempringy, 1.0f+arch_stepscaling, 1);}//scale rings
             if(mx>873 && mx<888 && my>2 && my<514){p=1; scale_ring2z(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings z
             if(mx>893 && mx<908 && my>2 && my<514){p=1; scale_ring2z(tempringy, 1.0f+arch_stepscaling, 1);}//scale rings
             if(mx>923 && mx<938 && my>2 && my<514){p=1; scale_ring2y(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings y
             if(mx>943 && mx<958 && my>2 && my<514){p=1; scale_ring2y(tempringy, 1.0f+arch_stepscaling, 1);}//scale rings           
           }
           if(p==1){generate_scuptxyz();}
         }
         if(arch_ringselect[ringy/2]==1)//multiple rings selected 0-31
         {
           for(int i=0;i<32;i++)
           {
             if(arch_ringselect[i]==1)
             {
               if(mx>773 && mx<788 && my>2 && my<514){p=1; scale_ring2xz(i*2, 1.0f-arch_stepscaling, 0);}//scale rings xz
               if(mx>793 && mx<808 && my>2 && my<514){p=1; scale_ring2xz(i*2, 1.0f+arch_stepscaling, 0);}
               if(mx>823 && mx<838 && my>2 && my<514){p=1; scale_ring2x(i*2, 1.0f-arch_stepscaling, 0);}//scale rings x
               if(mx>843 && mx<858 && my>2 && my<514){p=1; scale_ring2x(i*2, 1.0f+arch_stepscaling, 0);}
               if(mx>873 && mx<888 && my>2 && my<514){p=1; scale_ring2z(i*2, 1.0f-arch_stepscaling, 0);}//scale rings z
               if(mx>893 && mx<908 && my>2 && my<514){p=1; scale_ring2z(i*2, 1.0f+arch_stepscaling, 0);}
               if(mx>923 && mx<938 && my>2 && my<514){p=1; scale_ring2y(i*2, 1.0f-arch_stepscaling, 0);}//scale rings y
               if(mx>943 && mx<958 && my>2 && my<514){p=1; scale_ring2y(i*2, 1.0f+arch_stepscaling, 0);}           
               if(archmirrory==1)//mirrored?! ringy: 0 - 62 mid 32
               { 
                 int tempringy= 62-(i*2);
                 if(mx>773 && mx<788 && my>2 && my<514){p=1; scale_ring2xz(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings xz
                 if(mx>793 && mx<808 && my>2 && my<514){p=1; scale_ring2xz(tempringy, 1.0f+arch_stepscaling, 1);}
                 if(mx>823 && mx<838 && my>2 && my<514){p=1; scale_ring2x(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings x
                 if(mx>843 && mx<858 && my>2 && my<514){p=1; scale_ring2x(tempringy, 1.0f+arch_stepscaling, 1);}
                 if(mx>873 && mx<888 && my>2 && my<514){p=1; scale_ring2z(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings z
                 if(mx>893 && mx<908 && my>2 && my<514){p=1; scale_ring2z(tempringy, 1.0f+arch_stepscaling, 1);}
                 if(mx>923 && mx<938 && my>2 && my<514){p=1; scale_ring2y(tempringy, 1.0f-arch_stepscaling, 1);}//scale rings y
                 if(mx>943 && mx<958 && my>2 && my<514){p=1; scale_ring2y(tempringy, 1.0f+arch_stepscaling, 1);}
               }
             }
           }
           if(p==1){generate_scuptxyz();}
         }                
       }
       //----end scale rings----
       

       
       //----translate rings----       
       if(archdrawmode==1)
       {
         if(arch_ringselect[ringy/2]==0)//no multiple rings selected
         {
           if(mx>823 && mx<838 && my>2 && my<514){p=1; translate_ring2x(ringy, -1.0f*arch_steptranslate); }//translate rings x
           if(mx>843 && mx<858 && my>2 && my<514){p=1; translate_ring2x(ringy, 1.0f*arch_steptranslate); }
           if(mx>873 && mx<888 && my>2 && my<514){p=1; translate_ring2z(ringy, -1.0f*arch_steptranslate);}//translate rings z
           if(mx>893 && mx<908 && my>2 && my<514){p=1; translate_ring2z(ringy, 1.0f*arch_steptranslate);}
           if(mx>923 && mx<938 && my>2 && my<514){p=1; translate_ring2y(ringy, -1.0f*arch_steptranslate);}//translate rings y
           if(mx>943 && mx<958 && my>2 && my<514){p=1; translate_ring2y(ringy, 1.0f*arch_steptranslate);}           
           if(archmirrory==1)//mirrored?! ringy: 0 - 62 mid 32
           { 
             int tempringy= 62-ringy;
             if(mx>823 && mx<838 && my>2 && my<514){p=1; translate_ring2x(tempringy, -1.0f*arch_steptranslate); }//translate rings x
             if(mx>843 && mx<858 && my>2 && my<514){p=1; translate_ring2x(tempringy, 1.0f*arch_steptranslate); }
             if(mx>873 && mx<888 && my>2 && my<514){p=1; translate_ring2z(tempringy, -1.0f*arch_steptranslate);}//translate rings z
             if(mx>893 && mx<908 && my>2 && my<514){p=1; translate_ring2z(tempringy, 1.0f*arch_steptranslate);}
             if(mx>923 && mx<938 && my>2 && my<514){p=1; translate_ring2y(tempringy, -1.0f*arch_steptranslate);}//translate rings y
             if(mx>943 && mx<958 && my>2 && my<514){p=1; translate_ring2y(tempringy, 1.0f*arch_steptranslate);}
           }
           if(p==1){generate_scuptxyz();}
         }
         if(arch_ringselect[ringy/2]==1)//multiple rings selected 0-31
         {
           for(int i=0;i<32;i++)
           {
             if(arch_ringselect[i]==1)
             {
               if(mx>823 && mx<838 && my>2 && my<514){p=1; translate_ring2x(i*2, -1.0f*arch_steptranslate); }//translate rings x
               if(mx>843 && mx<858 && my>2 && my<514){p=1; translate_ring2x(i*2, 1.0f*arch_steptranslate); }
               if(mx>873 && mx<888 && my>2 && my<514){p=1; translate_ring2z(i*2, -1.0f*arch_steptranslate);}//translate rings z
               if(mx>893 && mx<908 && my>2 && my<514){p=1; translate_ring2z(i*2, 1.0f*arch_steptranslate);}
               if(mx>923 && mx<938 && my>2 && my<514){p=1; translate_ring2y(i*2, -1.0f*arch_steptranslate);}//translate rings y
               if(mx>943 && mx<958 && my>2 && my<514){p=1; translate_ring2y(i*2, 1.0f*arch_steptranslate);}           
               if(archmirrory==1)//mirrored?! ringy: 0 - 62 mid 32
               { 
                 int tempringy= 62-(i*2);
                 if(mx>823 && mx<838 && my>2 && my<514){p=1; translate_ring2x(tempringy, -1.0f*arch_steptranslate); }//translate rings x
                 if(mx>843 && mx<858 && my>2 && my<514){p=1; translate_ring2x(tempringy, 1.0f*arch_steptranslate); } 
                 if(mx>873 && mx<888 && my>2 && my<514){p=1; translate_ring2z(tempringy, -1.0f*arch_steptranslate);}//translate  rings z
                 if(mx>893 && mx<908 && my>2 && my<514){p=1; translate_ring2z(tempringy, 1.0f*arch_steptranslate);}
                 if(mx>923 && mx<938 && my>2 && my<514){p=1; translate_ring2y(tempringy, -1.0f*arch_steptranslate);}//translate  rings y
                 if(mx>943 && mx<958 && my>2 && my<514){p=1; translate_ring2y(tempringy, 1.0f*arch_steptranslate);}
               }               
             }
           }
           if(p==1){generate_scuptxyz();}
         }
         
       }
       //----end translate rings----       
       
       //----rotate rings----              
       if(archdrawmode==2)
       {
         ////no multiple rings selected
         if(arch_ringselect[ringy/2]==0)
         {         
           if(mx>823 && mx<838 && my>2 && my<514){p=1; rotate_ring2x(ringy,  1, 0);}//rotate rings x
           if(mx>843 && mx<858 && my>2 && my<514){p=1; rotate_ring2x(ringy, -1, 0);}
           if(mx>873 && mx<888 && my>2 && my<514){p=1; rotate_ring2z(ringy,  -1, 0);}//rotate rings z
           if(mx>893 && mx<908 && my>2 && my<514){p=1; rotate_ring2z(ringy,  1, 0);}
           if(mx>923 && mx<938 && my>2 && my<514){p=1; rotate_ring2y(ringy,  -1, 0);}//rotate rings y
           if(mx>943 && mx<958 && my>2 && my<514){p=1; rotate_ring2y(ringy,  1, 0);}
           if(archmirrory==1)//mirrored?! ringy: 0 - 62 mid 32
           { 
             int tempringy= 62-ringy;
             if(mx>823 && mx<838 && my>2 && my<514){p=1; rotate_ring2x(tempringy,  -1, 1);}//rotate rings x
             if(mx>843 && mx<858 && my>2 && my<514){p=1; rotate_ring2x(tempringy,   1, 1);}
             if(mx>873 && mx<888 && my>2 && my<514){p=1; rotate_ring2z(tempringy,  -1, 1);}//rotate rings z
             if(mx>893 && mx<908 && my>2 && my<514){p=1; rotate_ring2z(tempringy,   1, 1);}
             if(mx>923 && mx<938 && my>2 && my<514){p=1; rotate_ring2y(tempringy,  -1, 1);}//rotate rings y
             if(mx>943 && mx<958 && my>2 && my<514){p=1; rotate_ring2y(tempringy,   1, 1);}
           }
           if(p==1){generate_scuptxyz();}
         }
         //--------------//multiple rings selected
         if(arch_ringselect[ringy/2]==1)
         {  
           for(int i=0;i<32;i++)
           {
             if(arch_ringselect[i]==1)
             {           
               if(mx>823 && mx<838 && my>2 && my<514){p=1; rotate_ring2x(i*2,  1, 0);}//rotate rings x
               if(mx>843 && mx<858 && my>2 && my<514){p=1; rotate_ring2x(i*2, -1, 0);}
               if(mx>873 && mx<888 && my>2 && my<514){p=1; rotate_ring2z(i*2,  -1, 0);}//rotate rings z
               if(mx>893 && mx<908 && my>2 && my<514){p=1; rotate_ring2z(i*2,  1, 0);}
               if(mx>923 && mx<938 && my>2 && my<514){p=1; rotate_ring2y(i*2,  -1, 0);}//rotate rings y
               if(mx>943 && mx<958 && my>2 && my<514){p=1; rotate_ring2y(i*2,  1, 0);}
               if(archmirrory==1)//mirrored?! ringy: 0 - 62 mid 32
               { 
                 int tempringy= 62-(i*2);
                 if(mx>823 && mx<838 && my>2 && my<514){p=1; rotate_ring2x(tempringy,  -1, 1);}//rotate rings x
                 if(mx>843 && mx<858 && my>2 && my<514){p=1; rotate_ring2x(tempringy,  1, 1);}
                 if(mx>873 && mx<888 && my>2 && my<514){p=1; rotate_ring2z(tempringy,  1, 1);}//rotate rings z
                 if(mx>893 && mx<908 && my>2 && my<514){p=1; rotate_ring2z(tempringy,  -1, 1);}  
                 if(mx>923 && mx<938 && my>2 && my<514){p=1; rotate_ring2y(tempringy,  -1, 1);}//rotate rings y
                 if(mx>943 && mx<958 && my>2 && my<514){p=1; rotate_ring2y(tempringy,  1, 1);} 
               }
             }
           }
           if(p==1){generate_scuptxyz();}         
         }           
           
       }              
       //----end rotate rings----           
       
       //find position middle selected rings
       if(arch_rotscalearound==2) //rotate or scale around selected rings
       {
         boolean ringselected=false;
         float no_rings_selected=0.0f;
         for(int i=0;i<32;i++){ if (arch_ringselect[i]==1){ringselected=true;no_rings_selected++;}} //there are rings selected! 
         if(ringselected==true)//more then 1 ring selected
         {
           //now find middlepoint selected rings
           arch_rsx=0.0f;
           arch_rsy=0.0f;
           arch_rsz=0.0f;
           for(int ri=0;ri<32;ri++)
           {
             if (arch_ringselect[ri]==1)
             {
                for (int j=ri*2; j<(ri*2)+2; j++)
                {
                  for (int i=0; i<64; i++)
                  {
                    arch_rsx+=spx[(j*64)+i];
                    arch_rsy+=spy[(j*64)+i];
                    arch_rsz+=spz[(j*64)+i];
                  }
                }               
             }             
           }           
           arch_rsx=arch_rsx/((no_rings_selected*2.0f)*64.0f);
           arch_rsy=arch_rsy/((no_rings_selected*2.0f)*64.0f);
           arch_rsz=arch_rsz/((no_rings_selected*2.0f)*64.0f);
           
           
           //now find middle mirrored selected points           
           arch_mirrsx=0.0f;
           arch_mirrsy=0.0f;
           arch_mirrsz=0.0f;
           for(int ri=0;ri<32;ri++)
           {
             if (arch_ringselect[ri]==1)
             {
                    
                for (int j=ri*2; j<(ri*2)+2; j++) //0-31
                {
                  int tempringy= 63-(j);           
                  for (int i=0; i<64; i++)
                  {
                    arch_mirrsx+=spx[(tempringy*64)+i];
                    arch_mirrsy+=spy[(tempringy*64)+i];
                    arch_mirrsz+=spz[(tempringy*64)+i];
                  }
                }               
             }             
           }                      
           arch_mirrsx=arch_mirrsx/((no_rings_selected*2.0f)*64.0f);
           arch_mirrsy=arch_mirrsy/((no_rings_selected*2.0f)*64.0f);
           arch_mirrsz=arch_mirrsz/((no_rings_selected*2.0f)*64.0f);
           
           //println("selected x"+arch_rsx+" y: "+arch_rsy+" z: "+arch_rsz);           
           //println("selected mx"+arch_mirrsx+" my: "+arch_mirrsy+" mz: "+arch_mirrsz);           
         }         
       }

       
         
       if(mx>743 && mx<768 && my>517 && my<530) {  for(int i=0;i<32;i++){arch_ringselect[i]=0;} } //clear archselect
       
  
       if(mx>664 && mx<742 && my>467 && my<481) {archdrawmode=2;}//select rotate rings
       if(mx>664 && mx<742 && my>484 && my<497) {archdrawmode=1;}//select translate rings
       if(mx>664 && mx<742 && my>501 && my<514) {archdrawmode=0;}//select scale rings

       if(mx>611 && mx<697 && my>8 && my<21) {arch_rotatex(1);generate_scuptxyz();}
       if(mx>611 && mx<697 && my>24 && my<38) {arch_rotatex(-1);generate_scuptxyz();}
       if(mx>611 && mx<697 && my>40 && my<53) {arch_rotatey(1);generate_scuptxyz();}
       if(mx>611 && mx<697 && my>56 && my<69) {arch_rotatey(-1);generate_scuptxyz();}
       if(mx>611 && mx<697 && my>72 && my<85) {arch_rotatez(1);generate_scuptxyz();}
       if(mx>611 && mx<697 && my>89 && my<101) {arch_rotatez(-1);generate_scuptxyz();}

       if(mx>870 && mx<913 && my>531 && my<544) {reset_archcube();}
       if(mx>916 && mx<959 && my>531 && my<544) {reset_to_archpipe();}
       

       if(mx>620 && mx<657 && my>408 && my<422) //step small
       {
         arch_stepsize=0;
         arch_stepscaling=0.005f; //scaling  
         arch_steptranslate=0.25; //translation
         arch_steprotate=(float)(PI/360.0f); ////rotate xx-small degrees
       } 
       if(mx>662 && mx<699 && my>408 && my<422) //step medium
       {
         arch_stepsize=1;
         arch_stepscaling=0.05f; //scaling  
         arch_steptranslate=5.0; //translation
         arch_steprotate=(float)(PI/16.0f); //rotate 22.5 degrees  //(float)(PI/8.0f); //rotate 22.5 degrees
       } 
       if(mx>704 && mx<741 && my>408 && my<422) //step large   
       {
         arch_stepsize=2;
         arch_stepscaling=0.15f; //scaling  
         arch_steptranslate=10.0; //translation
         arch_steprotate=(float)(PI/4.0f); //rotate 45 degrees
       } 
       
       if(mx>612 && mx<698 && my>109 && my<122) {stone_smooth();}//arch_smooth();
       if(mx>612 && mx<698 && my>125 && my<138) {stone_smooth_torus();}
       


       //mirror functions
       if(mx>597 && mx<663 && my>175 && my<188) {arch_mirror_toptowardsbottom();}
       if(mx>666 && mx<732 && my>175 && my<188) {arch_mirror_bottomtowardstop();}

       if(mx>597 && mx<663 && my>191 && my<204) {arch_mirror_lefttoright();}
       if(mx>666 && mx<732 && my>191 && my<204) {arch_mirror_righttoleft();}

       if(mx>597 && mx<663 && my>207 && my<220) {arch_mirror_fronttoback();}
       if(mx>666 && mx<732 && my>207 && my<220) {arch_mirror_backtofront();}
              
       

  }
  
  if(paintmode==4) // ---------------------------------mouse stairs tool------------------------------
  {
      if(mx>750 && mx<826 && my>531 && my<542){ reset_to_stairscube();} // reset to stairscube

      if(mx>645 && mx<661 && my>10 && my<22){ stairtype=16;} // reset to cube
      if(mx>663 && mx<679 && my>10 && my<22){ stairtype=8;} // reset to cube
      if(mx>681 && mx<697 && my>10 && my<22){ stairtype=4;} // reset to cube
       
      if(mx>620 && mx<697 && my>26 && my<39){ incdec_stairs(1);} // inc
      if(mx>620 && mx<697 && my>43 && my<56){ incdec_stairs(-1);} // dec

  }
  if(paintmode==3) // ---------------------------------mouse stone tool------------------------------
  {
      if(mx>874 && mx<957 && my>270 && my<283){stone_transferto16();} //force 16
      if(mx>874 && mx<957 && my>286 && my<299){stone_transferto8();} //force 8
      if(mx>874 && mx<957 && my>302 && my<315){stone_transferto6();} //force 6
      
      if(mx>874 && mx<957 && my>318 && my<331){stone_transferto4();} //force 6
      if(mx>874 && mx<957 && my>334 && my<347){stone_transferto3();} //force 6
      
      if(mx>874 && mx<957 && my>350 && my<363){stone_forceto32sl();} //force to 33 like sl
      if(mx>874 && mx<957 && my>366 && my<379){stone_forceto32slhard();} //force to 33 like sl
      
      

//    stone_forceto32sl();



      if(mx>651 && mx<672 && my>381 && my<395){ stone_bendx(-1);}
      if(mx>676 && mx<697 && my>381 && my<395){ stone_bendx(1);}
      
      if(mx>651 && mx<672 && my>398 && my<411){ stone_bendy(-1);}
      if(mx>676 && mx<697 && my>398 && my<411){ stone_bendy(1);}
      
      if(mx>651 && mx<672 && my>412 && my<426){ stone_bendz(-1);}
      if(mx>676 && mx<697 && my>412 && my<426){ stone_bendz(1);}
    
    
      if(mx>651 && mx<672 && my>329 && my<342){ scale_x(0.9);}
      if(mx>676 && mx<697 && my>329 && my<342){ scale_x(1.1);}      
      if(mx>651 && mx<672 && my>345 && my<358){ scale_y(0.9);}
      if(mx>676 && mx<697 && my>345 && my<358){ scale_y(1.1);}      
      if(mx>651 && mx<672 && my>361 && my<374){ scale_z(0.9);}
      if(mx>676 && mx<697 && my>361 && my<374){ scale_z(1.1);}

      if(mx>614 && mx<697 && my>291 && my<305){ flatten_top();}
      if(mx>614 && mx<697 && my>307 && my<321){ flatten_bottom();}       
    
      if(mx>614 && mx<697 && my>190 && my<203){ pinch_to_top();}  
      if(mx>614 && mx<697 && my>206 && my<219){ pinch_to_middle(); } 
      if(mx>614 && mx<697 && my>222 && my<235){ pinch_to_bottom();} 
      
      if(mx>614 && mx<697 && my>238 && my<251){ extrude_to_top();} 
      if(mx>614 && mx<697 && my>254 && my<267){ extrude_to_middle();} 
      if(mx>614 && mx<697 && my>270 && my<283){ extrude_to_bottom();} 

      if(mx>668 && mx<744 && my>470 && my<483){reset_to_torus(); flipimage_256();} // reset to torus
      if(mx>667 && mx<744 && my>485 && my<497){reset_to_pyramid(); flipimage_256(); } // reset to pyramid
      if(mx>667 && mx<744 && my>500 && my<512){ reset_to_cylinder(); flipimage_256();} // reset to cylinder
      if(mx>667 && mx<744 && my>515 && my<528){ reset_to_cube(); flipimage_256();} // reset to cube
      if(mx>667 && mx<744 && my>529 && my<542){reset_to_sphere(); flipimage_256();} // reset to sphere
      if(mx>667 && mx<744 && my>455 && my<468){stone_resetplane(); flipimage_256();} // reset to plane
      if(mx>747 && mx<760 && my>455 && my<468){stone_resetplane_triangle(); flipimage_256();} // reset to plane - triangle
      if(mx>762 && mx<775 && my>455 && my<468){stone_resetplane_round(); flipimage_256();} // reset to plane - triangle
      if(mx>747 && mx<760 && my>515 && my<528){stone_reset_archplanecube(); flipimage_256();}




      if(mx>614 && mx<697 && my>8 && my<21)  {stone_random();}
      if(mx>614 && mx<697 && my>25 && my<38) {stone_random2();}    
      if(mx>614 && mx<697 && my>42 && my<55) {stone_pinch();}   
      if(mx>614 && mx<697 && my>59 && my<72) {stone_extrude();}   
      if(mx>702 && mx<785 && my>270 && my<283) {stone_smooth();}
      if(mx>788 && mx<871 && my>270 && my<283){stone_smooth_torus();}
      
      if(mx>788 && mx<871 && my>287 && my<299){stone_smooth_plane();}
      
      
      

      if(mx>614 && mx<697 && my>88 && my<101) {stone_pinch_grid();}  // grid pincher
      //check 8,16,32 pinch grids
      if(mx>648 && mx<663 && my>103 && my<114) {grid_pincher_type_w=0;}  // grid pincher type width
      if(mx>665 && mx<680 && my>103 && my<114) {grid_pincher_type_w=1;}  // grid pincher type
      if(mx>682 && mx<697 && my>103 && my<114) {grid_pincher_type_w=2;}  // grid pincher type

      if(mx>648 && mx<663 && my>116 && my<127) {grid_pincher_type_h=0;}  // grid pincher type height
      if(mx>665 && mx<680 && my>116 && my<127) {grid_pincher_type_h=1;}  // grid pincher type
      if(mx>682 && mx<697 && my>116 && my<127) {grid_pincher_type_h=2;}  // grid pincher type
      
            
      if(mx>614 && mx<697 && my>136 && my<149) {stone_extrude_grid();}  // grid extruder
      //check 8,16,32 - extrude grids
      if(mx>648 && mx<663 && my>151 && my<158) {grid_extruder_type_w=0;}  // grid pincher type width
      if(mx>665 && mx<680 && my>151 && my<158) {grid_extruder_type_w=1;}  // grid pincher type
      if(mx>682 && mx<697 && my>151 && my<158) {grid_extruder_type_w=2;}  // grid pincher type

      if(mx>648 && mx<663 && my>158 && my<175) {grid_extruder_type_h=0;}  // grid pincher type height
      if(mx>665 && mx<680 && my>158 && my<175) {grid_extruder_type_h=1;}  // grid pincher type
      if(mx>682 && mx<697 && my>158 && my<175) {grid_extruder_type_h=2;}  // grid pincher type


  }
  
  if(paintmode==2) //---------------------mouse Flower tool---------------------------------------------------
  {
         
      if(mx>872 && mx<887  && my>492 && my<505 ) {flower_stemxy();}
      if(mx>891 && mx<906  && my>492 && my<505) {flower_stemzy();}
     
      if(mx>808 && mx<956 && my>269 && my<488) {flower_stembezier();}
    
      if(mx>601 && mx<614 && my>269 && my<282) {stem_height_min();}
      if(mx>616 && mx<629 && my>269 && my<282) {stem_height_plus();}
      if(mx>601 && mx<614 && my>286 && my<299) {stem_width_min();}
      if(mx>616 && mx<629 && my>286 && my<299) {stem_width_plus();}

      //reset to flower form: things can be messed up, when we switching between flowerform, drawing tool / rgb sliders
      if(mx>586 && mx<694 && my>530 && my<543) {lockselector=0;flower_reset();rendertype=1;flipimage_256();} //put off the lock buttons of drawing as well.
      
      //texture different parts    
      if(mx>701 && mx<799 && my>269 && my<282) {flowertexture_whole();flipimage_256();}
      if(mx>701 && mx<799 && my>288 && my<301) {flowertexture_top();flipimage_256();}      
      if(mx>701 && mx<799 && my>305 && my<318) {flowertexture_leaf1();flipimage_256();}
      if(mx>701 && mx<799 && my>322 && my<335) {flowertexture_leaf2();flipimage_256();}
      if(mx>701 && mx<799 && my>339 && my<352) {flowertexture_leaf3();flipimage_256();}
      if(mx>701 && mx<799 && my>356 && my<369) {flowertexture_leaf4();flipimage_256();}
      if(mx>701 && mx<799 && my>373 && my<386) {flowertexture_root();flipimage_256();}
    
      if(mx>533 && mx<637 && my>11 && my<23) // randomize top button
      {
        flower_randtop();
      }
      if(mx>533 && mx<637 && my>44 && my<57) // randomize leaves#1 button
      {
        leaves1=1; //set to On
        flower_modleaves_1(0);
      }
      if(mx>533 && mx<637 && my>77 && my<90) // randomize leaves#2 button
      {
        leaves2=1; //set to On
        flower_modleaves_2(0);
      }
      if(mx>533 && mx<637 && my>112 && my<124) // randomize leaves#3 button
      {
        leaves3=1; //set to On
        flower_modleaves_3(0);
      }
      if(mx>533 && mx<637 && my>145 && my<157) // randomize leaves#4 button
      {
        leaves4=1; //set to On
        flower_modleaves_4(0);
      }
            
      // leaves on / off button
      if(mx>509 && mx<529 && my>44 && my<57) // leaves#1 on /off button
      {
        if(leaves1==1){leaves1=0;flower_resetleaves(16, 20,1);}else{leaves1=1;flower_modleaves_1(0);}
      }
      
      if(mx>509 && mx<529 && my>77 && my<89) // leaves#2 on /off button
      {
        if(leaves2==1){leaves2=0;flower_resetleaves(23, 27,2);}else{leaves2=1;flower_modleaves_2(0);}
      }
      if(mx>509 && mx<529 && my>111 && my<124) // leaves#3 on /off button
      {
        if(leaves3==1){leaves3=0;flower_resetleaves(30, 34,3);}else{leaves3=1; flower_modleaves_3(0);}
      }
      if(mx>509 && mx<529 && my>144 && my<157) // leaves#4 on /off button
      {
        if(leaves4==1){leaves4=0;flower_resetleaves(37, 41,4);}else{leaves4=1;flower_modleaves_4(0);}
      }

        if(mx>641 && mx<656 && my>44 && my<57){flower_resetleaves(16, 20,1);leavestype1=0;flower_modleaves_1(0);leaves1=1;} // 1: type 16
        if(mx>660 && mx<675 && my>44 && my<57){flower_resetleaves(16, 20,1);leavestype1=1;flower_modleaves_1(0);leaves1=1;} // 1: type 8
        if(mx>679 && mx<694 && my>44 && my<57){flower_resetleaves(16, 20,1);leavestype1=2;flower_modleaves_1(0);leaves1=1;} // 1: type 4
      if(leaves1==1)
      {
        if(mx>568 && mx<581 && my>59 && my<71){flowerminplus(1, 1); mousereleased=1;} // min
        if(mx>583 && mx<596 && my>59 && my<71){flowerminplus(1, -1);mousereleased=1;} // plus        
        if(mx>632 && mx<662 && my>59 && my<71){flower_copy(1);} // 
      }
        if(mx>664 && mx<694 && my>59 && my<71){flower_paste(1);} //         

        if(mx>641 && mx<656 && my>77 && my<90){flower_resetleaves(23, 27, 2);leavestype2=0;flower_modleaves_2(0);leaves2=1;} // 1: type 16
        if(mx>660 && mx<675 && my>77 && my<90){flower_resetleaves(23, 27, 2);leavestype2=1;flower_modleaves_2(0);leaves2=1;} // 1: type 8
        if(mx>679 && mx<694 && my>77 && my<90){flower_resetleaves(23, 27, 2);leavestype2=2;flower_modleaves_2(0);leaves2=1;} // 1: type 4        
      if(leaves2==1)
      {
        if(mx>568 && mx<581 && my>92 && my<104){flowerminplus(2, 1); mousereleased=1;} // min
        if(mx>583 && mx<596 && my>92 && my<104){flowerminplus(2, -1);mousereleased=1;} 
        if(mx>632 && mx<662 && my>92 && my<104){flower_copy(2);} // 
      }
        if(mx>664 && mx<694 && my>92 && my<104){flower_paste(2);} //         

        if(mx>641 && mx<656 && my>111 && my<124){flower_resetleaves(30, 34, 3);leavestype3=0;flower_modleaves_3(0);leaves3=1;} // 1: type 16
        if(mx>660 && mx<675 && my>111 && my<124){flower_resetleaves(30, 34, 3);leavestype3=1;flower_modleaves_3(0);leaves3=1;} // 1: type 8
        if(mx>679 && mx<694 && my>111 && my<124){flower_resetleaves(30, 34, 3);leavestype3=2;flower_modleaves_3(0);leaves3=1;} // 1: type 4
      if(leaves3==1)
      {
        if(mx>568 && mx<581 && my>126 && my<138){flowerminplus(3, 1); mousereleased=1;} // min
        if(mx>583 && mx<596 && my>126 && my<138){flowerminplus(3, -1);mousereleased=1;} 
        if(mx>632 && mx<662 && my>126 && my<138){flower_copy(3);} // 
        if(mx>664 && mx<694 && my>126 && my<138){flower_paste(3);} //         
      }
        if(mx>664 && mx<694 && my>126 && my<138){flower_paste(3);} //         
        
        if(mx>641 && mx<656 && my>144 && my<157){flower_resetleaves(37, 41, 4);leavestype4=0;flower_modleaves_4(0);leaves4=1;} // 1: type 16
        if(mx>660 && mx<675 && my>144 && my<157){flower_resetleaves(37, 41, 4);leavestype4=1;flower_modleaves_4(0);leaves4=1;} // 1: type 8
        if(mx>679 && mx<694 && my>144 && my<157){flower_resetleaves(37, 41, 4);leavestype4=2;flower_modleaves_4(0);leaves4=1;} // 1: type 4
      if(leaves4==1)
      {
        if(mx>568 && mx<581 && my>159 && my<171){flowerminplus(4, 1); mousereleased=1;} // min
        if(mx>583 && mx<596 && my>159 && my<171){flowerminplus(4, -1);mousereleased=1;} 
        if(mx>632 && mx<662 && my>159 && my<171){flower_copy(4);} // 
      }
        if(mx>664 && mx<694 && my>159 && my<171){flower_paste(4);} //         
      
  }
  


  if(paintmode==1) // -------------------------------mouse Drawing tool---------------------------------------
  {
     if(mx>544 && mx<558 && my>525 && my<538){if(lockselector!=1){lockselector=1;}else{lockselector=0;}}
     if(mx>561 && mx<575 && my>525 && my<538){if(lockselector!=2){lockselector=2;}else{lockselector=0;}}
     if(mx>578 && mx<592 && my>525 && my<538){if(lockselector!=3){lockselector=3;}else{lockselector=0;}}
     if(mx>595 && mx<609 && my>525 && my<538){if(lockselector!=4){lockselector=4;}else{lockselector=0;}}
       
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
    //reset sphere button?
    if(mx>438 && mx<515 && my>525 && my<538)
    {
      reset_to_sphere();   
      if(drawtype==0){selectdrawingtool();} //update the image as well
      if(drawtype==1){selectdrawingtool_height();}
    }
    //width / height buttons
    if(mx>614 && mx<691 && my>525 && my<538)
    {
      drawtype=0; //draw width
      selectdrawingtool();      
    }
    if(mx>696 && mx<773 && my>525 && my<538)
    {
      drawtype=1; //draw height
      selectdrawingtool_height();
    }    
    if(mx>879 && mx<949 && my>525 && my<539)  //smooth sculpty
    {
      stone_smooth();
      if(drawtype==0){selectdrawingtool();} //update the image as well
      if(drawtype==1){selectdrawingtool_height();}
    }    
  }//end drawing paint mode
      
  if(paintmode==0) // Edit RGB layers
  {
    //load a RGB layer image!
    if(mx>425 && mx<504 && my>366 && my<379){loadredlayer();  }
    if(mx>510 && mx<589 && my>366 && my<379){loadgreenlayer();}
    if(mx>595 && mx<674 && my>366 && my<379){loadbluelayer();}
    // red scroll-slider buttons
    if(mx>421 && mx<431 && my>227 && my<244){slide_redup();    generate_scuptxyz(); } // up
    if(mx>421 && mx<431 && my>243 && my<261){slide_reddown();  generate_scuptxyz(); } // down
    if(mx>430 && mx<448 && my>260 && my<270){slide_redleft();  generate_scuptxyz();} // left
    if(mx>447 && mx<465 && my>260 && my<270){slide_redright(); generate_scuptxyz();} // right  
    // green scroll-slider buttons
    if(mx>692 && mx<700 && my>227 && my<244){slide_greenup();   generate_scuptxyz();} // up
    if(mx>692 && mx<700 && my>243 && my<261){slide_greendown(); generate_scuptxyz();} // down
    if(mx>701 && mx<717 && my>260 && my<270){slide_greenleft(); generate_scuptxyz();} // left
    if(mx>718 && mx<734 && my>260 && my<270){slide_greenright();generate_scuptxyz();} // right  
    // blue scroll-slider buttons
    if(mx>692 && mx<700 && my>497 && my<514){slide_blueup();    generate_scuptxyz();} // up
    if(mx>691 && mx<700 && my>515 && my<531){slide_bluedown();  generate_scuptxyz();} // down
    if(mx>701 && mx<717 && my>532 && my<539){slide_blueleft();  generate_scuptxyz();} // left
    if(mx>718 && mx<734 && my>532 && my<540){slide_blueright(); generate_scuptxyz();} // right
   
   }  

}

