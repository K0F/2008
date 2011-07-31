class Saber {
  private AudioChannel start;
  private AudioChannel on;
  private AudioChannel off;
  private AudioChannel[] hit = new AudioChannel[5];
  private AudioChannel[] idle = new AudioChannel[2];
  private AudioChannel[] strike = new AudioChannel[3];
  private AudioChannel[] swing = new AudioChannel[8];
  public Saber() {
    start = new AudioChannel("start0.wav");
    on = new AudioChannel("on0.wav");
    off = new AudioChannel("off0.wav");
    for (int i=0; i<hit.length; i++) {
      hit[i] = new AudioChannel("hit"+i+".wav"); }
    for (int i=0; i<idle.length; i++) {
      idle[i] = new AudioChannel("idle"+i+".wav"); }
    for (int i=0; i<strike.length; i++) {
      strike[i] = new AudioChannel("strike"+i+".wav"); }
    for (int i=0; i<swing.length; i++) {
      swing[i] = new AudioChannel("swing"+i+".wav"); }
  }
  AudioChannel start() {return start;}
  AudioChannel on() {return on;}
  AudioChannel off() {return off;}
  AudioChannel hit() {return hit[int(random(hit.length))];}
  AudioChannel idle() {return idle[int(random(idle.length))];}
  AudioChannel strike() {return strike[int(random(strike.length))];}
  AudioChannel swing() {return swing[int(random(swing.length))];}
  
  private AudioChannel playing;
  private boolean isOpening = true;
  private boolean isDrawn = false;
  private boolean isGone = false;
  private int lastMode = 0;
  AudioChannel decideSound(Loc acc) {
    if (!isDrawn) {
      if (isOpening) {
        playing=start();
        playing.play();
        isOpening = false;
        return playing;
      }
    } else {
      float norm = acc.norm();
      AudioChannel sound = playing;
      if (norm>1.5 && lastMode<1) {sound = strike();sound.play();lastMode=1;}
      if (norm>1.8 && lastMode<2) {sound = hit();sound.play();lastMode=2;}
      if (norm<=1.5) lastMode=0;
      if (sound!=playing) {
        playing=sound;
      }
    }
    if (playing!=null && playing.state==Ess.STOPPED) playing=null;
    return playing;
  }
  void switchDraw() {
    if (isDrawn) {
      on().stop();
      playing = off();
    } else {
      off.stop();
      playing = on();
    }
    isDrawn=!isDrawn;
    playing.play();
  }
  AudioChannel bg() {
    AudioChannel toRet;
    toRet = (isDrawn?swing():idle());
    if (!isGone) toRet.play();
    return toRet;
  }
  void allStop() {
    isGone = true;
  }
}

