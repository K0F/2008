FTPClient ftp; 
String[] files;

void putFile (String ftpp, String logn, String pass, String directoryH,String directoryR, String fileNameH)
{
  String fileNameR = fileNameH+"";
  sending = true;
  try
  {
    
    


    ftp = new FTPClient();
    ftp.setRemoteHost("ftp://"+ftpp);

    FTPMessageCollector listener = new FTPMessageCollector();
    ftp.setMessageListener(listener);
    fill(255);
    text("Connecting..\n",10,10);
    ftp.connect();

    text ("Logging in\n",10,20);
    ftp.login(logn,pass);

    text ("Setting up passive, ASCII transfers\n");
    ftp.setConnectMode(FTPConnectMode.PASV);
    ftp.setType(FTPTransferType.BINARY);


    text ("Putting file\n",10,30);
    ftp.put(sketchPath+"/"+directoryH+"/"+fileNameH, "/"+directoryR+"/"+fileNameR, false);
/*
    println ("Directory after put");
    files = ftp.dir(".", true);
    for (int i = 0; i < files.length; i++)
    {
      println (i+" "+files[i]);
    }
*/



    text ("Quitting client\n",10,40);
    ftp.quit();


    String messages = listener.getLog();
    text ("Listener log:\n",10,50);

    println(messages);
    text ("Transfer complete\n",10,60);

  }
  catch (Exception e)
  {

    println("Error "+e);

  }
  
  sending = false;

}   
