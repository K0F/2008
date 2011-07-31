//import processing.opengl.*;

// fluid3 by Glen Murphy.
// View the applet in use at http://bodytag.org/
// Code has not been optimised, and will run fairly slowly.

// Adjust the 'RES' variable below to change speed - higher is faster.
// Don't forget to change the size command in setup if changing the
// height/width.

int WIDTH = 200;
int HEIGHT = 200;

int RES = 2;
int PENSIZE = 30;

int lwidth = WIDTH/RES;
int lheight = HEIGHT/RES;
int PNUM = 30000;
vsquare[][] v = new vsquare[lwidth+1][lheight+1];
vbuffer[][] vbuf = new vbuffer[lwidth+1][lheight+1];

particle[] p = new particle[PNUM];
int pcount = 0;
int mouseXvel = 0;
int mouseYvel = 0;



public void setup() {
  size(200,200);
  background(40);
  noStroke();
  for(int i = 0; i < PNUM; i++) {
    p[i] = new particle(random(RES,WIDTH-RES),random(RES,HEIGHT-RES));
    }
  for(int i = 0; i <= lwidth; i++) {
    for(int u = 0; u <= lheight; u++) {
      v[i][u] = new vsquare(i*RES,u*RES);
      vbuf[i][u] = new vbuffer(i*RES,u*RES);
    }
  }
}

void draw() {
  int axvel = mouseX-pmouseX;
  int ayvel = mouseY-pmouseY;

  mouseXvel = (axvel != mouseXvel) ? axvel : 0;
  mouseYvel = (ayvel != mouseYvel) ? ayvel : 0;

  for(int i = 0; i < lwidth; i++) {
    for(int u = 0; u < lheight; u++) {
      vbuf[i][u].updatebuf(i,u);
      v[i][u].col = 32;
    }
  }
  for(int i = 0; i < PNUM-1; i++) {
    p[i].updatepos();
    }
  for(int i = 0; i < lwidth; i++) {
    for(int u = 0; u < lheight; u++) {
      v[i][u].addbuffer(i, u);
      v[i][u].updatevels(mouseXvel, mouseYvel);
      v[i][u].display(i, u);
    }
  }
  }
