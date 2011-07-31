/**
saveasjpg taken from http://processinghacks.com/hacks:saveasjpg
@author Yonas Sandb?k
*/
 
import com.sun.image.codec.jpeg.*;
 
byte[] bufferImage(PImage srcimg){
  ByteArrayOutputStream out = new ByteArrayOutputStream();
  BufferedImage img = new BufferedImage(srcimg.width, srcimg.height, 2);
  img = (BufferedImage)createImage(srcimg.width,srcimg.height);
  for(int i = 0; i < srcimg.width; i++)
  	for(int j = 0; j < srcimg.height; j++)
  		img.setRGB(i,j,srcimg.pixels[j*srcimg.width+i]);
  try{
    JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
    JPEGEncodeParam encpar = encoder.getDefaultJPEGEncodeParam(img);
    encpar.setQuality(1,false);
    encoder.setJPEGEncodeParam(encpar);
    encoder.encode(img);
  }
  catch(FileNotFoundException e){
    System.out.println(e);
  }
  catch(IOException ioe){
    System.out.println(ioe);
  }
  return out.toByteArray();
}

