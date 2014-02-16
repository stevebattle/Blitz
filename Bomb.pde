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
    this.x = building<0 ? x : city.getBuildingCentre(building);
    this.y = y;
    bomb.falling = true;
    minimum = max(0,building>=0?city.floors[building]-FUSE:0);
  }
  
  void draw() {
    if (falling) {
      image(image,x-image.width/2,y-image.height/2);
    }
  }
  
  int altitude() {
    return (height -BORDER -GROUND -y)/city.block.height;
  }
  
  void step() {
    if (falling) {
      y += STEP;
      int a = altitude();
      if (building>=0) city.destroy(building,a);
      if (a<=minimum) falling = false;
    }
  }
}
