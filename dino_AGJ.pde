import processing.sound.*;

// color vars
color[] spectrum;
int colorIndex = 0;
int interval = 1000; // 1 second
int lastSwitchTime = 0;
int transitionStartTime;
color fromColor, toColor;
int transitionDuration = 1000; // 1 second

// images we will use
PImage dinoIdle;        
PImage dinoRun1;        
PImage dinoRun2;        
PImage dinoJump;        
PImage dinoDuck1; 
PImage dinoDuck2;   
PImage cactus;          
PImage pit;             
PImage pterodactyl;     
PImage background;      
PImage groundTile;
PImage grass1;
PImage grass2;


// sounds we will use
SoundFile jumpSound;        
SoundFile duckSound;        
SoundFile gameOverSound;    
SoundFile bgMusic;          
SoundFile clickSound;  
SoundFile highScoreSound;
SoundFile titleMusic;

GameManager game;
Integer imageDisplay = 0;

void setup() {
  size(800, 400);
  
  //Load statements for photos
  grass1 = loadImage("grass1.png");
  grass2 = loadImage("grass2.png");
  dinoIdle = loadImage("dino.png");
  dinoRun1 = loadImage("dino_left_up_resize.png");        
  dinoRun2 = loadImage("dino_right_up_resize.png");         
  dinoJump = loadImage("dino.png");        
  dinoDuck1 = loadImage("dinoDuck1.png"); 
  dinoDuck2 = loadImage("dinoDuck2.png");
  cactus = loadImage("cactus.png");                      
  pterodactyl = loadImage("pterodactyl.png");     
  background = loadImage("grass1.png");
       
  //Resize statements
  //dinoRUN 1,2 (80,85)
  //dinoDUCK 1 (110,52) 33 lower than run
  //dinoDUCK 2 (112, 52) 33 lower than run
  dinoIdle.resize(200,200);
  grass1.resize(40,40);
  grass2.resize(40,40);
  pterodactyl.resize(200,200);
  
  
  int dinoW = 200;
  int dinoH = 200;
  
  dinoIdle.resize(dinoW, dinoH);
  dinoJump.resize(dinoW, dinoH);
  //dinoRun1.resize(dinoW, dinoH);
  //dinoRun2.resize(dinoW, dinoH);
  
  // sounds we will use
  jumpSound = new SoundFile(this, "jumpSound.mp3");             
  gameOverSound = new SoundFile(this, "gameOverSound.mp3");    
  bgMusic = new SoundFile(this, "bgMusic1.mp3");          
  clickSound = new SoundFile(this, "clickSound.mp3");   
  highScoreSound = new SoundFile(this, "highScoreSound.mp3");
  titleMusic = new SoundFile(this, "title.mp3");
  
  //COLOR SETUP LOGIC ALL BELOW
  spectrum = new color[] {
    color(255, 0, 0),    // Red
    color(255, 165, 0),  // Orange
    color(255, 255, 0),  // Yellow
    color(0, 255, 0),    // Green
    color(0, 0, 255),    // Blue
    color(75, 0, 130),   // Indigo
    color(143, 0, 255)   // Violet
  };
  
  // Change from all black to a grey so I can use tint to change color
  greyscalePhoto(dinoIdle, 180);
  greyscalePhoto(pterodactyl, 180);
  
  
  fromColor = spectrum[0];
  toColor = spectrum[1];
  transitionStartTime = millis();
  
  game = new GameManager();
}

void draw() {
  game.update();
  game.drawUI();
  //noTint();
  //if(imageDisplay % 2 == 0){
  //  image(dinoRun1, 195,203);
  //}else{
  //  image(dinoRun2, 200, 190);
  //}
  
  //tint(255,0,0);
  //image(dinoRun1, 95,103);
  //tint(0,255,0);
  //image(dinoRun2, 100, 90);
}
void mousePressed() {
  
  game.mousePressed();
  
  
  if (game.gameState.equals("play")) {
    if(!clickSound.isPlaying()){
      jumpSound.play();
    }
    game.player.jump();
  }
  
  if (game.gameState.equals("start")) {
    clickSound.play();
    //imageDisplay += 1;
  }
  else{
    clickSound.play();
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

void greyscalePhoto(PImage photo, int val){
  photo.loadPixels();
  for (int i = 0; i < photo.pixels.length; i++) {
    color c = photo.pixels[i];
    float alpha = alpha(c);
    if (alpha > 0 && brightness(c) < 20) {
      photo.pixels[i] = color(val, alpha);  // keep original transparency and match other grey photos
    }
  }
  photo.updatePixels();
}
