// general_loading_saving

void loadnew64sculptimage()
{
  loadnewimage();
}

void loadnewtexture()
{
  loadnewtexturechooser();
  gridflat.copy(loadtexture, 0, 0, loadtexture.width, loadtexture.height, 0, 0, 256, 256);
  gridflat.updatePixels();
  
  
  flipimage_256();
  
  textureimg.copy(gridinvert, 0, 0, 256, 256, 0, 0, 256, 256);
  textureimg.updatePixels();
  
  rendermodez=3; //texture mode      
}
void savesculpt64png()
{

    String modes="tool_";

     if(paintmode==0){modes="sculpt_rgb64_";}
     if(paintmode==1){modes="sculpt_draw64_";}
     if(paintmode==2){modes="sculpt_flower64_";}
     if(paintmode==3){modes="sculpt_stone64_";}
     if(paintmode==4){modes="sculpt_stairs64_";}
     if(paintmode==5){modes="sculpt_arch64_";}
     if(paintmode==6){modes="sculpt_point64_";}
     if(paintmode==7){modes="sculpt_tex-tool64_";}
     if(paintmode==8){modes="sculpt_morph64_";}
     if(paintmode==9){modes="sculpt_testtool64_";}
  
    String mymonth="";
    switch(month()) 
    {
      case 1: mymonth="Jan"; break;
      case 2: mymonth="Feb"; break;
      case 3: mymonth="Mar"; break;
      case 4: mymonth="Apr"; break;
      case 5: mymonth="May"; break;
      case 6: mymonth="Jun"; break;
      case 7: mymonth="Jul"; break;
      case 8: mymonth="Aug"; break;
      case 9: mymonth="Sep"; break;
      case 10: mymonth="Oct"; break;
      case 11: mymonth="Nov"; break;
      case 12: mymonth="Dec"; break;
    }
    
    int myhour=hour();
    String myhourname="";
    if(myhour<13){myhourname="am";}else{myhourname="pm";}
    

  
     //save the current sculptie image 64*64     
      if(savecounter<10){savenum="00";}
      if(savecounter>9 && savecounter<100){savenum="0";}
      if(savecounter>99 && savecounter<1000){savenum="";}

      savename = "sculpt_"+ str(year())+mymonth+str(day())+"_"+str(hour())+myhourname+str(minute())+"-"+str(second()) +"_n"+savenum+str(savecounter)+".png";         
      
      //savename = modes+savenum+str(savecounter)+".png";
      savefade=1;
      b.save(savename);
      if(paintmode==2)
      {
        savename = "sculpt_flower_texture_"+savenum+str(savecounter)+".tga";
        gridflat.save(savename);
      }
      savecounter++;
}
void savesculpt256tga()//now 128png
{
     String modes="tool_";

     if(paintmode==0){modes="sculpt_rgb128_";}
     if(paintmode==1){modes="sculpt_draw128_";}
     if(paintmode==2){modes="sculpt_flower128_";}
     if(paintmode==3){modes="sculpt_stone128_";}
     if(paintmode==4){modes="sculpt_stairs128_";}
     if(paintmode==5){modes="sculpt_arch128_";}
     if(paintmode==6){modes="sculpt_point128_";}
     if(paintmode==7){modes="sculpt_texture128_";}
     if(paintmode==8){modes="sculpt_morph128_";}
     if(paintmode==9){modes="sculpt_testtool128_";}
     
    String mymonth="";
    switch(month()) 
    {
      case 1: mymonth="Jan"; break;
      case 2: mymonth="Feb"; break;
      case 3: mymonth="Mar"; break;
      case 4: mymonth="Apr"; break;
      case 5: mymonth="May"; break;
      case 6: mymonth="Jun"; break;
      case 7: mymonth="Jul"; break;
      case 8: mymonth="Aug"; break;
      case 9: mymonth="Sep"; break;
      case 10: mymonth="Oct"; break;
      case 11: mymonth="Nov"; break;
      case 12: mymonth="Dec"; break;
    }
    
    int myhour=hour();
    String myhourname="";
    if(myhour<13){myhourname="am";}else{myhourname="pm";}
    
// 0=rgb layer | 1=drawing tool | 2=flower tool | 3=rock generator | 4=stairs 
//| 5=arch | 6=point | 7=texture | 8=morph | 9=test
                  
      if(savecounter<10){savenum="00";}
      if(savecounter>9 && savecounter<100){savenum="0";}
      if(savecounter>99 && savecounter<1000){savenum="";}    
//      savename = modes+savenum+str(savecounter)+".tga";
      savename = "sculpt_"+ str(year())+mymonth+str(day())+"_"+str(hour())+myhourname+str(minute())+"-"+str(second()) +"_n"+savenum+str(savecounter)+".png";         

      
      savefade=1;
      buff128.loadPixels();
      buff128.copy(b, 0, 0, 64, 64, 0, 0, 128, 128);
      buff128.save(savename);
      if(paintmode==2)
      {
        savename = "sculpt_flower_texture_"+savenum+str(savecounter)+".png";
        gridflat.save(savename);
      }
      savecounter++;
      
}

