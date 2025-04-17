class Obstacle {
  float x, y, width, height;
  float speed;
  String type;
  
  Obstacle(String type, float x, float y, float w, float h) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.speed = 5;
  }
  
  void update() {
    x -= speed;
  }
  
  void draw() {
    if (type.equals("cactus")) {
      image(cactus, x, y - height, width, height);
    } else if (type.equals("pit")) {
      fill(0);
      rect(x, y, width, height);
    } else if (type.equals("pterodactyl")) {
      image(pterodactyl, x, y - height/2, width, height);
    }
  }
  
  boolean checkCollision(Player player) {
    return (x < player.x + player.playerWidth && 
            x + width > player.x && 
            y < player.y + player.playerWidth && 
            y + height > player.y);
  }
  
  boolean isOffScreen() {
    return x + width < 0;
  }
}
