//Metric Trees and Voronoi Diagrams
//Grant Schindler, 2008

int N = 512;                                 //Image Size

//Tree Size
int nrLevels = 5;                            //Tree Levels/Depth
int nrBranches = 8;                          //Tree Branches at Each Level
int[] treeLevels   = {15, 5,  3};            //Preset Trees of Different Sizes
int[] treeBranches = { 2, 8, 32};  
int treeMode = 1;                            //Selects Between Above 3 Tree Sizes

//Points (To Be Stored in Tree)
int nrPoints = 32768;                        //Number of Points to Be Clustered Into Tree
float[][] gPoints = new float[nrPoints][2];  //The 2D Points Themselves
int[] gIndices = new int[nrPoints];          //Point Indices (Passed to Recursive buildTree)

//Tree Representation
float[][] gNodes;      //Internal Nodes in the Tree (2D Cluster Centers)
int[][] gLeaf;         //Leaf Node Storage of Point Indices
int[] gLeafCounts;     //Count of Points Stored at Each Leaf Node
int[] tCount;          //Temporary Count of Assigned Points to Each Node While Clustering/Building Tree
int maxLeafCount = 0;  //Max #Points @Each Leaf Node (make non-zero if actually using tree for storage/retrieval)

//----------------------------------------------------------------------------------
//-- Voronoi Drawing ---------------------------------------------------------------
//--
//--   1. computeLevelWeights - We're blending together [nrLevels] different Voronoi 
//-- diagrams, but want to emphasize the low-frequency diagrams more heavily, as in: 
//-- pixelValue = (1/2)*voronoi1 + (1/4)*voronoi2 + (1/8)*voronoi3 + ...
//--
//--   2. drawVoronoi - For a single tree level, the Voronoi diagram emerges when
//-- for each pixel, we find the closest and 2nd-closest nodes (cluster centers)
//-- and plot the ratio of distances: (distClosest/dist2ndClosest)
//--
//----------------------------------------------------------------------------------

int pRow = 0, pCol = 0, pIteration = 1, pMax = 2, iterations;   //Pixel-Rendering Order
int pickupLevel = 0, pickupBranch = 0, pickupStart = 0;         //Tree-Search Resumption
float levelWeightSum = 0.0;
float[] levelWeightTable;
float gRatio; //Ratio of Closest:2nd-Closest Cluster Center for A Searched Point at Specific Level
boolean odd(int x) {return x % 2 != 0;}

//Pre-compute blending weights for each Voronoi level
void computeLevelWeights(){
  levelWeightSum = 0.0;
  float base = 1.2 + 0.8 * min(1.0, ((float)(20 - nrLevels)/(20.0 - 2.0))); //Different Base Weight for Deeper Trees
  for (int l = 0; l < nrLevels; l++){
    levelWeightTable[l] = pow(base, (float)(nrLevels-1) - (float)l);  //More Weight for Levels Near Root
    levelWeightSum += levelWeightTable[l];                            //Sum -> Normalize Weights Over All Levels
  }
}

void drawVoronoi(){
  iterations = 0;
  while (iterations < pMax){
    
      //Pixel-Rendering Order: Compute (x,y) from pIteration, pRow, and pCol
      if (pCol >= pMax) {pRow++; pCol = 0;
        if (pRow >= pMax) {pIteration++; pRow = 0; pMax = int(pow(2,pIteration));}}
      boolean pNeedsDrawing = (pIteration == 1 || odd(pRow) || (!odd(pRow) && odd(pCol)));
      int x = pCol * (N/pMax); int y = pRow * (N/pMax);
      pCol++; //Increment Position for Next Run Through
      
      if (pNeedsDrawing){
        iterations++;
        float fx = (float)x/(float)N - 0.5;                             //Set Pixel Position
        float fy = (float)y/(float)N - 0.5;
        float[] p = {fx,fy};
    
        float pixel = 0.0;
        pickupBranch = 0; pickupStart = 0; pickupLevel = 0;             //Reset Search
        for (int l = 0; l < nrLevels; l++){
          int node = search(p,l,pickupLevel,pickupBranch,pickupStart);  //sets gRatio = distClosest / dist2ndClosest
          float a = pow(gRatio,5.0);                                    //Raise Ratio to Some Power (Adjust Gamma)
          float fraction = levelWeightTable[l]/levelWeightSum;          //Compute Weight for Current Level
          pixel += fraction * (1.0-a);                                  //Level-Weighted Sum of Ratios
        }
        float rgb = 255.0 * pow(pixel,3.0);                             //Final Gamma Adjustment
        stroke(rgb);  fill(rgb);
        rect(x,y,(N/pMax)-1,(N/pMax)-1);
      }
  }
  if (pRow == N-1) {empty = false; println("Done");}
}

