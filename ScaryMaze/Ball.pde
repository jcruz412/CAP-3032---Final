class Ball {
  float x, y;
  float initX, initY, initAngle;
  float radius;
  float speed;
  float angle;
  float xVel, yVel;
  int timer;

  Ball(float x, float y, float r, float speed, float angle) {
    this.initX = x;
    this.initY = y;
    this.initAngle = angle;
    this.x = x;
    this.y = y;
    this.radius = r;
    this.speed = speed;
    this.angle = angle;
    this.timer = 0;
  }

  // Updates the ball's position
  void update() {
    // Position update 
    x += speed*cos(radians(angle));
    y += speed*sin(radians(angle));
    angle = angle%360;     // To keep the angle calcs consistent

    // Wall collisions
    if ((x + radius >=  width || x - radius <= 0 || y - radius <= 0) && timer == 0) {
      wallCollide();
    }

    // Bottom pit / Losing condition
    if (y >= height) {
      lose = true;
      losePlay = true;
    }
    
    // Ball touches mouse
    if (dist(mouseX, mouseY, x, y) < radius - 3) {
      lose = true;
      losePlay = true;
    }

    if (timer > 0) {
      timer--;
    }
  }

  // Changes its angle when the ball collides with wall
  void wallCollide() {
    // Timer used to prevent multiple collisions with the wall
    timer = 2;
    // Side Walls
    if (x + radius >=  width || x - radius <= 0) {
      float angleOffY;
      if (angle >= 0 && angle <= 180) {
        angleOffY = angle - 90;
      } else {
        angleOffY = angle - 270;
      }
      angle -= 2*angleOffY;
    }
    // Top Wall
    if (y - radius <= 0) {
      float angleOffX = angle - 180;
      if (angleOffX < 0)
        angle += 2*angleOffX;
      else
        angle -= 2*angleOffX;
    }
  }

  // Display the ball
  void show() {
    ellipse(this.x, this.y, radius*2, radius*2);
  }

  // Reset the ball to initial position
  void reset() {
    this.x = initX;
    this.y = initY;
    this.angle = initAngle;
  }
}
