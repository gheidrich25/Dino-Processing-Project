//VAR for score tracking
int lastUpdateTime = 0;
// ground tiles variables
PImage[] groundTiles;
float[] tileX;
int tileCount = 22;
float scrollSpeed = 4;

//player vars

class GameManager {
  String gameState = "start";
  Player player;
  ArrayList<Obstacle> obstacles;
  int score;
  String difficulty = "medium";
  
  // Buttons
  Button mediumButton;
  Button hardButton;
  Button instructionsButton;
  Button returnButton;

  //time
  int startTime;
  int lastUpdateTime = 0; // for when score increments
  int cooldown; // next spawn time
  int lastSpawnTime = 0; // timestamp of last spawn
  
  // sound
  boolean soundPlayed = false;
  
  GameManager() {
    player = new Player(200, height);
    obstacles = new ArrayList<Obstacle>();
    score = 0;
    
    // Initialize buttons
    mediumButton = new Button(width/2 - 100, 140, 80, 30, "Medium");
    hardButton = new Button(width/2 + 20, 140, 80, 30, "Hard");
    instructionsButton = new Button(width/2 - 60, 190, 120, 30, "Instructions");
    returnButton = new Button(width/2 - 60, height - 80, 120, 30, "Return to Menu");
    
    //Initialization work for moving ground tiles
    groundTiles = new PImage[tileCount];
    tileX = new float[tileCount];
    
    for (int i = 0; i < tileCount; i++) {
      groundTiles[i] = (i % 2 == 0) ? grass1 : grass2;  // assume these are loaded already
      tileX[i] = i * grass1.width;
    }

    cooldown = 3000; // init cooldown time btwn obstacles

  }
  
  void update() {
    if (gameState.equals("play")) {
      if(titleMusic.isPlaying()){
         titleMusic.stop();
       } 
      player.update();
      
      // update obstacles and game logic 
      if (millis() - lastUpdateTime > 125) {
        score += 1;  // value per eigth second, dino game tested to be near 7 per second
        lastUpdateTime = millis();
         if ((score % 100 == 0) && (!highScoreSound.isPlaying())){
           highScoreSound.play();
        }
      }
      
      // start displaying obstacles after 3 seconds
      if (millis() - startTime > 3000
        && millis() - lastSpawnTime > cooldown) {
          // randomly generate obstacle and add to obstacle array
          obstacles.add(
            new Obstacle(
              width, 
              height - 60,    
              60,             
              40,
              score
            )
          );
          
          // save last spawn time for new obj
          lastSpawnTime = millis();
      
          // speed up spawns as score goes up/ randomly gen cooldown time
          int minCd = max(800, 2000 - score * 5); // min cooldown (goes down as score increases, but never below 500)
          int maxCd = max(1200, 3000 - score * 10); // max cooldown (goes down as score increases, but never below 800)
          cooldown = int(random(minCd, maxCd)); // randomly selects btwn min and max cooldown so it is unpredictable
        }
        // check for if obstacles are off screen or collided w player
        for(int i = obstacles.size() - 1; i >= 0; i--){
          Obstacle o = obstacles.get(i); // grab obstacles from array
          o.update(); // move w grass
          if(o.isOffScreen()){
            obstacles.remove(i); // remove if the obstacle is not on screen
          }
          else if(o.checkCollision(player)){
            changeState("gameover");
            return; // stop updating game
          }
        }
      }
  }
  