//----------------------------------------------------------------------------------
//-- Metric Trees ------------------------------------------------------------------
//--
//--   This is a dumb implementation of hierarchically clustering a set of random
//-- points, saving the cluster centers as nodes in a tree, then for all the points
//-- assigned to each node, recursively clustering again down to the leaves.
//--   For speed, we never even iterate the k-means clustering.  We just pick a
//-- random initial cluster center and keep it.  It works here because our data
//-- is uniformly distributed.  For example:
//--   Given 30,000 points, pick 5 of them at random to be "cluster centers". Assign
//-- each of the 30,000 points to the whichever of the 5 cluster centers is closest.
//-- You now have 5 groups of roughly 6,000 points.  Use the same procedure to divide
//-- each group into 5 sub-groups, and so on, recursively.
//--  
//----------------------------------------------------------------------------------

void newTree(){
  initTree();
  initPoints();
  buildTree(gIndices,nrPoints,0,0,0);
  computeLevelWeights();
}

void initTree(){
  int nrNodes = 0;
  for( int i = 0; i < nrLevels; i++){
    nrNodes += (int)(pow(nrBranches,i+1));
  }
  gNodes = new float [nrNodes][2];
  gLeaf = new int [(int)pow(nrBranches,nrLevels)][maxLeafCount];
  gLeafCounts = new int[(int)pow(nrBranches,nrLevels)];
  tCount = new int[nrBranches];
  levelWeightTable = new float[nrLevels];
}

void initPoints(){
  for (int i = 0; i < nrPoints; i++){
    gPoints[i] = rand2(0.5);
    gIndices[i] = i;}
}

void buildTree(int[] points, int n, int level, int branch, int start){
  initNodes(points,n,level,branch,start);                           //Initialize Cluster Centers
  int[][] localAssigned = assignNodes(points,n,level,branch,start); //Divide Points into [nrBranches] Clusters.
  int[] localCount = new int[nrBranches];
  for (int i = 0; i < nrBranches; i++){localCount[i] = tCount[i];}  //Number of Points in Each Cluster
  
  if (level < nrLevels-1){                                          //Recurse
    start += pow(nrBranches,level+1);
    for (int i = 0; i < nrBranches; i++){
      buildTree(localAssigned[i],localCount[i], level+1, branch * nrBranches + i, start);
    }
  }
  else{                                                             //Store Assigned Points at Leaf Nodes
    for (int i = 0; i < nrBranches; i++){
      int node = branch*nrBranches+i;                               //(Ignore start, this is Leaf Nodes Only)
      gLeafCounts[node] = min(maxLeafCount,localCount[i]);
      for (int j = 0; j < gLeafCounts[node]; j++){
        gLeaf[node][j] = localAssigned[i][j];
      }
    }
  }
}

void initNodes(int[] points, int n, int level, int branch, int start){
  for (int i = 0; i < nrBranches; i++){
    if (n > 0){ gNodes[start+branch*nrBranches+i] = gPoints[points[i * n/nrBranches]];} //Init to Random Point
    else{       gNodes[start+branch*nrBranches+i] = gPoints[0];} //Fill with First Point (Not Even in Cluster)
  }
}