void savetexturetga()//in texture tool
{
     String modes="";

     if(texturesize==0){modes="texturesketch_256_";}
     if(texturesize==1){modes="texturesketch_512_";}
     //if(texturesize==2){modes="texturesketch_1024_";}
     
     
      if(savecounter<10){savenum="00";}
      if(savecounter>9 && savecounter<100){savenum="0";}
      if(savecounter>99 && savecounter<1000){savenum="";}    
      savename = modes+savenum+str(savecounter)+".tga";
      savefade=1;
      
      if(texturesize==0){textureimg.save(savename);}
      if(texturesize==1){textureimg512.save(savename);}
      //if(texturesize==2){textureimg1024.save(savename);}

      savecounter++;
      
}

void loadsave_saveobj()// save as .obj file
{

  //int rendertype=1; //1 sphere - 2 torus - 3 plain - 4 cylinder

  //for the .obj saver
  String words = "# .obj saver v.02 \n# Elout de Kok / sl: Cel Edman 2008/no mysculpt";  

  int s_wh=64;
  

  for (int j=0;j<s_wh;j=j+2)
  {
    for (int i=0;i<s_wh;i=i+2)
    {
      String rx= str(spx[(j*s_wh)+i]);
      String gy= str(spy[(j*s_wh)+i]);
      String bz= str(spz[(j*s_wh)+i]);
      words+="\nv "+ rx+" "+gy+" "+bz;
      
      if(rendertype==3 && i==62)//planetype? add points right 63 position on y
      {
          rx= str(spx[(j*s_wh)+63]);
          gy= str(spy[(j*s_wh)+63]);
          bz= str(spz[(j*s_wh)+63]);
          words+="\nv "+ rx+" "+gy+" "+bz;
      }
    }
  }  
  
  if(rendertype!=2) //not torus? then add bottom-row part
  {
    //now do the last bottomrow 33
    for (int j=s_wh-1;j<s_wh;j++)
    {
      for (int i=0;i<s_wh;i=i+2)
      {
        String rx= str(spx[(j*s_wh)+i]);
        String gy= str(spy[(j*s_wh)+i]);
        String bz= str(spz[(j*s_wh)+i]);
        words+="\nv "+ rx+" "+gy+" "+bz;
        if(rendertype==3 && i==62)//planetype? add points right 63 position on y
        {
          //println("stitch!"); 1 more!
          rx= str(spx[(j*s_wh)+63]);
          gy= str(spy[(j*s_wh)+63]);
          bz= str(spz[(j*s_wh)+63]);
          words+="\nv "+ rx+" "+gy+" "+bz;
        }
      
      } 
    }
  }
  //32*33 = 1056 points now
  //33*33 = 1089 plane stuff

  
  //words+="\n#Normals in (x,y,z) form; normals might not be unit.  = vn";
  //words+="\n#vn -0.57735027 -0.57735027 0.57735027";


  //---------------Texture Coordinates---------------------
  
  words+="\n#Texture coordinates";
  
  if (rendertype==3)// plane sculpty
  {
    int texw=33; //32
    int texh=33; //32
    for (int j=0;j<texh;j++)
    {
      for (int i=0;i<texw;i++)
      {
        float texx=(float)i/((float)texw-1);
        float texy=(float)j/((float)texh-1);
        words+="\nvt "+ texx +" " + texy + " 0.000";        
      }
    }
    //1089 tex coordinates for plane
  }
  if (rendertype==1 || rendertype==3)// texture coordinates for sphere /r cylinder 
  {
    int texw=32; //32
    int texh=33; //32    
    for (int j=0;j<texh;j++)
    {
      for (int i=0;i<texw;i++)
      {
        float texx=(float)i/((float)texw);
        float texy=(float)j/((float)texh-1);
        words+="\nvt "+ texx +" " + texy + " 0.000";
      }
    }
    //last stitch row
    float maxxi=0;
    for (int j=0;j<texh;j++)
    {
      for (int i=texw-1;i<texw;i++)
      {
        //float texx=(float)i/((float)texw);
        float texy=(float)j/((float)texh-1);
        words+="\nvt "+ "1.0" +" " + texy + " 0.000";
        maxxi=texy;
      }
    }
    println(maxxi);
    //println(counterr +" "+maxxi);
    //1056 tex coordinates for sphere/cylinder
  }
  
  if (rendertype==2)// texture coordinates for torus 
  {
    int texw=32; //32
    int texh=32; //32    
    for (int j=0;j<texh;j++)
    {
      for (int i=0;i<texw;i++)
      {
        float texx=(float)i/((float)texw);
        float texy=(float)j/((float)texh);
        words+="\nvt "+ texx +" " + texy + " 0.000";
      }
    }
    //last stitch row right to left
    for (int j=0;j<texh;j++)
    {
      for (int i=texw-1;i<texw;i++)
      {
        float texy=(float)j/((float)texh);
        words+="\nvt "+ "1.0" +" " + texy + " 0.000";
      }
    }
    //bottom to top stitch
    for (int j=texh-1;j<texh;j++)
    {
      for (int i=0;i<texw+1;i++)
      {
        float texx=(float)i/((float)texh);
        words+="\nvt "+ texx +" " + "1.0" + " 0.000";
      }
    }
  }



  //-------------Triangle data---------------------
  words+="\n#\n# Triangle data";

  if (rendertype==1 || rendertype==4) // do for sphere/cylinder
  {
    for (int j=0;j<s_wh;j=j+2) //33 rows // 32 for torus
    {
      for (int i=0;i<s_wh-2;i=i+2)
      {
        //XYZ points
        String p1=str(((j/2)*(s_wh/2))+(i/2)+1);
        String p2=str(((j/2)*(s_wh/2))+(i/2)+1+1);
        String p3=str((((j/2)+1)*(s_wh/2))+(i/2)+1);
        String p4=str((((j/2)+1)*(s_wh/2))+(i/2)+1+1);
        //Texture
        String t1=p1;//str((j*sculptimg.width)+i+1);
        String t2=p2;//str((j*sculptimg.width)+1);
        String t3=p3;//str(((j+1)*sculptimg.width)+i+1);
        String t4=p4;//str(((j+1)*sculptimg.width)+1);
        words+="\nf "+p1+"/"+t1+"/ " +p3+"/"+t3+"/ " +p4+"/"+t4+"/ "+p2+"/"+t2+"/ "; //quad
      }
    }
    // type=sphere/cylinder - stitch right to left
    for (int j=0;j<s_wh;j=j+2)
    {
      for (int i=s_wh-2;i<s_wh;i=i+2)
      {
        //XYZ points
        String p1=str(((j/2)*(s_wh/2))+(i/2)+1);
        String p2=str(((j/2)*(s_wh/2))+1);
        String p3=str((((j/2)+1)*(s_wh/2))+(i/2)+1);
        String p4=str((((j/2)+1)*(s_wh/2))+1);
        String t1=p1;//str((j*sculptimg.width)+i+1);        
        String t2=str((32*33)+(j/2)+1); //texture end for these
        String t3=p3;//str((j*sculptimg.width)+i+1);
        String t4=str((32*33)+(j/2)+1+1); //texture end for these        
        words+="\nf "+p1+"/"+t1+"/ " +p3+"/"+t3+"/ " +p4+"/"+t4+"/ "+p2+"/"+t2+"/ "; //quad        
      }
    }  
  }
  //1024faces for sphere/cylinder type
  if (rendertype==2)// torus
  {
    for (int j=0;j<s_wh-2;j=j+2) //32 rows for torus
    {
      for (int i=0;i<s_wh-2;i=i+2)
      {
        //XYZ points
        String p1=str(((j/2)*(s_wh/2))+(i/2)+1);
        String p2=str(((j/2)*(s_wh/2))+(i/2)+1+1);
        String p3=str((((j/2)+1)*(s_wh/2))+(i/2)+1);
        String p4=str((((j/2)+1)*(s_wh/2))+(i/2)+1+1);
        //Texture
        String t1=p1;//str((j*sculptimg.width)+i+1);
        String t2=p2;//str((j*sculptimg.width)+1);
        String t3=p3;//str(((j+1)*sculptimg.width)+i+1);
        String t4=p4;//str(((j+1)*sculptimg.width)+1);
        words+="\nf "+p1+"/"+t1+"/ " +p3+"/"+t3+"/ " +p4+"/"+t4+"/ "+p2+"/"+t2+"/ "; //quad
      }
    }
    
    // type=torus - stitch right to left
    for (int j=0;j<s_wh-2;j=j+2)
    {
      for (int i=s_wh-2;i<s_wh;i=i+2)
      {
        //XYZ points
        String p1=str(((j/2)*(s_wh/2))+(i/2)+1);
        String p2=str(((j/2)*(s_wh/2))+1);
        String p3=str((((j/2)+1)*(s_wh/2))+(i/2)+1);
        String p4=str((((j/2)+1)*(s_wh/2))+1);
        String t1=p1;
        String t2=str((32*32)+(j/2)+1); //texture end for these
        String t3=p3;
        String t4=str((32*32)+(j/2)+1+1); //texture end for these
        words+="\nf "+p1+"/"+t1+"/ " +p3+"/"+t3+"/ " +p4+"/"+t4+"/ "+p2+"/"+t2+"/ "; //quad        
        //words+="\nf "+p1+"/"+"/ " +p3+"/"+"/ " +p4+"/"+"/ "+p2+"/"+"/ "; //quad        
      }
    }
    
    // torus  stitch top to bottom
    for (int j=s_wh-2;j<s_wh-1;j++)
    {
      for (int i=0;i<s_wh-2;i=i+2)
      {
        //XYZ points
        String p1=str(((j/2)*(s_wh/2))+(i/2)+1);
        String p2=str(((j/2)*(s_wh/2))+(i/2)+1+1);
        String p3=str(( 0 )+(i/2)+1);
        String p4=str(( 0 )+(i/2)+1+1);
        String t1=p1;
        String t2=p2; //texture end for these
        String t3=str( (33*32)+(i/2)+1 );//texture end for these
        String t4=str( (33*32)+(i/2)+1+1 ); //texture end for these        
        words+="\nf "+p1+"/"+t1+"/ " +p3+"/"+t3+"/ " +p4+"/"+t4+"/ "+p2+"/"+t2+"/ "; //quad
      }
    }    
    //torus stitch/close the last left to right vert
    String p1=str((((s_wh-2)/2)*(s_wh/2))+(31)+1);
    String p2=str((((s_wh-2)/2)*(s_wh/2)) +1);
    String p3=str(( 0 )+(31)+1);
    String p4=str(( 0 ) +1);        
    String t1=p1;
    String t2=str((((s_wh-2)/2)*(s_wh/2))+(31)+33);
    String t3=str( (33*32)+(31)+1 );//texture end for these
    String t4=str( (33*32)+(31)+1+1 ); //texture end for these
    words+="\nf "+p1+"/"+t1+"/ " +p3+"/"+t3+"/ " +p4+"/"+t4+"/ "+p2+"/"+t2+"/ "; //quad
  }
  
  //do the plane thing!
  if (rendertype==3) // do for plane //33*33 
  {
    int countrr=0;
    for (int j=0;j<32;j++) 
    {
      for (int i=0;i<32;i++)
      {
        //XYZ points
        String p1=str((j*33)+ (i)+1);
        String p2=str((j*33)+ (i)+1+1);
        String p3=str(((j+1)*33)+ (i)+1);
        String p4=str(((j+1)*33)+ (i)+1+1);
        //Texture
        String t1=p1;
        String t2=p2;
        String t3=p3;
        String t4=p4;
        words+="\nf "+p1+"/"+t1+"/ " +p3+"/"+t3+"/ " +p4+"/"+t4+"/ "+p2+"/"+t2+"/ "; //quad        
      }
    }
  }  
  

  //split and save it now!

  //split and save it now!
  String mlist[] = split(words,"\n");  

 // println("saving obj-file");
  
  
  String mymonth="";
    switch(month()) 
    {
      case 1: mymonth="Jan"; break;
      case 2: mymonth="Feb"; break;
      case 3: mymonth="Mar"; break;
      case 4: mymonth="Apr"; break;
      case 5: mymonth="May"; break;
      case 6: mymonth="Jun"; break;
      case 7: mymonth="Jul"; break;
      case 8: mymonth="Aug"; break;
      case 9: mymonth="Sep"; break;
      case 10: mymonth="Oct"; break;
      case 11: mymonth="Nov"; break;
      case 12: mymonth="Dec"; break;
    }
    
    int myhour=hour();
    String myhourname="";
    if(myhour<13){myhourname="am";}else{myhourname="pm";}
    
// 0=rgb layer | 1=drawing tool | 2=flower tool | 3=rock generator | 4=stairs 
//| 5=arch | 6=point | 7=texture | 8=morph | 9=test
                  
      if(savecounter<10){savenum="00";}
      if(savecounter>9 && savecounter<100){savenum="0";}
      if(savecounter>99 && savecounter<1000){savenum="";}    
//      savename = modes+savenum+str(savecounter)+".tga";
      savename = "obj3D_"+ str(year())+mymonth+str(day())+"_"+str(hour())+myhourname+str(minute())+"-"+str(second()) +"_n"+savenum+str(savecounter)+".obj";         

  saveStrings(savename, mlist);
  //println("saved obj-file");
  

  savefade=1;  
  savecounter++;


}



