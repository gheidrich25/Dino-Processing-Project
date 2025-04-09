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
    
  }

  void drawUI() {
    background(255);
    if (gameState.equals("start")) {
      fill(0);
      textAlign(CENTER);
      textSize(32);
      text("Dino Dash", width/2, 100);
      textSize(16);
      text("Click to Play (Medium / Hard)", width/2, 150);
      text("Instructions", width/2, 180);
      image(dinoIdle, width/2 - 50, 200);
    } else if (gameState.equals("instructions")) {
      fill(0);
      textAlign(LEFT);
      textSize(16);
      text("Controls:\n- Jump: Mouse Click\n- Duck: Down Arrow\n\nClick to return", 100, 100);
    } else if (gameState.equals("play")) {
      player.draw();
      text("Score: " + score, 10, 20);
    } else if (gameState.equals("gameover")) {
      fill(255,0,0);
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