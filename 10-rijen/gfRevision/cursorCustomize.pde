  
void customizeCursor(String path) {
 
  Toolkit toolkit = getToolkit();
  Dimension allowedDimensions = toolkit.getBestCursorSize(16, 16);
  System.out.println("allowed dimensions = "+allowedDimensions.width);
  int allowedColours = toolkit.getMaximumCursorColors();
  if (!allowedDimensions.equals(new Dimension(0, 0)) && (allowedColours != 0)) {
    Image iamgge;
    if(allowedDimensions.width>16) {
      
      byte[] b = loadBytes(path);
   iamgge = getToolkit().createImage(b);
 
    }else {
 byte[] b = loadBytes(path);
   iamgge = getToolkit().createImage(b);
    }
    if (iamgge != null) {
 try {
   Cursor customCursor = toolkit.createCustomCursor(iamgge,new Point(1, 1),"custom_cursor");
   this.setCursor(customCursor);
 }catch(Exception exc) {
   System.err.println("Unable to create custom cursor.");
 }
 
    }
 
  }
} 
