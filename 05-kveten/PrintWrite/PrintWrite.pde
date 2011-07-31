PrintWriter output;

boolean writing = false;

void setup() {
  // Create a new file in the sketch directory
  size(800,600);
  frameRate(30);
  output = createWriter("trackP5.txt"); 
  output.println("P5 track1");
  output.println("Frame             X             Y   Correlation");
}

void draw() {
  if(writing){
   write(); 
  }
  
}

void write(){
 point(mouseX, mouseY);
  output.println("   "+((int)frameCount)+".00        "+(float)mouseX+"        "+(float)(height-mouseY)+"         "+0.80); // Write the coordinate to the file 
  
}

void keyPressed() {
  if(keyCode==ENTER){
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
  }else if(key==' '){
    writing=!writing;
  }
}
