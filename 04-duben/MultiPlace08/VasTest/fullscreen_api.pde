/**
 * FullScreen support for processing. 
 * 
 * For a detailed reference see http://www.superduper.org/processing/fullscreen_api/
 * 
 * - setFullScreen( true | false ) 
 *   goes to / leaves fullscreen mode
 *
 * - setResolution( x, y ) 
 *   sets the resolution 
 * 
 * - createFullScreenKeyBindings() 
 *   links ctrl+f (or apple+f for macintosh) to enter/leave fullscreen mode
 *
 * WARNING: This package conflicts with the processing "present" option. If you want
 * fullscreen from the start use like this: 
 * 
 * void setup(){
 *   setFullScreen( true );               // get fullscreen exclusive mode
 *   setResolution( 640, 480 );           // change resolution to 640, 480
 *   createFullScreenKeyBindings();       // let ctrl+f switch to window mode
 * }
 * 
 * LIMITATIONS: 
 * - The size of the sketch can not be changed, when your sketch is
 *   smaller than the screen it will be centered. 
 * - The ESC key exits the sketch, this is processing standard. 
 * - Requires min. Java 1.4 to be installed work
 * - Only works for applications (not for applets)
 * 
 * by hansi, http://www.superduper.org,  http://www.fabrica.it
 *
 */


// We use this frame to go to fullScreen mode...
Frame fsFrame = new Frame(); 
GraphicsDevice fsDevice = fsFrame.getGraphicsConfiguration().getDevice(); 
//AWTEventListener fsKeyListener;

// desired x/y resolution
int fsResolutionX, fsResolutionY; 

// the first time wait until the frame is displayed
boolean fsIsInitialized; 

// bind the keys? 
boolean fsBindKeys; 

// Setup everything...
{
  fsFrame.setTitle( "FullScreen" ); 
  fsFrame.setUndecorated( true ); 
  fsFrame.setBackground( Color.black ); 
  fsFrame.setLayout( null ); 
  fsFrame.addWindowListener( new FSWindowListener() );
  fsFrame.setSize( fsDevice.getDisplayMode().getWidth(), fsDevice.getDisplayMode().getHeight() ); 
}


/**
 * Are we in FullScreen mode? 
 *
 * @returns true if so, yes if not
 */
boolean isFullScreen(){
  return fsDevice.getFullScreenWindow() == fsFrame; 
}


/**
 * FullScreen is only available is applications, not in applets! 
 *
 * @returns true if fullScreen mode is available
 */
boolean isFullScreenAvailable(){
  return frame != null;
}

  
/**
 * Enters/Leaves fullScreen mode. 
 *
 * @param fullScreen true or false
 * @returns true on success
 */
boolean setFullScreen( boolean fullScreen ){
  
  // If it's called from setup we wait until the applet initialized properly
  if( frameCount == 0 && fullScreen == true ){
    new FSWaitForInitThread().start(); 
    
    return true; 
  }
  
  
  
  
  
  if( fullScreen == isFullScreen() ){
    // no change required! 
    return true; 
  }
  else if( fullScreen ){
    // go to fullScreen mode...
    
    if( isFullScreenAvailable() ){
      fsDevice.setFullScreenWindow( fsFrame ); 
      
      // remove applet from processing frame and attach to fsFrame
      frame.removeAll(); 
      frame.setVisible( false ); 
      frame.setSize( width + frame.insets().left + frame.insets().right, 
                     height + frame.insets().top + frame.insets().bottom ); 
      fsFrame.add( this ); 
      this.requestFocus(); 
      
      // set nice resolution...
      setResolution( 0, 0 ); 
      
      
      return true; 
    }
    else{
      System.err.println( "Fullscreen mode not available" ); 
      return false; 
    }
  }
  else{
    // remove applet from fsFrame and attach to processing frame
    fsFrame.removeAll(); 
    frame.add( this ); 
    this.setLocation( frame.insets().left, frame.insets().top ); 
    this.requestFocus(); 
    
    fsDevice.setFullScreenWindow( null ); 
    fsFrame.setVisible( false ); 

    frame.setVisible( true ); 

    return true; 
  }
}


/**
 * Change display resolution. Only sets the resolution, use 
 * setFullScreen( true ) to go to fullscreen mode! 
 *
 * If you're not in fullscreen mode it memorizes the resolution and sets
 * it the next time you go in fullscreen mode
 *
 * @returns true if resolution change succeeded, false if not
 */
