class Paddle {
  float x, y;
  float l, h; // length and height
  float speed;
  
  Paddle(float l, float speed) {
    this.x = width/2;
    this.y =  height - 30;
    this.h = 20;
    this.l = l;
    this.speed = speed;
  }
  
  // Updates position of paddle when player presses "A" or "D"
  // Also updates ball position on collision
  void update(Ball b) {
    if (left && x - l/2 >= 0) {
      x -= speed;
    }
    if (right && x + l/2 <= width) {
      x += speed;
    }
    // If the player hits the paddle
    if (b.x + b.radius >= x - l/2 && b.x - b.radius <= x + l/2 && b.y + b.radius >= y ) {
      this.collide(b);
    }
  }
  
  // Display paddle
  void show() {
    rect(x - l/2, y, l, h);
  }
  
  // Resets paddle position to its starting position
  void reset() {
    this.x = width/2;
  }
  
  // Changes the ball's angle depending on where the ball hit the paddle
  void collide(Ball b) {
    bump.play();
    // Calculate what part of the paddle the ball hits
    float collidePosition = map(b.x - (x - l/2), 0, l, 0, 1);
    b.angle = map(collidePosition, 0, 1, 225, 315);
  }
}
