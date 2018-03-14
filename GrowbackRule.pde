class GrowbackRule {
  /* Initializes a new GrowbackRule with the specified growth rate.
  *
  */
  private int rate;
  
  public GrowbackRule(int rate) {
    this.rate = rate;
  }
  
  /* Increases the sugar in Square s by the growth rate, 
  *  up to the maximum value that can be stored in s. 
  *  Note: you should use only public methods of the Square class. 
  *  The Autograder will provide its own Square class, 
  *  which may not have the private methods or variable names you expect.
  */
  public void growBack(Square s) {
    //increases the sugarLevel by rate once per time you call method
    s.setSugar(this.rate + s.getSugar());
  }
}