boolean setResolution( int xRes, int yRes ){
  if( xRes > 0 && yRes > 0 ){
    fsResolutionX = xRes; 
    fsResolutionY = yRes; 
  }
  
  
  // only change in fullscreen mode
  if( !isFullScreen() ){
    return false; 
  }
  
  
  // Change resolution only if values are somehow meaningfull
  if( fsResolutionX <= 0 || fsResolutionY <= 0 ){
    setLocation( ( fsDevice.getDisplayMode().getWidth() - width ) / 2, ( fsDevice.getDisplayMode().getHeight() - height ) / 2 ); 
    return false; 
  }
  
  DisplayMode modes[ ] = fsDevice.getDisplayModes(); 
  DisplayMode theMode = null; 

  for( int i = 0; i < modes.length; i++ ){
    
    if( modes[ i ].getWidth() == fsResolutionX && modes[ i ].getHeight() == fsResolutionY ){
      theMode = modes[ i ]; 
    }
  }


  // Resolution not supported? 
  if( theMode == null ){
    System.err.println( "Display mode not supported: " + fsResolutionX + "x" + fsResolutionY ); 
    setLocation( ( fsDevice.getDisplayMode().getWidth() - width ) / 2, ( fsDevice.getDisplayMode().getHeight() - height ) / 2 ); 
    return false; 
  }


  // Wait until we are in fullScreen exclusive mode..
  try{
    fsDevice.setDisplayMode( theMode ); 
    fsFrame.setSize( fsResolutionX, fsResolutionY ); 
  }
  catch( Exception e ){
    System.err.println( "Failed to go to fullScreen mode" ); 
    e.printStackTrace(); 
    return false; 
  }

  setLocation( ( fsDevice.getDisplayMode().getWidth() - width ) / 2, ( fsDevice.getDisplayMode().getHeight() - height ) / 2 ); 
  return true; 
}



/**
 * Add keyboard short cuts (CTRL + F to toggle fullscreen mode)
 * Watch out - if you call this function twice weird things might happen! 
 */
void createFullScreenKeyBindings(){
  fsBindKeys = true; 
}




final static int fsControlKey = Toolkit.getDefaultToolkit().getMenuShortcutKeyMask();

public void processKeyEvent( KeyEvent e ){
  
  // Are we allowed to look for key events? 
  if( fsBindKeys == false ){
    super.processKeyEvent( e ); 
  }
  
  // Catch the ESC key if in fullscreen mode
  else if( e.getKeyCode() == e.VK_ESCAPE ){
    if( isFullScreen() ){
      if( e.getID() == KeyEvent.KEY_RELEASED ){
        setFullScreen( false ); 
      }
    }
    else{
      super.processKeyEvent( e ); 
    }
  }
  
  // catch the cmd+f combination (alt+enter or ctrl+f for windows)
  else if( e.getID() == KeyEvent.KEY_PRESSED ){
    if( ( e.getKeyCode() == e.VK_F && e.getModifiers() == fsControlKey ) ||
        ( platform == WINDOWS && e.getKeyCode() == e.VK_ENTER && e.getModifiers() == e.VK_ALT ) ){
      // toggle fullscreen! 
      setFullScreen( !isFullScreen() ); 
    }
    else{
      super.processKeyEvent( e ); 
    }
  }
  else{
    super.processKeyEvent( e ); 
  }
}


/**
 * A window listener for the fullscreen window, that 
 * calls the exit() function of processing when the window 
 * is closed (using alt+f4, apple+w, or whatever)
 */
class FSWindowListener extends WindowAdapter{
  public void windowClosing( WindowEvent e ){
    // let processing exit! 
    exit(); 
  }
}



/**
 * A thread that invokes the setFullScreen() functionality delayed, 
 * in case it's called from setup()
 */
class FSWaitForInitThread extends Thread{
  
  public void run(){
    while( frameCount < 5 ){
      try{
        Thread.sleep( 1000 ); 
      }
      catch( Exception e ){
        System.err.println( "failed to go to fullscreen mode" ); 
        return; 
      }
    }
    
    if( !setFullScreen( true ) ){
      System.err.println( "failed to go to fullscreen mode" );
    }
  }
}
