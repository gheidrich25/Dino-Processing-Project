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
    this.speed = 4 + score * 0.01;
    this.score = score;

    float rand = random(100);
    if(score <= 400){
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
    } else {
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
      float scale = 1.5;
      float w = width  * scale;
      float h = height * scale;
      image(cactus, x, y - h + 23, w, h);
    } 
    // display larger cactus image
    else if (type.equals("cactusLarge")) {
      float scale = 1.8;
      float w = width  * scale;
      float h = height * scale;
      image(cactus, x, y - h + 23, w, h);
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
  
  // posteriori collision check
  // maybe add pad if it is too close
  boolean checkCollision(Player p) {
    float ox1 = x;           // obstacle left
    float oy1 = y - height;  // obstacle top 
    float ox2 = x + width;   // obstacle right
    float oy2 = y;           // obstacle bottom
  
    float px1 = p.x;                     // player left
    float py1 = p.y;                     // player top
    float px2 = p.x + p.playerWidth;     // player right
    float py2 = p.y + p.playerHeight;    // player bottom
  
    float pad = 40; // offset box around cactus/pit
    return !( px2 - (pad + 10) < ox1   //  player right < obstacle left
           || px1 + (pad - 15) > ox2   // player left  > obstacle right
           || py2 + ((pad/2) - 5) < oy1   // player bottom < obstacle top
           || py1 - ((pad/2) + 5) > oy2   // player top > obstacle bottom
           );
  }

  // checks if object is offScreen
  boolean isOffScreen() {
    return x + width < 0;
  }
}