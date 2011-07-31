color c[];

void setup(){
  size(200,200,P3D);
  background(0);
  c = new color[width*height];
  rerand();
}

void rerand(){
  for(int i = 0 ;i<c.length;i++)
    c[i] = color(random(0,255));
  
  
}

void draw(){
  rerand();
  loadPixels();
  for(int x = 0;x<width;x++){
    for(int y = 0;y < height;y++){
      pixels[y*height+x] = color(c[y*height+x]);
    }
  }
  updatePixels();
  
}
