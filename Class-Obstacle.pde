class Obstacle {
  float x, y;
  float speed;
  PImage sprite;

  Obstacle(PImage img, float startX, float startY, float speed) {
    sprite = img;
    x = startX;
    y = startY;
    this.speed = speed;
  }

  void update() {
    x -= speed;
  }

  void draw() {
    image(sprite, x, y);
  }

  boolean hits(Player p) {
    return x < p.x + 50 && x + 50 > p.x && y < p.y + 50 && y + 50 > p.y;
  }
}