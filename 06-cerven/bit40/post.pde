/**
savetoweb taken from http://processinghacks.com/hacks:savetoweb
@author Yonas Sandb?k
*/
 
String url = "http://krystof.pesek5.eu/test/";  // i.e. http://www.google.com/ (with a slash on the end)

void saveToWeb_saveFileString(String title, String ext, String folder, String[] data, boolean popup)
{
  println("SAVING File START");  
  postData(title+"_"+year()+nf(month(),2)+nf(day(),2)+"-"+nf(hour(),2)+nf(minute(),2)+nf(second(),2),ext,folder,join(data,"\n").getBytes(),popup);
  println("SAVING File STOP");  
}
 
void saveToWeb_saveFile(String title, String ext, String folder, byte[] data, boolean popup)
{
  println("SAVING File START");  
  postData(title+"_"+year()+nf(month(),2)+nf(day(),2)+"-"+nf(hour(),2)+nf(minute(),2)+nf(second(),2),ext,folder,data,popup);
  println("SAVING File STOP");  
}
 
// For saving a jpg, you have to use [[hacks:saveasjpg|this]] code.
void saveToWeb_saveJPG(String title, String folder, PImage src)
{
  println("SAVING JPG START");  
  postData(title+"_"+year()+nf(month(),2)+nf(day(),2)+"-"+nf(hour(),2)+nf(minute(),2)+nf(second(),2),"jpg",folder,bufferImage(src),true);
  println("SAVING JPG STOP");  
}
 
void postData(String title, String ext, String folder,  byte[] bytes, boolean popup)
{
  try{
    URL u = new URL(url+"saveFile.php?title="+title+"&ext="+ext+"&folder="+folder);
    URLConnection c = u.openConnection();
 
    // post multipart data
    c.setDoOutput(true);
    c.setDoInput(true);
    c.setUseCaches(false);
 
    // set request headers
    c.setRequestProperty("Content-Type", "multipart/form-data; boundary=AXi93A");
 
    // open a stream which can write to the url
    DataOutputStream dstream = new DataOutputStream(c.getOutputStream());
 
    // write content to the server, begin with the tag that says a content element is comming
    dstream.writeBytes("--AXi93A\r\n");
 
    // discribe the content
    dstream.writeBytes("Content-Disposition: form-data; name=\"data\"; filename=\"whatever\" \r\nContent-Type: image/jpeg\r\nContent-Transfer-Encoding: binary\r\n\r\n");
    dstream.write(bytes,0,bytes.length);
 
    // close the multipart form request
    dstream.writeBytes("\r\n--AXi93A--\r\n\r\n");
    dstream.flush();
    dstream.close();
 
    // read the output from the URL
    try{
      BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
      String sIn = in.readLine();
      boolean b = true;
 
      while(sIn!=null){
        if(sIn!=null){
          if(popup) if(sIn.substring(0,folder.length()).equals(folder)) link(url+sIn, "_blank"); 
          System.out.println(sIn);
        }
        sIn = in.readLine();
      }
    }
    catch(Exception e){
      e.printStackTrace();
    }
  }
  catch(Exception e){
    e.printStackTrace();
  }
}
