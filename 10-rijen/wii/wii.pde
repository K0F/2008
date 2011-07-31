/**
 * P5aber on Ess lib.
 * by Classiclll. 
 */
import krister.Ess.*;
import lll.wrj4P5.*;
import lll.Loc.*;

FFT afft;
Saber saber;
Wrj4P5 wii;
AudioChannel bg;

void setup() 
{
  size(500, 350);
  wii = new Wrj4P5(this).connect();
  Ess.start(this); // Start Ess
  saber = new Saber();
  bg=saber.idle();
  bg.play();
  afft = new FFT(); // We want 256 frequency bands, so we pass in 512
}
void draw() 
{
  if (wii.isConnecting()) return;
  background(0);
  AudioChannel sound = saber.decideSound(wii.rimokon.sensed);
  if (sound==null) sound=bg;
  try {
    afft.getSpectrum(sound);
    for (int i = 0; i < 256; i++) {
      float x = width - pow(1024, (255.0 - i) / 256);
      float maxY = max(0, afft.maxSpectrum[i] * height * 10);
      float freY = max(0, afft.spectrum[i] * height * 10);
      stroke(96);
      line(x, height, x, height - maxY);
      stroke(128,256,198);
      line(x, height, x, height - freY);
    }
  } catch(ArrayIndexOutOfBoundsException e) { }
}

void buttonPressed(RimokonEvent evt, int rid) {
  if (evt.wasPressed(evt.B)) {
    //saber.switchDraw();
//    wii.rimokon.vibrateFor(70);
  }
}

void disconnected(int rid) {
  saber.allStop();
}

void audioChannelDone(AudioChannel ch) {
  if (bg.state==Ess.STOPPED) bg=saber.bg();
}

void stop() {
  Ess.stop(); // When program stops, stop Ess too
  super.stop();
}