  void drawUI() {
    background(255);
    if (gameState.equals("start")) {
      int titleX = width/2;
      int titleY = 75;
      int titleW = 240;
      int titleH = 60;
      textAlign(CENTER);
      rectMode(CENTER);
      
      
      // Draw background "3D" box
      fill(50);  // shadow color
      rect(titleX + 5, titleY + 25, titleW, titleH, 20);  // offset shadow box
      fill(255);  // main box
      rect(titleX, titleY + 20, titleW, titleH, 20);  // rounded corners look modern
      
      // Draw 3D text shadow
      fill(100);
      textSize(48);
      text("DINO DASH", titleX + 4, titleY + 40);
      
      //text("DINO DASH", titleX, titleY + 36);
      
      rectMode(CORNER);
      fill(100, 200, 100);
      rect(mediumButton.x, mediumButton.y, mediumButton.w, mediumButton.h, 5);
      
      fill(200, 100, 100);
      rect(hardButton.x, hardButton.y, hardButton.w, hardButton.h, 5);
      
      fill(180);
      rect(instructionsButton.x, instructionsButton.y, instructionsButton.w, instructionsButton.h, 5);
      
      fill(0);
      textSize(16);
      textAlign(CENTER, CENTER);
      text(mediumButton.label, mediumButton.x + mediumButton.w/2, mediumButton.y + mediumButton.h/2);
      text(hardButton.label, hardButton.x + hardButton.w/2, hardButton.y + hardButton.h/2);
      text(instructionsButton.label, instructionsButton.x + instructionsButton.w/2, instructionsButton.y + instructionsButton.h/2);
      
      
      // Change tint color every interval
      if (millis() - lastSwitchTime > interval) {
        color c = spectrum[colorIndex];
      int r = (int) red(c);
      int g = (int) green(c);
      int b = (int) blue(c);
      
      println("CHANGE" + colorIndex + " | RGB(" + r + ", " + g + ", " + b + ")");
        colorIndex = (colorIndex + 1) % spectrum.length;
        lastSwitchTime = millis();
      }
      
      //NEW CODE FOR SMOOTH SHIFT OF COLORS
      float t = (millis() - transitionStartTime) / float(transitionDuration);
      t = constrain(t, 0, 1); // make sure it's in [0, 1] range
      color currentTint = lerpColor(fromColor, toColor, t);
      
      //Text color changing
      fill(currentTint, 100);  // soft glow with transparency
      textSize(48);
      for (int dx = -2; dx <= 2; dx++) {
        for (int dy = -2; dy <= 2; dy++) {
          // Skip the center so we don't double-draw the main text here
          if (dx != 0 || dy != 0) {
            text("DINO DASH", titleX + dx, titleY + 24 + dy);
          }
        }
      }  
      fill(0); // semi-transparent pulsing title
      textSize(48);
      text("DINO DASH", titleX, titleY+ 24);
      
      tint(currentTint, 255);
      for (int dx = -3; dx <= 3; dx++) {
        for (int dy = -3; dy <= 3; dy++) {
          // Skip the center so we don't double-draw the main text here
          if (dx != 0 || dy != 0) {
            image(dinoIdle, width/4 - 175 + dx, 175 + dy);
          }
        }
      } 
      noTint();
      image(dinoIdle, width/4 - 175, 175);
      
      // transition complete, move to next color
      if (t >= 1) {
        colorIndex = (colorIndex + 1) % spectrum.length;
        fromColor = toColor;
        toColor = spectrum[(colorIndex + 1) % spectrum.length];
        transitionStartTime = millis();
      }
      
      tint(currentTint, 255);
      for (int dx = -3; dx <= 3; dx++) {
        for (int dy = -3; dy <= 3; dy++) {
          // Skip the center so we don't double-draw the main text here
          if (dx != 0 || dy != 0) {
            image(pterodactyl, 3*width/4 + dx, 50 + dy);
          }
        }
      } 
      noTint();
      image(pterodactyl, 3*width/4, 50);
      
      
    } else if (gameState.equals("instructions")) {
      // Instructions screen
      fill(0);
      textAlign(CENTER);
      textSize(24);
      text("Instructions", width/2, 100);
      
      textSize(16);
      text("Controls:", width/2, 150);
      text("- Jump: Mouse Click", width/2, 180);
      text("- Duck: Down Arrow", width/2, 210);
      
      returnButton.draw();
      
      if(bgMusic.isPlaying()){
        bgMusic.stop();
      }
      if(jumpSound.isPlaying()){
        jumpSound.stop();
      }
      
    } else if (gameState.equals("play")) {
      noTint();
      // draw obstacles in obstacle array
      for(Obstacle o : obstacles){
        o.draw();
      }
      // draw player on top
      player.draw();
      fill(0);
      textAlign(LEFT);
      textSize(48);
      text("Score: " + score, 25, 50);
      
      if(!bgMusic.isPlaying()){
        bgMusic.play();
      }
      
      // GROUND TILE WORK
      imageMode(CORNER);
      for (int i = 0; i < tileCount; i++) {
        tileX[i] -= scrollSpeed;
      
        // Wrap tile to the right side if it goes off screen
        if (tileX[i] < -groundTiles[i].width) {
          tileX[i] = width;
        }
      
        image(groundTiles[i], tileX[i], height - groundTiles[i].height);
      }
      
    } else if (gameState.equals("gameover")) {
      fill(255,0,0);
      textAlign(CENTER);
      textSize(32);
      text("Game Over", width/2, height/2 - 40);
      textSize(16);
      text("Score: " + score, width/2, height/2);
      text("Click to Restart", width/2, height/2 + 30);
      // play game over sound
      if(!soundPlayed){
        gameOverSound.play();
        soundPlayed = true; // plays only once
      }
    }
  }
  
  void mousePressed() {
    if (gameState.equals("start")) {
      if (mediumButton.isClicked(mouseX, mouseY)) {
        difficulty = "medium";
        startGame();
      } 
      else if (hardButton.isClicked(mouseX, mouseY)) {
        difficulty = "hard";
        startGame();
      }
      else if (instructionsButton.isClicked(mouseX, mouseY)) {
        changeState("instructions");
      }
    } else if (gameState.equals("instructions")) {
      if (returnButton.isClicked(mouseX, mouseY)) {
        changeState("start");
      }
    } else if (gameState.equals("gameover")) {
      changeState("start");
    }
  }
  
  void startGame() {
    // Reset game variables
    player = new Player(200, 280);
    obstacles = new ArrayList<Obstacle>();
    score = 0;
    startTime = millis();
    lastUpdateTime = millis(); 
    lastSpawnTime = millis();
    soundPlayed = false;
    cooldown = 3000;
    changeState("play");
  }
  
  void changeState(String newState) {
    gameState = newState;
  }
}