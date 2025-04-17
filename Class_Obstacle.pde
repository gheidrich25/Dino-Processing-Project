class Obstacle {
  float x, y, width, height;
  float speed;
  String type;
  
  // cactus, cactusLarge? pit, highPterodactyl, lowPterodactyl
  
  Obstacle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.speed = 4;
    
    
    float rand = random(100);
    // 40% cactus, 10% cactusLarge? 20% pit, 15% highPterodactyl, 15% lowPterodactyl
    if (rand < 40) {
      // 40% chance
      type = "cactus";
    } else if (rand < 50) {
      // 10% chance
      type = "cactusLarge";
    } else if (rand < 70) {
      // 20% chance
      type = "pit";
    } else if (rand < 85){ //30% pterodatyl
      // 15% chance
      type = "pteroLow";
      // ADJUST Y VALUE
    } else {
      // 15% chance
      type = "pteroHigh";
      // ADJUST Y VALUE
    } 
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
