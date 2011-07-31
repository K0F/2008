import processing.serial.*;

Serial port;

char[] id = {'f','h','d','b','g','a','e','c'};
int[] state = {1,1,1,1,1,1,1,1};

float xs[] = {10,20,30,40,10,20,30,40};
float ys[] = {20,20,20,20,40,40,40,40};

void setup(){
  size(200,100);
  println(Serial.list());
  frameRate(5);
  background(0);
  textFont(createFont("Arial",9));
  //textMode(SCREEN);
  // I know that the first port in the serial list on my mac
  // is always my  Keyspan adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  port = new Serial(this, Serial.list()[1], 115200);
  // Send a capital A to start the m 
  for(int i = 0;i<state.length;i++){
    send(i,state[i]); 
  }
}


void draw(){
  background(0);
  int which = (int)map(frameCount%8,0,8,0,state.length);  
  
  for(int i = 0;i<state.length;i++){
    if(i==which){
    state[i] = 0;   
    }else{
     state[i]=1;     
    } 
     send(i,state[i]);    
    fill(lerpColor(#ff0000,#220000,state[i]));
    rect(xs[i],ys[i],8,8);
  }
}

void send(int _id,int _q){
  port.write(id[_id]+""+_q); 
}

void stop(){
 for(int i = 0;i<state.length;i++){
    send(i,1); 
  } 
  super.stop();
}
