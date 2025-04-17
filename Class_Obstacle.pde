class Obstacle {
  float x, y, width, height;
  float speed;
  String type;
  int score;

  Obstacle(float x, float y, float w, float h, int score) {
    this.x = x;
    this.y = y;  // ground line       
    this.width  = w;
    this.height = h;
    this.speed  = 4;
    this.score = score;

    float rand = random(100);
    if(score < 400){
      if (rand < 50) {
        // 50 percent chance of cactus
        type = "cactus";
      } else if (rand < 70) {
        // 20 percent chance of a larger cactus
        type = "cactusLarge";
      } else if (rand < 100) {
        // 30 percent chance of a pit
        type = "pit";
      }
    } else if(score > 400){
      if (rand < 40) {
        // 40 percent chance of cactus
        type = "cactus";
      } else if (rand < 50) {
        // 10 percent chance of a larger cactus
        type = "cactusLarge";
      } else if (rand < 70) {
        // 20 percent chance of a pit
        type = "pit";
      } else if (rand < 85) {
        // 15 percent chance of a low pterodactyl
        type = "pteroLow";
        this.y -= height * 0.5;
      } else {
        // 15 percent chance of a high pterodactyl
        type = "pteroHigh";
        // higher in the sky
        this.y -= height * 2.0;
      }
    }
  }

  void update() {
    x -= speed;
  }

  void draw() {
    // display cactus image
    if (type.equals("cactus")) {
      image(cactus, x, y - height, width, height);
    } 
    // display larger cactus image
    else if (type.equals("cactusLarge")) {
      image(cactus, x, y - height*1.5, width*1.5, height*1.5);
    } 
    // draw pit
    else if (type.equals("pit")) {
      noStroke(); 
      fill(0);
      rect(x, y, width, height);
    } 
    // displays both types of pterodactyl -- small and large
    else { 
      image(pterodactyl, x, y - height/2, width, height);
    }
  }

  // checks if player and obstacle collided
  boolean checkCollision(Player player) {
    // true or false if object and player are touching
    return (x < player.x + player.playerWidth && 
            x + width > player.x && 
            y < player.y + player.playerWidth && 
            y + height > player.y);
  }
  
  // checks if object is offScreen
  boolean isOffScreen() {
    return x + width < 0;
  }
}
