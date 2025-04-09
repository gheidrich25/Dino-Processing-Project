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

GameManager game;
Integer imageDisplay = 0;

void setup() {
  size(800, 400);
  game = new GameManager();
  
  //Load statements for photos
  dinoIdle = loadImage("dino.png");
  dinoRun1 = loadImage("dino_left_up.png");        
  dinoRun2 = loadImage("dino_right_up.png");         
  dinoJump = loadImage("dino.png");        
  dinoDuck = loadImage("dinoDuck.png");        
  cactus = loadImage("cactus.png");                      
  pterodactyl = loadImage("pterodactyl.png");     
  background = loadImage("grass1.png");      
  
  //Resize statements
  dinoIdle.resize(200,200);
  //dinoRun1.resize(250,185);
  //dinoRun2.resize(240,195);
  
  
  // sounds we will use
  jumpSound = new SoundFile(this, "jumpSound.mp3");             
  gameOverSound = new SoundFile(this, "gameOverSound.mp3");    
  bgMusic = new SoundFile(this, "bgMusic1.mp3");          
  clickSound = new SoundFile(this, "clickSound.mp3");    
}

void draw() {
  game.update();
  game.drawUI();
  
  noTint();
  if(imageDisplay % 2 == 0){
    image(dinoRun1, 195,203);
  }else{
    image(dinoRun2, 200, 190);
  }
  
  tint(255,0,0);
  image(dinoRun1, 95,103);
  tint(0,255,0);
  image(dinoRun2, 100, 90);
  
 
  
}

void mousePressed() {
  if (game.gameState.equals("play")) {
    game.player.jump();
  }
  if (game.gameState.equals("start")) {
     imageDisplay += 1;
  }
}

void keyPressed() {
  if (keyCode == DOWN) {
    game.player.duck(true);
  }
}

void keyReleased() {
  if (keyCode == DOWN) {
    game.player.duck(false);
  }
}