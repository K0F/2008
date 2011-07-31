class particle {
  float x;
  float y;
  float xvel;
  float yvel;
  int pos;
  particle(float xIn, float yIn) {
    x = xIn;
    y = yIn;
  }

  void updatepos() {
    float col1;
    if(x > 0 && x < WIDTH && y > 0 && y < HEIGHT) {
      //stroke(#cccccc);
      //line(x,y,x+xvel,y+yvel);
      int vi = (int)(x/RES);
      int vu = (int)(y/RES);
      vsquare o = v[vi][vu];
      //xvel += o.xvel*0.05;
      //yvel += o.yvel*0.05;

      float ax = (x%RES)/RES;
      float ay = (y%RES)/RES;

      xvel += (1-ax)*v[vi][vu].xvel*0.05;
      yvel += (1-ay)*v[vi][vu].yvel*0.05;

      xvel += ax*v[vi+1][vu].xvel*0.05;
      yvel += ax*v[vi+1][vu].yvel*0.05;

      xvel += ay*v[vi][vu+1].xvel*0.05;
      yvel += ay*v[vi][vu+1].yvel*0.05;

      o.col += 4;

      x += xvel;
      y += yvel;
    }
    else {
      x = random(0,WIDTH);
      y = random(0,HEIGHT);
      xvel = 0;
      yvel = 0;
    }

    xvel *= 0.5;
    yvel *= 0.5;
  }
}

class vbuffer {
  int x;
  int y;
  float xvel;
  float yvel;
  float pressurex = 0;
  float pressurey = 0;
  float pressure = 0;

  vbuffer(int xIn,int yIn) {
    x = xIn;
    y = yIn;
    pressurex = 0;
    pressurey = 0;
    }

  void updatebuf(int i, int u) {
    if(i>0 && i<lwidth && u>0 && u<lheight) {
      pressurex = (v[i-1][u-1].xvel*0.5 + v[i-1][u].xvel + v[i-1][u+1].xvel*0.5 - v[i+1][u-1].xvel*0.5 - v[i+1][u].xvel - v[i+1][u+1].xvel*0.5);
      pressurey = (v[i-1][u-1].yvel*0.5 + v[i][u-1].yvel + v[i+1][u-1].yvel*0.5 - v[i-1][u+1].yvel*0.5 - v[i][u+1].yvel - v[i+1][u+1].yvel*0.5);
      pressure = (pressurex + pressurey)*0.25;
      }
    }
  }

class vsquare {
  int x;
  int y;
  float xvel;
  float yvel;
  float col;

  vsquare(int xIn,int yIn) {
    x = xIn;
    y = yIn;
    }

  void addbuffer(int i, int u) {
    if(i>0 && i<lwidth && u>0 && u<lheight) {
      xvel += (vbuf[i-1][u-1].pressure*0.5
              +vbuf[i-1][u].pressure
              +vbuf[i-1][u+1].pressure*0.5
              -vbuf[i+1][u-1].pressure*0.5
              -vbuf[i+1][u].pressure
              -vbuf[i+1][u+1].pressure*0.5
              )*0.25;
      yvel += (vbuf[i-1][u-1].pressure*0.5
              +vbuf[i][u-1].pressure
              +vbuf[i+1][u-1].pressure*0.5
              -vbuf[i-1][u+1].pressure*0.5
              -vbuf[i][u+1].pressure
              -vbuf[i+1][u+1].pressure*0.5
              )*0.25;
      }      
    }

  void updatevels(int mvelX, int mvelY) {
    if(mousePressed) {
      float adj = x - mouseX;
      float opp = y - mouseY;
      float dist = sqrt(opp*opp + adj*adj);
      if(dist < PENSIZE) {
        if(dist < 4) dist = PENSIZE;
        float mod = PENSIZE/dist;
        xvel += mvelX*mod;
        yvel += mvelY*mod;
        }
      }

    xvel *= 0.99;//-(0.0005*random(10));
    yvel *= 0.99;//-(0.0005*random(10));
  }

  void display(int i, int u) {
    float tcol = 0;
    if(col > 255) col = 255;
    if(col < 0) col = 0;
    if(i>0 && i<lwidth-1 && u>0 && u<lheight-1) {
      tcol = (+ v[i][u+1].col
              + v[i+1][u].col
              + v[i+1][u+1].col*0.5
              )*0.4;
      tcol = (int)(tcol+col*0.5);
      }
    else {
      tcol = (int)col;
      }
    fill(tcol);
    rect(x,y,RES,RES);
    //col = 32;
    }
}