int[][] assignNodes(int[] points, int n, int level, int branch, int start)
{
  //Initialize Counts
  int[][] tAssigned = new int[nrBranches][n];
  for (int c = 0; c < nrBranches; c++){tCount[c] = 0;}
  
  //For each point, find nearest center, add to list
  for (int i = 0; i < n; i++){
    int c = search(gPoints[points[i]], level, level, branch, start);
    tAssigned[c][tCount[c]] = points[i];
    tCount[c]++;
  }
  return tAssigned;
}

//Recursively find closest cluster center up to given depth
int search(float[] p, int depth, int level, int branch, int start){
  float minDist  = -1.0, minDist2 = -1.0;
  int node = 0;
  
  for (int i = 0; i < nrBranches; i++){
    float d = sqDist2(p,gNodes[start+branch*nrBranches+i]);
    if (d < minDist2 || minDist2 < 0.0){
      if (d < minDist || minDist < 0.0){
        minDist2 = minDist;
        minDist = d;
        node = i;
      }
      else minDist2 = d;
    }
  }
  
  //Next Search Level
  pickupLevel  = level+1;
  pickupBranch = branch * nrBranches + node;
  pickupStart  = start + (int)pow(nrBranches,level+1);
  
  if (depth == level){
    gRatio = sqrt(minDist/minDist2);
    return node;
  }
  else return search(p,depth, pickupLevel, pickupBranch, pickupStart);
}

float sqDist2(float[] a, float[] b) {return sq(a[0]-b[0]) + sq(a[1]-b[1]);}

float[] rand2(float s){
  float a = N/2;
  float[] rand = {floor(0.5 + random(-s,s) * a)/(a+1.0) ,floor(0.5 + random(-s,s) * a)/(a+1.0)};
  return rand;
}

//----------------------------------------------------------------------------------
// -- User Interface ---------------------------------------------------------------
//----------------------------------------------------------------------------------
PFont font10, font12;
//PImage[] img = new PImage[3];
//String[] jpgs = {"2_15.jpg","8_5.jpg","32_3.jpg"};
int tLeft = 280, buttonsY = N+23, buttonsX[] = new int[3];
boolean empty = true, drawUI = true;

void setup(){
  size(N,N+48);
  frameRate(99999);
  randomSeed(8); //Ensure Same Initial Points Every Run
  for (int i=0; i < 3; i++) {buttonsX[i]=42 + i*40;} //Image Buttons
  font12=font10 = createFont("Veranda",9); //Fonts
  newTree();
}

void draw(){
  if (empty) {drawVoronoi();} else {frameRate(10);}
  if (drawUI) drawInterface();
}

void drawInterface(){
  stroke(221,221,204); fill(221,221,204); rect(0,N,N,48); //Clear Background
  stroke(0);
  for (int i=0; i < 3; i++){    
    rect(buttonsX[i]-16,buttonsY-16,33,33);
    //tint((treeMode==i) ? 255: 100);
    //image(img[i],buttonsX[i]-16 + 1,buttonsY-16 + 1);    //Draw Image Buttons
  }
  textFont(font12); textAlign(RIGHT); fill(128); text("Branches",tLeft,buttonsY + 9); 
  textFont(font10); textAlign(LEFT); fill(128); text("Levels",tLeft,buttonsY + 2);
  textFont(font12); textAlign(RIGHT); fill(0); text(treeBranches[treeMode],tLeft+74,buttonsY + 9);
  textFont(font10); textAlign(LEFT); fill(0); text(treeLevels[treeMode], tLeft+74 ,buttonsY + 2);
  textFont(font12); textAlign(LEFT); fill(128); text("=             =  32768 Leaf Nodes" ,tLeft+45,buttonsY + 9);
  drawUI = false;
}

void mouseClicked(){
  if (mouseY > N) {                              //Clicked Buttons
     for (int i=0; i < 3; i++){
       if (sq(mouseX-buttonsX[i]) < sq(16)){treeMode = i;}}}
  nrLevels   =   treeLevels[treeMode];
  nrBranches = treeBranches[treeMode];           //New Parameters
  newTree();
  pRow = 0; pCol = 0; pIteration = 1; pMax = 2;  //Reset Drawing
  empty = true;  drawUI = true;
  frameRate(99999);
}
