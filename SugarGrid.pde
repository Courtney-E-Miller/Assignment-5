import java.lang.Math;
import java.util.*;
class SugarGrid {


  /* Initializes a new SugarGrid object with a w*h grid of Squares, 
  *  a sideLength for the squares (used for drawing purposes only) 
  *  of the specified value, and 
  *  a sugar growback rule g. 
  *  Initialize the Squares in the grid to have 0 initial and 0 maximum sugar.
  *
  */
  private int w;
  private int h;
  private int sideLength;
  private GrowbackRule g;
  public Square[][] grid;
  
  public SugarGrid(int w, int h, int sideLength, GrowbackRule g) {
    this.w = w;
    this.h = h;
    this.sideLength = sideLength;
    this.g = g;
    grid = new Square[w][h];
    for(int i = 0; i < w; i++){
      for(int j = 0; j < h; j++){
        grid[i][j] = new Square(0, 0, i, j);
      }
    }    
  }

  /* Accessor methods for the named variables.
  *
  */
  public int getWidth() {
    return this.w; 
  }
  
  public int getHeight() {
    return this.h; 
  }
  
  public int getSquareSize() {
    return this.sideLength; 
  }
  
  /* returns respectively the initial or maximum sugar at the Square 
  *  in row i, column j of the grid.
  *
  */
  public int getSugarAt(int i, int j) {
    if(i >= 0 && j >= 0 && i < w && j < h){
      return(grid[i][j].getSugar());
    }
    else{
      //since this means this a square at index [i][j] does not exist (out of bounds)
      return -1;
    }
  }
 
  public int getMaxSugarAt(int i, int j) {
    if(i >= 0 && j >= 0 && i < w && j < h){
      return(grid[i][j].getMaxSugar());
    }
    else{
      //since this means this a square at index [i][j] does not exist (out of bounds)
      return -1;
    }
  }

  /* returns the Agent occupying the square at position (i,j) in the grid, 
  *  or null if no agent is present there.
  *
  */
  public Agent getAgentAt(int i, int j) {
    if(i >= 0 && j >= 0 && i < w && j < h){
        return(grid[i][j].getAgent());
    }
    else{
      //since this means this a square at index [i][j] does not exist (out of bounds)
      return null;
    }
  }

  /* places Agent a at Square(x,y), provided that the square is empty. 
  *  If the square is not empty, the program should crash with an assertion failure.
  *
  */
  public void placeAgent(Agent a, int x, int y) {
    if(grid[x][y].getAgent() == null){
      grid[x][y].setAgent(a);
    }
    else if (grid[x][y].getAgent() != null){
       assert(1 == 0); 
    }
  }

  /* A method that computes the Euclidian distance between two squares on the grid 
  *  at (x1,y1) and (x2,y2). 
  *  Points are indexed from (0,0) up to (width-1, height-1) for the grid. 
  *  The formula for Euclidean distance is normally sqrt( (x2-x1)2 + (y2-y1)2 ) However...
  *  
  *  As in the book, the grid is a torus. 
  *  This means that an Agent that moves off the top of the grid ends up at the bottom 
  *  (and vice versa), and 
  *  an Agent that moves off the left hand side of the grid ends up on the right hand 
  *  side (and vice versa). 
  *
  *  You should return the minimum euclidian distance between the two points. 
  *  For example, euclidianDistance((1,1), (19,19)) on a 20x20 grid would be 
  *  sqrt(2*2 + 2*2) = sqrt(8) ~ 3, and not sqrt(18*18 + 18*18) = sqrt(648) ~ 25. 
  *
  *  The built-in Java method Math.sqrt() may be useful.
  *
  */
  /*
  public double euclidianDistance(Square s1, Square s2) {
    int outgridX = abs( abs( min( abs(s1.getX()-0), abs(h-s1.getX()))) + abs( min( abs(s2.getX()-0), abs(h-s2.getX()))));
    int ingridX = abs( s1.getX() - s2.getX());
    int finalX = min(outgridX, ingridX);
    
    int outgridY = abs( abs( min( abs(s1.getY()-0), abs(h-s1.getY()))) + abs( min( abs(s2.getY()-0), abs(h-s2.getY()))));
    int ingridY = abs( s1.getY() - s2.getY());
    int finalY = min(outgridY, ingridY);
    println(s1.getX(), s1.getY(), s2.getX(), s2.getY());
    println(ingridX, ingridY, outgridX, outgridY);
    return Math.sqrt(finalX*finalX + finalY*finalY);
    
  }
  */
  
