

class Basnik{  
  com.sun.speech.freetts.Voice voice;
  FreeTTS hlas;
 
  PApplet parent;
  
  Basnik(PApplet _parent){
    parent = _parent;
   // a = new 
   // voice = new CMUDiphoneVoice();  
  //voice.setLexicon(new CMULexicon());  
    //voice.setAudioPlayer(new JavaClipAudioPlayer());
   //voice.allocate();
    //voice.speak("I can talk forever without getting tired!");
    
   hlas = new FreeTTS();
  // hlas.startup();
  }  
  
  void mluv(String s){
    hlas.textToSpeech(s);
    
  }
  
}
