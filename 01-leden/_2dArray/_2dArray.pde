int[][] q = new int[100][150];
int[][] tri;
//... Allocate each part of the two-dimensional array individually.

void setup(){
  size(q.length,q[0].length);

  tri = new int[10][];        // Allocate array of rows
  for (int r=0; r < tri.length; r++) {
    tri[r] = new int[r+1];  // Allocate a row
  }



}
