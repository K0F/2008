public class PhpCom{
  String skriptFn;
  PApplet parent;
  String s;
  String[] List;
  String path;
  int testR;
  boolean retrive = false;

  PhpCom(PApplet _parent, String _skriptFn){
    parent=_parent;
    skriptFn=_skriptFn;
  }

  public void ask(String _path){
    path = "?path="+_path;
  }

  public void getData(String _ask){

    s = sendToPhp(_ask);

    List = split(s,",");
    List = sort(List,List.length-1);
    
    
    if(List!=null){
      retrive = true;
      //println(List);
    }
    else{
      retrive = false;
    }


  }

  public void sendDataToShow(String _ask){
    sendToPhp(_ask);
  }

  String sendToPhp(String what){
    String strn = "";
    try { 
      ask(what);  
      URL url;  
      URLConnection urlConn;  
      DataOutputStream dos;  
      DataInputStream dis;

      url = new URL(skriptFn+path);  
      urlConn = url.openConnection();  
      urlConn.setDoInput(true);  
      urlConn.setDoOutput(true);  
      urlConn.setUseCaches(false);  
      urlConn.setRequestProperty ("Content-Type", "application/x-www-form-urlencoded");  

      dos = new DataOutputStream (urlConn.getOutputStream());  

      dis = new DataInputStream(urlConn.getInputStream());  

      strn = dis.readLine();
      
      dis.close(); 

    }
    catch (MalformedURLException mue) {  
      ;   
    } 
    catch (IOException ioe) {  
      ;   
    }
    return strn;
  }

  boolean ready(){
    boolean b;
    if(retrive) 
      b=true;
    else
      b=false; 
    return b;
  }
}
