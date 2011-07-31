import oscP5.*;//import the OSC library
import netP5.*;


class OSC{
  OscP5 osc;
  NetAddress addr;
  int port;

  OSC(String _addr,int _port){
    port=_port;
    osc = new OscP5(this,_port-1);
    addr = new NetAddress(_addr,port);
  }

  void send(int _ident,float _whatX,float _whatY){
    OscMessage message = new OscMessage("/msg");
    String ident = (char)(_ident+65)+"";
    message.add(ident);
    //message.add("x ");
    message.add(map(_whatX,0,width,0,1));
    //message.add("y ");
    message.add(map(_whatY,0,height,1,0));
    osc.send(message, addr);
  }
  
   void send(int _ident,float _whatX,float _whatY,float _whatZ){
    OscMessage message = new OscMessage("/msg");
    String ident = (char)(_ident+65)+"";
    message.add(ident);
    //message.add("x ");
    message.add(map(_whatX,0,width,0,1));
    //message.add("y ");
    message.add(map(_whatY,0,height,1,0));
    message.add(_whatZ);
    osc.send(message, addr);
  }

  void send(int _ident,float _what){
    OscMessage message = new OscMessage("/msg");
    String ident = (char)(_ident+65)+"";
    message.add(ident);
    message.add(_what);
    osc.send(message, addr);
  }

}
