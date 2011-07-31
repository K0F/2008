import promidi.*;

Sequencer sequencer;
boolean running = false;

void setup(){
  sequencer = new Sequencer();

  MidiIO midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  midiIO.closeOutput(1);
  MidiOut test = midiIO.getMidiOut(1,1);

  Track track = new Track("one", test);
  track.setQuantization(Q._1_4);
  track.addEvent(new Note(1, 127 ,40), 0);
  track.addEvent(new Note(2, 80,40), 1); 
  track.addEvent(new Note(3, 90,40), 2);
  track.addEvent(new Note(4, 127,40), 3);
  track.addEvent(new Note(5, 127,120), 4);
  track.addEvent(new Note(6, 127,40), 5);  
   track.addEvent(new Note(7, 127,40), 6);
   track.addEvent(new Note(8, 127,120), 7);
  track.addEvent(new Note(9, 127 ,40), 8);
  track.addEvent(new Note(10, 80,40), 9); 
  track.addEvent(new Note(11, 90,40), 10);
 track.addEvent(new Note(12, 127,40), 11);
track.addEvent(new Note(13, 127,40), 12); 
track.addEvent(new Note(14, 127,40), 13); 
 track.addEvent(new Note(15, 127,40), 14);
  track.addEvent(new Note(16, 127,40), 15);

  Song song = new Song("test", 120);
  song.addTrack(track);
  sequencer.setSong(song);
  sequencer.setLoopStartPoint(0);
  sequencer.setLoopEndPoint(2048);
  sequencer.setLoopCount(-1);
}

void mousePressed(){
  if(mouseButton == LEFT) {
    sequencer.start();
     running = true;
  }
  else{ 
  sequencer.stop();
  running = false;
}
}

void draw(){
  background(0);
   if(running){
    fill(255);
    triangle(10,10,3,5,3,15); 
   }
}
