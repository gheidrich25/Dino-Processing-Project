// classes rn are designed and hypotheticals

import processing.sound.*;

// images we will use
PImage dinoIdle;        
PImage dinoRun1;        
PImage dinoRun2;        
PImage dinoJump;        
PImage dinoDuck;        
PImage cactus;          
PImage pit;             
PImage pterodactyl;     
PImage background;      
PImage groundTile;      

// sounds we will use
SoundFile jumpSound;        
SoundFile duckSound;        
SoundFile gameOverSound;    
SoundFile bgMusic;          
SoundFile clickSound;       

GameManager gameManager;

void setup() {
  size(800, 400);
  gameManager = new GameManager();
  dinoIdle = loadImage("dino.png");        
  dinoRun1 = loadImage("dino_left_up.png");        
  dinoRun2 = loadImage("dino_right_up.png");         
  dinoJump = loadImage("dino.png");        
  dinoDuck = loadImage("dinoDuck.png");        
  cactus = loadImage("cactus.png");                      
  pterodactyl = loadImage("pterodactyl.png");     
  background = loadImage("grass1.png");      
  
  // sounds we will use
  jumpSound = new SoundFile(this, "jumpSound.mp3");             
  gameOverSound = new SoundFile(this, "gameOverSound.mp3");    
  bgMusic = new SoundFile(this, "bgMusic1.mp3");          
  clickSound = new SoundFile(this, "clickSound.mp3");    
}

void draw() {
  gameManager.update();
  gameManager.drawUI();
}

void mousePressed() {
  if (gameManager.gameState.equals("play")) {
    gameManager.player.jump();
  }
}

void keyPressed() {
  if (keyCode == DOWN) {
    gameManager.player.duck(true);
  }
}

void keyReleased() {
  if (keyCode == DOWN) {
    gameManager.player.duck(false);
  }
}

class GameManager {
  String gameState = "start"; // start, instructions, play, gameover
  Player player;
  ArrayList<Obstacle> obstacles;
  int score;
  String difficulty = "medium";

  GameManager() {
    player = new Player(100, 300);
    obstacles = new ArrayList<Obstacle>();
    score = 0;
  }

  void update() {
    if (gameState.equals("play")) {
      player.update();
      // update obstacles and game logic 
    }
    // other states
  }

  void drawUI() {
    background(255);
    if (gameState.equals("start")) {
      textAlign(CENTER);
      textSize(32);
      text("Dino Dash", width/2, 100);
      textSize(16);
      text("Click to Play (Medium / Hard)", width/2, 150);
      text("Instructions", width/2, 180);
      image(dinoIdle, width/2 - 50, 200);
    } else if (gameState.equals("instructions")) {
      textAlign(LEFT);
      textSize(16);
      text("Controls:\n- Jump: Mouse Click\n- Duck: Down Arrow\n\nClick to return", 100, 100);
    } else if (gameState.equals("play")) {
      player.draw();
      text("Score: " + score, 10, 20);
    } else if (gameState.equals("gameover")) {
      textAlign(CENTER);
      textSize(32);
      text("Game Over", width/2, height/2 - 40);
      textSize(16);
      text("Score: " + score, width/2, height/2);
      text("Click to Restart", width/2, height/2 + 30);
    }
  }

  void changeState(String newState) {
    gameState = newState;
  }
}

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

class Button {
  float x, y, w, h;
  String label;

  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }

  void draw() {
    fill(200);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }

  boolean isClicked(float mx, float my) {
    return mx >= x && mx <= x + w && my >= y && my <= y + h;
  }
}
