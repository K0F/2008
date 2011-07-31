import rita.wordnet.*;

RiWordnet wordnet;
PFont font1, font2;
String word, hypos[];

void setup() 
{
  size(300, 300);    
  font1 = loadFont("00Acrobatix-8.vlw");
  font2 = loadFont("00Acrobatix-8.vlw");  
  wordnet = new RiWordnet(this);
}

void draw() 
{  
  background(40);
  
  // get synonyms every 100 frames 
  if (frameCount%100 == 1)  
  { 
    String[] tmp = null;
    while (tmp == null) {
      word = wordnet.getRandomWord("a");
      tmp = wordnet.getAllSynonyms(word, "a", 15);
    }    
    Arrays.sort(tmp);
    hypos = tmp;    
  }

  textFont(font2);  // draw query word
  text(word, width-textWidth(word)-30, 40);

  int yPos=60;   // draw the synonyms
  textFont(font1);
  for (int i = 0; i < hypos.length; i++)
    text(hypos[i], 30, yPos += 13);  
}

