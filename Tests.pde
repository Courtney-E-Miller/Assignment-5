import java.util.LinkedList;

public class SquareTester{
  void test(){
    Square s = new Square(5, 9, 50, 50); // square with sugarLevel 5, maxSugarLevel 9, position (x, y) = (50, 50)
    assert (s.getSugar() == 5);
    assert (s.getMaxSugar() == 9);
    assert(s.getX() == 50);
    assert(s.getY() == 50);
    
    //constructor is now working
    
    //setSugar() tests
    s.setSugar(6);
    assert(s.getSugar() == 6);
    s.setSugar(10);
    assert(s.getSugar() == 9);
    s.setSugar(-3);
    assert(s.getSugar() == 0);
    s.setSugar(6);
    assert(s.getSugar() == 6);
    //we check up on maxSugar again because this would be an easy bug to create
    assert(s.getMaxSugar() == 9);
    //test edge cases 
    s.setSugar(7);
    assert(s.getSugar() == 7);
    s.setSugar(0);
    assert(s.getSugar() == 0);
    //now test things that are out of range
    s.setSugar(-1);
    assert(s.getSugar() == 0);
    s.setSugar(10);
    //due to specifications 
    assert(s.getSugar() == 9);
    //make sure that setting it BACK to -1 still sets it to 0
    s.setSugar(-1);
    assert(s.getSugar() == 0);
    //setSugar is working now.
    
    //setMaxSugar tests:
    s.setMaxSugar(-3);
    assert(s.getMaxSugar() == 0);
    s.setMaxSugar(9);
    assert(s.getMaxSugar() == 9);
    s.setSugar(8);
    s.setMaxSugar(6);
    assert(s.getMaxSugar() == 6);
    assert(s.getSugar() == 6);
    s.setMaxSugar(-5);
    assert(s.getMaxSugar() == 0 && s.getSugar() == 0);
    s.setMaxSugar(10);
    assert(s.getMaxSugar() == 10);
    s.setSugar(5);
    assert(s.getSugar() == 5);
    s.setMaxSugar(11);
    assert(s.getMaxSugar() == 11 && s.getSugar() == 5);
    
    
    //setMaxSugar is working now
    
    //getAgent tests:
    //since we should start out with no agents
    assert(s.getAgent() == null);
    
    //creating a new agent to test getAgent()
    Agent a = new Agent(0, 0, 0, null);
    s.setAgent(a);
    assert(s.getAgent() == a);
    s.setAgent(a);
    assert(s.getAgent() == a);
    s.setAgent(null);
    assert(s.getAgent() == null);
    //setAgent is now working
    
    //tests for class Square are now complete (we're not testing display())
  }
}
  
  public class GrowbackRuleTester{
    void test(){
    //GrowbackRule(int rate) tests:
    GrowbackRule n = new GrowbackRule(3);
    //UNSURE OF HOW TO TEST GrowbackRule(int rate)
    
    //growBack() tests:
    Square s = new Square(1, 10, 2, 2);
    n.growBack(s);
    assert(s.getSugar() == 4);
    n.growBack(s);
    assert(s.getSugar() == 7);
    n.growBack(s);
    assert(s.getSugar() == 10);
    n.growBack(s);
    assert(s.getSugar() == 10);
    //growBack() is now working
    
    //tests for class GrowbackRule are now complete
    }
  }
  
  public class SugarGridTester{
    void test(){
      //SugarGrid() tests:
      GrowbackRule n = new GrowbackRule(3);
      SugarGrid g = new SugarGrid(50, 40, 25, n);
      assert(g.getWidth() == 50);
      assert(g.getHeight() == 40);
      assert(g.getSquareSize() == 25);
      //constructor and accessors work
      
      //getSugarAt() tests:
      assert(g.getSugarAt(9, 8) == 0);
      assert(g.getSugarAt(10, 9) == 0);
      assert(g.getSugarAt(3, 3) == 0);
      assert(g.getSugarAt(0, 2) == 0);
      assert(g.getSugarAt(11, 7) == 0);
      assert(g.getSugarAt(0, 0) == 0);
      //getSugatAt() is now working:
      
      //getMaxSugarAt(), getSugarAt, getAgentAt() tests:
      for(int i = 0; i < g.getWidth(); i++){
        for(int j = 0; j < g.getHeight(); j++){
          assert(g.getSugarAt(i, j) == 0);
          assert(g.getMaxSugarAt(i, j) == 0);
          assert(g.getAgentAt(i, j) == null);
        }
      }
      //getMaxSugarAt(), getSugarAt, getAgentAt() are now working:

      
      Agent a = new Agent(0, 0, 0, null);
      for(int i = 0; i < g.getWidth(); i++){
        for(int j = 0; j < g.getHeight(); j++){
          assert(g.getAgentAt(i, j) == null);
          g.placeAgent(a, i, j);
          assert(g.getAgentAt(i, j) == a);
        }
      }

      assert(g.euclidianDistance(g.grid[10][10], g.grid[10][10]) == 0);
      assert(g.euclidianDistance(g.grid[10][10], g.grid[14][14]) == Math.sqrt(32));
      assert(g.euclidianDistance(g.grid[2][3], g.grid[49][39]) == Math.sqrt(25));
      assert(g.euclidianDistance(g.grid[2][3], g.grid[49][39]) == g.euclidianDistance(g.grid[49][39], g.grid[2][3]));
      assert(g.euclidianDistance(g.grid[2][39], g.grid[49][3]) == g.euclidianDistance(g.grid[49][39], g.grid[2][3]));
      assert(g.euclidianDistance(g.grid[49][3], g.grid[2][39]) == g.euclidianDistance(g.grid[49][39], g.grid[2][3]));
      
      //adddSugarBlob tests:
      
      //checks to make sure current maxSugar is at 0 for whole grid before we add a blob
        for(int i = 0; i < g.getWidth(); i++){
          for(int j = 0; j < g.getHeight(); j++){
            assert(g.getMaxSugarAt(i, j) == 0);
        }
      }
      
      
      g.addSugarBlob(5, 5, 5, 4);
      assert(g.grid[5][5].getMaxSugar() == 4);
      assert(g.grid[5][4].getMaxSugar() == 3);
      //addSugarBlob() is working
      
      //generateVision() testing:
      g.generateVision(5, 5, 2);
      
      //addAgentAtRandom() testing:
      //create new empty sugar grid
      SugarGrid f = new SugarGrid(50, 40, 25, n);
      for(int i = 0; i < g.getWidth(); i++){
          for(int j = 0; j < g.getHeight(); j++){
            assert(f.grid[i][j].getAgent() == null);
          }
      }
      
     Agent c = new Agent(0, 0, 0, null);
     f.addAgentAtRandom(c);    

     
    }
    
  }
  
  public class AgentTester{
    void test(){
      MovementRule m = new MovementRule();
      Agent a = new Agent(5, 6, 7, m);
      assert(a.getMetabolism() == 5);
      assert(a.getVision() == 6);
      assert(a.getSugarLevel() == 7);
      assert(a.getMovementRule() == m);
      //Constructor and accessors now work
      
      Square s = new Square(5, 5, 0, 0);
      Square t = new Square(5, 5, 0, 1);
      t.setAgent(a);
      assert(t.getAgent() == a);
      a.move(t, s);
      assert(s.getAgent() == a);
      assert(t.getAgent() == null);
      //move is now working correctly
      
      assert(a.getSugarLevel() == 7);
      assert(a.isAlive() == true);
      a.step();
      assert(a.getSugarLevel() == 2);
      assert(a.isAlive() == true);
      a.step();
      assert(a.getSugarLevel() == 0);
      assert(a.isAlive() == false);
      a.step();
      assert(a.getSugarLevel() == 0);
      assert(a.isAlive() == false);
      //step() and isAlive() are now working
      
      
      Agent b = new Agent(5, 6, 7, m);
      assert(t.getSugar() == 5);
      assert(b.getSugarLevel() == 7);
      b.eat(t);
      assert(t.getSugar() == 0);
      assert(b.getSugarLevel() == 12);
    }
  }