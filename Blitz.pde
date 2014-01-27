/**
 * Blitz Resurrection
 * 
 * by Steve Battle
 *
 * A simple animated game.
 *
 */

color SKY_COLOUR = color(135,206,255); // sky blue 1
color GROUND_COLOUR = color(124,242,0); // lawn green
color TEXT_COLOUR = color(74,112,139); // sky blue 4
int BORDER = 12; // width/height of the border
int GROUND = 4; // height of ground in pixels
int CLEARANCE = 5; // clearance below the plane
int GAP = 2; // gap between buildings
int SPACE = 100; // space before first building
int STEP = 5; // pixels traversed in one step
int FONT_SIZE = 36;
int BONUS = 10;

Plane plane;
City city;
Bomb bomb;
PFont font;

int level = 0;
int score = 0, best = 0;

void drawGround() {
  fill(GROUND_COLOUR);
  stroke(GROUND_COLOUR);
  rect(BORDER, height -BORDER -GROUND, width - 2*BORDER, GROUND);
}

void drawScore() {
  fill(TEXT_COLOUR);
  textSize(FONT_SIZE);
  text("SCORE "+score,BORDER,BORDER+36);
}

void drawBest() {
  fill(TEXT_COLOUR);
  textSize(FONT_SIZE);
  text("BEST "+best,width/2,BORDER+36);
}

void setup() {
  size(450,300);
  font = loadFont("Checkbook-48.vlw");
  textFont(font);
  plane = new Plane();
  city = new City();
  bomb = new Bomb();
  startGame();
}
  
void startGame() {
  frameRate(30);

  // calculate maximum city height
  int cityHeight = height -2*BORDER -GROUND -plane.images[0].height -CLEARANCE;

  city.initialise(cityHeight, level++);  
  plane.initialise(cityHeight);
}

void draw() {
  background(SKY_COLOUR);
  drawGround();
  drawScore();
  drawBest();
  city.draw();
  bomb.draw();
  bomb.step();
  plane.draw();
  if (!plane.landed) plane.step();
  else startGame();
  
  if (mousePressed && !bomb.falling) {
    if (plane.crashed) {
      level = score = 0;
      startGame();
    }
    else if (city.count>0) plane.drop(bomb);
  }
  if (score>best) best = score;
}
