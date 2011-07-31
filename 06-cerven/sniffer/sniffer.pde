import org.rsg.carnivore.*;
import org.rsg.lib.Log;

void setup(){
  size(600, 400);
  background(255);
  Log.setDebug(true); // Uncomment for verbose mode
  CarnivoreP5 c = new CarnivoreP5(this); 
  //c.setVolumeLimit(4); //limit the output volume (optional)
  //c.setShouldSkipUDP(true); //tcp packets only (optional)
}

void draw(){}

// Called each time a new packet arrives
void packetEvent(CarnivorePacket p){
  println("(" + p.strTransportProtocol + " packet) " + p.senderSocket() + " > " + p.receiverSocket());
  //println("Payload: " + p.ascii());
  //println("---------------------------\n");
}