// load a new sculpty image from HD
void loadnewimage() 
{
  // filechooser from http://www.processinghacks.com/hacks/filechooser
  try { 
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
  } 
  catch (Exception e) { 
    e.printStackTrace();  
  } 
  // create a file chooser 
  final JFileChooser fc = new JFileChooser(); 
  int returnVal = fc.showOpenDialog(this); 
  
  if (returnVal == JFileChooser.APPROVE_OPTION) 
  { 
    File file = fc.getSelectedFile(); 
    // load the image using the given file path
    tempload = loadImage(file.getPath()); 
    //println(file.getName.endsWith("tga"));
    
        
    if (tempload != null) //load succesfull
    { 
        tempload.loadPixels();
        b.loadPixels();
        

        b.copy(tempload, 0, 0, tempload.width, tempload.height, 0, 0, 64, 64);
        
        b.updatePixels();

        if (file.getName().endsWith("tga")){flipimage_h64();}
        if (file.getName().endsWith("Tga")){flipimage_h64();}
        if (file.getName().endsWith("TGA")){flipimage_h64();}

        //reads color and set the new 3D data
        getimagedata();
        rendermodez=0;
        //sets the big red green and blue layer
        layersredgreenblue();
        selectdrawingtool();
        generate_scuptxyz();
    }
  }
}

