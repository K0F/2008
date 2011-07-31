class Viz{
  float x,y,tx,ty;
  color c;
  float speed;
  String content = "";
  int time = 0,life;
  PGraphics img;

  Viz(String a){

    //c = (color)(lerpColor(#ffcc00,#aaaaaa,random(1000)/1000.0));
    content = a+"";
    img = createGraphics(5,5,P3D);
    x=width/2.0;//random(width);
    y=height+10;//random(height);
    tx=TX;
    TX+=img.width;
    ty=TY;//map(a.length(),0,300,50,height-50);
    if(TX+img.width>width){

      TX=0;
      TY+=img.height;
    }
    if(TY+img.height>height){
      save("print/"+nf(cnnt,6)+".png");
      cnnt++;
      TY = 0;
    }
    //println(img.width*img.height);
    int vizza[] = new int[content.length()];
    if(vizza.length>img.pixels.length){
      for(int i =0;i<img.pixels.length;i++)
        vizza[i] = color((int)map(content.charAt(i),0,65600,0,255));
    }
    else{
      for(int i =0;i<vizza.length;i++)
        vizza[i] = color((int)map(content.charAt(i),0,65600,0,255));
    }
    img.pixels = vizza;
    life = (int)(content.length());
    speed = life/100.0;

  }

  void compute(){
    time++;
    x+=(tx-x)*speed;
    y+=(ty-y)*speed;


  }

  void draw(){
    //if(time<life){
    compute();
    //fill(c,map(time,0,life,255,0));
    //	rect(x,y-10,4,4);
    if(showPackets)
      //text(content,x,y);
      image(img,x,y);
    //noFill();
    //stroke(c,map(time,0,life,255,0));		
    //ellipse(x,y-10,life,life);

    //}

  }


}

