float screenHeight = 400;

class Player {
  float x, y;
  float width, height;
  float yVelocity;
  float gravity;
  float jumpHeight;
  boolean isJumping;
  boolean isDucking;
  
  Player(float x, float y) {
    this.x = x;
    this.y = y;
    this.width = 60;
    this.height = 80;
    this.yVelocity = 0;
    this.gravity = 0.8;
    this.jumpHeight = 15;
    this.isJumping = false;
    this.isDucking = false;
    
    print(screenHeight + "|" + this.height + "|" + (screenHeight - 40 - this.height) + "|");
    
  }
  
  void update() {
    if (isJumping) {
      yVelocity += gravity;
      y += yVelocity;
      
      if (y >= screenHeight - 40 - this.height) {
        y = screenHeight - 40 - this.height;
        print("JUMP");
        isJumping = false;
        yVelocity = 0;
      }
    }
    
    if (isDucking) {
      height = 40;
    } else {
      height = 80;
    }
  }
  
  void draw() {
    imageMode(CORNER);
    if (isDucking) {
      image(dinoDuck, x, y, width, height);
    } else if (isJumping) {
      image(dinoJump, x, y, width, height);
    } else {
      // Alternate running images based on frame count
      if (frameCount % 20 < 10) {
        image(dinoRun1, x, y, width, height);
      } else {
        image(dinoRun2, x, y, width, height);
      }
    }
  }
  
  void jump() {
    if (!isJumping) {
      yVelocity = -jumpHeight;
      isJumping = true;
      jumpSound.play();
    }
  }
  
  void duck(boolean isDucking) {
    this.isDucking = isDucking;
  }
}
