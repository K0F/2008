 import flux.vertext.*;
 import processing.opengl.*; 
 
 Vertext bigFont; 
 Vertext giantFont; 
 
 PFont regularFont; 
 
 void setup(){ 
   size(1000,400, OPENGL); 
   P5Extend.register(this); 
 
   giantFont = new Vertext("TimesNewRoman", 800, 210);  
   bigFont = new Vertext("EurostileBold", 255, 80); 
 
   regularFont = createFont("Georgia-Bold", 24); 
 } 
 
 void draw(){ 
   background(240); 
 
   giantFont.text("Q", -200, 300); 
   bigFont.text("VERTEXT", -10, 200); 
 
   fill(120); 
   noStroke(); 
   textFont(regularFont, 24); 
   text("not just plain 'ol pfonts", 40, 300); 
 } 
