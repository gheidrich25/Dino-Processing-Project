float screenHeight = 400;

class Player {
  float x, y;
  float playerWidth, playerHeight;
  float yVelocity;
  float gravity;
  float jumpHeight;
  boolean isJumping;
  boolean isDucking;
  
  Player(float x, float y) {
    this.x = x;
    this.y = y;
    this.playerWidth = 60;
    this.playerHeight = 80;
    this.yVelocity = 0;
    this.gravity = 0.8;
    this.jumpHeight = 15;
    this.isJumping = false;
    this.isDucking = false;
    
    print(screenHeight + "|" + this.playerWidth + "|" + (screenHeight - 40 - this.playerHeight) + "|");
    
    
  }
  
  void update() {
    if (isJumping) {
      yVelocity += gravity;
      y += yVelocity;
      
      if (y >= screenHeight - 40 - this.playerHeight) {
        y = screenHeight - 40 - this.playerHeight;
        // height - gras size - img size
        print("JUMP");
        isJumping = false;
        yVelocity = 0;
      }
    }
    
    if (isDucking) {
      playerHeight = 40;
    } else {
      playerHeight = 85;
    }
  }
  
  void draw() {
    imageMode(CORNER);
    if (isDucking) {
      image(dinoDuck, x, y, playerWidth, playerHeight);
    } else if (isJumping) {
      image(dinoJump, x, y, playerWidth, playerHeight);
    } else {
      // Alternate running images based on frame count
      if (frameCount % 20 < 10) {
        imageMode(CORNER);
        image(dinoRun1, x - dinoRun1.width/6, y, dinoRun1.width, dinoRun1.height);
        fill(0,255,0);
        rectMode(CORNER);
        rect(x - dinoRun1.width/6, y, dinoRun1.width, dinoRun1.height);
      } else {
        imageMode(CORNER);
        image(dinoRun2, x - dinoRun2.width/6, y, dinoRun2.width, dinoRun2.height);
        fill(255,0,0);
        rectMode(CORNER);
        rect(x - dinoRun2.width/6, y, dinoRun2.width, dinoRun2.height);
      }
    }
    
    //println("Idle size: " + dinoIdle.width + "x" + dinoIdle.height);
    //println("Run1 size: " + dinoRun1.width + "x" + dinoRun1.height);
    //println("Run2 size: " + dinoRun2.width + "x" + dinoRun2.height);
    //println("Jump size: " + dinoJump.width + "x" + dinoJump.height);
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
