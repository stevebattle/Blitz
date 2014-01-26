class Bomb {
  int FUSE = 5; // bomb can destroy this many floors
  
  PImage image;
  boolean falling = false;
  int building;
  int x,y;
  int minimum;
  
  Bomb() {
    image = loadImage("bomb.gif");
  }
  
  void drop(int x, int y) {
    building = city.getBuilding(x);
    this.x = building<0 ? x : city.getBuildingX(building)+city.block.width/2;
    this.y = y;
    bomb.falling = true;
    minimum = max(0,building>=0?city.floors[building]-FUSE:0);
  }
  
  void draw() {
    image(image,x-image.width/2,y-image.height/2);
  }
  
  int altitude() {
    return (height -BORDER -GROUND -y)/city.block.height;
  }
  
  void step() {
    y += STEP;
    int a = altitude();
    if (building>=0) city.bomb(building,a);
    if (a<=minimum) falling = false;
  }
}