// load a new texture image from HD
void loadnewtexturechooser() 
{
  // filechooser from http://www.processinghacks.com/hacks/filechooser
  try 
  { 
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
  } 
  catch (Exception e) 
  { 
    e.printStackTrace();  
  } 
  // create a file chooser 
  final JFileChooser fc = new JFileChooser(); 
  int returnVal = fc.showOpenDialog(this); 
//  int returnVal = fc.showSaveDialog(this); 
  
 // println(returnVal);
  
  if (returnVal == JFileChooser.APPROVE_OPTION) 
  { 
    File file = fc.getSelectedFile(); 
    // load the image using the given file path
    loadtexture = loadImage(file.getPath()); 
    if (loadtexture != null) //load succesfull
    { 
      
    }
    
  }
  else
  {
      //cancel
  }
  
}


// load a new sculpty red layer from HD
void loadredlayer() 
{
  // filechooser from http://www.processinghacks.com/hacks/filechooser
  try { 
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
  } 
  catch (Exception e) { 
    e.printStackTrace();  
  } 
  // create a file chooser 
  final JFileChooser fc = new JFileChooser(); 
  int returnVal = fc.showOpenDialog(this); 
  
  if (returnVal == JFileChooser.APPROVE_OPTION) 
  { 
    File file = fc.getSelectedFile(); 
    // load the image using the given file path
    tempload = loadImage(file.getPath()); 
    if (tempload != null) //load succesfull
    { 
        smallr.copy(tempload, 0, 0, tempload.width, tempload.height, 0, 0, 64, 64);
        smallr.updatePixels();
        //now strip g/b data
        smallr.loadPixels();
        for (int i=0;i<64*64;i++)
        {
          int r= ((smallr.pixels[i] >> 16) & 0xff);
          smallr.pixels[i] =  ( (0xff<<24) | (r<<16) | (0<<8) | 0);
        }
        smallr.updatePixels();
        update_bigred();     // update the big one
        redrawsculptmap();   // redraw sculptmap
        getimagedata();      // redraw the 3D object
        generate_scuptxyz();
    }
  }
}

