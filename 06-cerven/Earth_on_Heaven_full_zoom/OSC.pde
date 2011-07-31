/**
 *	OSC class for communication with PD
 */

class OSC{
  OscP5 osc;
  NetAddress addr;
  int port;

  OSC(String _addr,int _port){
    //// get port and address //////////////////////// :: >
    port=_port;
    osc = new OscP5(this,_port);
    //// port for sending plus 1 //////////////////////// :: >
    addr = new NetAddress(_addr,port+1);
  }

  //// function for sending a data depends on PD parsing //////////////////////// :: >
  //// sending real coordinates, latitude and longitude in one message //////////////////////// :: >
  //// first value is identifer for PD parse procedure //////////////////////// :: >
  void send(int _ident,float _whatX,float _whatY){
    OscMessage message = new OscMessage("/osc");
    message.add(_ident);                
    message.add(_whatX);		
    message.add(_whatY);
    osc.send(message, addr);
  }
}