    public double euclidianDistance(Square a, Square b){
    int aX = a.getX();
    int aY = a.getY();
    int bX = b.getX();
    int bY = b.getY();
    int ingridX = abs(aX-bX);
    int ingridY = abs(aY-bY);
    int outgridX = abs(  min(abs(aX-0), abs(w-aX)) + min(abs(bX-0), abs(w-bX))  );
    int outgridY = abs(  min(abs(aY-0), abs(h-aY)) + min(abs(bY-0), abs(h-bY))  );
    //println(aX, aY, bX, bY);
    //println( ingridX, ingridY, outgridX, outgridY);
    int finalX = min(outgridX, ingridX);
    int finalY = min(outgridY, ingridY);
    return Math.sqrt(finalX*finalX + finalY*finalY); 
  }
  
  /* Creates a circular blob of sugar on the gird. 
  *  The center of the blob is at position (x,y), and 
  *  that Square is updated to store a maximum of max sugar or 
  *  its current maximum value, whichever is greater. 
  *
  *  Then, every square within euclidian distance of radius is updated 
  *  to store a maximum of (max-1) sugar, or its current maximum value, 
  *  whichever is greater. 
  *
  *  Then, every square within euclidian distance of 2*radius is updated 
  *  to store a maximum of (max-2) sugar, or its current maximum value, 
  *  whichever is greater. 
  *
  *  This process continues until every square has been updated. 
  *  Any Square that has a new maximum value 
  *  should also have its Sugar level set to this maximum.
  *
  */

  
    public void addSugarBlob(int x, int y, int radius, int maxL) {
    int increment = maxL;
    while (increment > 0) {
      for (int i = 0; i < w; i++) {
        for (int j = 0; j < h; j++) {
          double mdist = euclidianDistance(grid[i][j], grid[x][y]);
          if (mdist < radius * increment) {
            int sugar = maxL - increment;
            grid[i][j].setMaxSugar(sugar);
            grid[i][j].setSugar(sugar);
          }
        }
      }
      increment--;
      grid[x][y].setSugar(maxL);
      grid[x][y].setMaxSugar(maxL);
    }
  }

  
  /* Returns a linked list containing radius squares in each cardinal direction, 
  *  centered on (x,y). 
  *
  *  For example, generateVision(5,5,2) should return the squares 
  *   (5,5), (4,5), (3,5), (6,5), (7,5), (5,4), (5,3), (5,6), and (5,7). 
  *
  *  Your program may do whatever it likes if (x,y) is not a point on the grid, 
  *  or radius is negative. 
  *
  *  When radius is 0, it should return a list containing only (x,y). 
  *
  */
  public LinkedList<Square> generateVision(int x, int y, int radius) {
    LinkedList<Square> vision = new LinkedList<Square>();
    for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          if(euclidianDistance(grid[x][y], grid[i][j]) <= radius){
            if((i == x) || (j == y)){
              vision.add(grid[i][j]);
              /*
             if( abs(i - x) >= 0  && abs(j - y) == 0){
              vision.add(grid[i][j]);
            }
            if( abs(i - y) >= 0  && abs(i - x) == 0){
              vision.add(grid[i][j]);
            }
            */
            }
          }
          
        }
    }
   return vision;
  }
  
  public void update(){
    for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          //applies growBack() to every square
          g.growBack(grid[i][j]);
          
          //if the square is not empty, completes processing, else skips over these commands    
          if (grid[i][j].getAgent() != null){
             Agent a = grid[i][j].getAgent();
             int vision = a.getVision();
             LinkedList<Square> area = generateVision(grid[i][j].getX(), grid[i][j].getY(), vision);
             
             //applies movement rule move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle) 
             MovementRule m = a.getMovementRule();
             Square goal = m.move(area, this, this.grid[(w-1)/2][(h-1)/2]);
             //System.out.println(goal.getX() + ", " + goal.getY());
             
             //moves agent to perferred square (will crash if square is occupied)
             a.move(grid[i][j], goal);
             
             //agent performes metabolic processes
             a.step();
             
             //if agent is dead, marks square to unoccupied
             if(a.isAlive() == false){
               goal.setAgent(null);
             }
             
             //if agent is still alive, it eats all the sugar at its current square
             if(a.isAlive() == true){
               a.eat(goal);
             }
          }
  
        }
      } 
  }
  
  public void display() {
     for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          grid[i][j].display(sideLength);
        }
     } 
  }
  
  public void addAgentAtRandom(Agent a){
    LinkedList<Square> emptySquares = new LinkedList<Square>();
    
    //cycles through sugarGrid and adds empty squares to list emptySquares
    for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          if(grid[i][j].getAgent() == null){
            emptySquares.add(grid[i][j]);
          }
        }
     }

     //creates a random number bewtewen 0 and the size of the linkedList
     int num = (int)random(0, emptySquares.size());
     
     //accesses the square in emptySquares at that random index
     Square chosenOne = emptySquares.get(num);
     
     //places the agent at that randomly chosen square
     chosenOne.setAgent(a);     
  }
  
  
  
  
}