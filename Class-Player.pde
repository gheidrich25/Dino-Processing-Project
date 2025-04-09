class Player {
  float x, y;
  float velocity;
  boolean isJumping = false;
  boolean isDucking = false;
  PImage currentSprite;
  float groundLevel = 300;

  Player(float startX, float startY) {
    x = startX;
    y = startY;
    velocity = 0;
    currentSprite = dinoIdle;
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      velocity = -15;
      currentSprite = dinoJump;
      if (jumpSound != null) jumpSound.play();
    }
  }

  void duck(boolean state) {
    isDucking = state;
    currentSprite = isDucking ? dinoDuck : dinoIdle;
    if (state && duckSound != null) duckSound.play();
  }

  void update() {
    if (isJumping) {
      y += velocity;
      velocity += 0.8;
      if (y > groundLevel) {
        y = groundLevel;
        isJumping = false;
        velocity = 0;
        currentSprite = dinoIdle;
      }
    }
  }

  void draw() {
    image(currentSprite, x, y);
  }

  void reset() {
    y = groundLevel;
    isJumping = false;
    isDucking = false;
    velocity = 0;
    currentSprite = dinoIdle;
  }
}