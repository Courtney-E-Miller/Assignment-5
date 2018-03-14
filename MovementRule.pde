import java.util.*;

class MovementRule {
  /* The default constructor. For now, does nothing.
  *
  */
  public MovementRule() {
  }
  
  /* For now, returns the Square containing the most sugar. 
  *  In case of a tie, use the Square that is closest to the middle according 
  *  to g.euclidianDistance(). 
  *  Squares should be considered in a random order (use Collections.shuffle()). 
  */
  
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle) {
    Square maxS = g.grid[0][0];
    Square current = null;
    int max = 0;
    Collections.shuffle(neighbourhood);
    //for(Square i : neighbourhood){
    for (int i = 0; i < neighbourhood.size(); i++) {
      current = neighbourhood.get(i);
      if(current.getSugar() > max){
        maxS = current;
        max = maxS.getSugar();
      }
      if(current.getSugar() == max){
        if(g.euclidianDistance(current, middle) < g.euclidianDistance(maxS, middle)){
          maxS = current;
        }
      }
    }
    System.out.println(maxS.getX() + ", " + maxS.getY());
    return maxS; // stubbed
    
  }
  

}