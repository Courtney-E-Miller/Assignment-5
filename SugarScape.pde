SugarGrid myGrid;
void setup() {

  size(600, 600);
  
  SugarGrid m = new SugarGrid(10, 10, 25, new GrowbackRule(1));
  
  m.display();
  
  SquareTester st = new SquareTester();
  st.test();  
  fill(0,255,0);
  noStroke();
  ellipse(50, 50, 50,50);
 
 GrowbackRuleTester gr = new GrowbackRuleTester();
  gr.test();  
  fill(0, 255, 0);
  noStroke();
  ellipse(50, 50, 50,50);


  SugarGridTester sg = new SugarGridTester();
  sg.test();
  fill(0, 255, 0);
  noStroke();
  ellipse(50, 50, 50,50);
  
  AgentTester at = new AgentTester();
  at.test();
  fill(0, 255, 0);
  noStroke();
  ellipse(50, 50, 50,50);
  /*
  size(1000,800);
  myGrid = new SugarGrid(50,40,20, new GrowbackRule(0));
  myGrid.addSugarBlob(10,10,1,8);
  Agent a1 = new Agent(1,1,50, new MovementRule());
  myGrid.placeAgent(a1,9,9);
  
  myGrid.display();
  frameRate(2);
  */
}


void draw() {
  /*
   myGrid.update();
  background(255);
  myGrid.display();
  */
  
}