// load a new sculpty red layer from HD
void loadgreenlayer() 
{
  // filechooser from http://www.processinghacks.com/hacks/filechooser
  try { 
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
  } 
  catch (Exception e) { 
    e.printStackTrace();  
  } 
  // create a file chooser 
  final JFileChooser fc = new JFileChooser(); 
  int returnVal = fc.showOpenDialog(this); 
  
  if (returnVal == JFileChooser.APPROVE_OPTION) 
  { 
    File file = fc.getSelectedFile(); 
    // load the image using the given file path
    tempload = loadImage(file.getPath()); 
    if (tempload != null) //load succesfull
    { 
        smallg.copy(tempload, 0, 0, tempload.width, tempload.height, 0, 0, 64, 64);
        smallg.updatePixels();


        //now strip g/b data
        smallg.loadPixels();
        for (int i=0;i<64*64;i++)
        {
          int g= ((smallg.pixels[i] >> 8) & 0xff);
          smallg.pixels[i] =  ( (0xff<<24) | (0<<16) | (g<<8) | 0);
        }
        smallg.updatePixels();
        update_biggreen();     // update the big one
        redrawsculptmap();   // redraw sculptmap
        getimagedata();      // redraw the 3D object
        generate_scuptxyz();
    }
  }
}

// load a new sculpty red layer from HD
void loadbluelayer() 
{
  // filechooser from http://www.processinghacks.com/hacks/filechooser
  try { 
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
  } 
  catch (Exception e) { 
    e.printStackTrace();  
  } 
  // create a file chooser 
  final JFileChooser fc = new JFileChooser(); 
  int returnVal = fc.showOpenDialog(this); 
  
  if (returnVal == JFileChooser.APPROVE_OPTION) 
  { 
    File file = fc.getSelectedFile(); 
    // load the image using the given file path
    tempload = loadImage(file.getPath()); 
    if (tempload != null) //load succesfull
    { 
        //loadnewtexturechooser();
      smallb.copy(tempload, 0, 0, tempload.width, tempload.height, 0, 0, 64, 64);
      smallb.updatePixels();
        
        //now strip g/b data
        smallb.loadPixels();
        for (int i=0;i<64*64;i++)
        {
          int b= ((smallb.pixels[i]  ) & 0xff);
          smallb.pixels[i] =  ( (0xff<<24) | (0<<16) | (0<<8) | b);
        }
        smallb.updatePixels();
        update_bigblue();     // update the big one
        redrawsculptmap();   // redraw sculptmap
        getimagedata();      // redraw the 3D object
        generate_scuptxyz();
    }
  }
}

