import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import rita.wordnet.*;

RiWordnet wordnet;
PFont font1, font2;
String word, hypos[];
String[] flak = new String[20];
int radek =  0;

Basnik bard;


void setup() 
{
  size(200, 400);    
  font1 = loadFont("00Acrobatix-8.vlw");
  font2 = loadFont("00Acrobatix-8.vlw");  
  wordnet = new RiWordnet(this);
   bard = new Basnik(this);
}

void draw() 
{  
  background(40);

  // get synonyms every 100 frames 
  if (frameCount%500 == 1)  
  {   
    flak[radek] = "to ";
    flak[radek] += wordnet.getRandomWord("v");
    flak[radek] += " ";
    flak[radek] += wordnet.getRandomWord("a");
    flak[radek] += " ";
    flak[radek] += wordnet.getRandomWord("n");
   
    radek++;  
    radek = radek%flak.length;
    bard.mluv(flak[radek]);
  }

  int yPos=60;   // draw the synonyms
  textFont(font1);
  for (int i = 0; i < radek; i++)
    text(flak[i], 30, yPos += 13);  
}



