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
    this.playerWidth = 80;
    this.playerHeight = 85;
    this.yVelocity = 0;
    this.gravity = 0.8;
    this.jumpHeight = 15;
    this.isJumping = false;
    this.isDucking = false;
    
    
  }
  
  void update() {
    if (isJumping) {
      yVelocity += gravity;
      y += yVelocity;
      
      if (y >= screenHeight - 40 - this.playerHeight) { // 275
        y = screenHeight - 40 - this.playerHeight;
        // height - gras size - img size
        isJumping = false;
        yVelocity = 0;
      }
    }
    
    if (isDucking) {
      if (y <= screenHeight - 40 - this.playerHeight + 33) { // 308
        y = screenHeight - 40 - this.playerHeight + 33;
        // height - gras size - img size
      }
    } else {
      playerHeight = 85;
    }
  }
  
  void draw() {
    imageMode(CORNER);
    if (isDucking) {
      if (frameCount % 20 < 10) {
        imageMode(CORNER);
        image(dinoDuck2, x - dinoDuck1.width/6, y, dinoDuck1.width, dinoDuck1.height);
      } else {
        imageMode(CORNER);
        image(dinoDuck1, x - dinoDuck2.width/6, y, dinoDuck2.width, dinoDuck2.height);
      }
    } else if (isJumping) {
      image(dinoJump, x, y, playerWidth, playerHeight);
    } else {
      y = screenHeight - 40 - this.playerHeight;
      // Alternate running images based on frame count
      if (frameCount % 20 < 10) {
        imageMode(CORNER);
        image(dinoRun1, x - dinoRun1.width/6 + 2, y, dinoRun1.width, dinoRun1.height);
        fill(0,255,0);
        rectMode(CORNER);
        //rect(x - dinoRun1.width/6, y, dinoRun1.width, dinoRun1.height);
      } else {
        imageMode(CORNER);
        image(dinoRun2, x - dinoRun2.width/6, y, dinoRun2.width, dinoRun2.height);
        fill(255,0,0);
        rectMode(CORNER);
        //rect(x - dinoRun2.width/6, y, dinoRun2.width, dinoRun2.height);
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
