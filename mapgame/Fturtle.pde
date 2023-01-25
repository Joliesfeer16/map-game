class Fturtle extends FGoomba {
  
  int direction = L;
  int speed     = 50;

  Fturtle(float x, float y) {
    super(x, y);
    setPosition(x, y);
    setName("turtle");
    setRotatable(false);
  }

  void act() {
    animatedd();
    collide();
    move();
  }
  void animatedd() {
    if (frame>= turtle.length) frame=0;
    if (frameCount % 5 ==0) {
      if (direction == R) attachImage(turtle[frame]);
      if (direction == L) attachImage(reverseImage(turtle[frame]));
      frame++;
    }
  }

  void collide() {
     if (isTouching("walls")) {
      direction *= -1;
      setPosition(getX() +direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY()< getY()- gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);//makes it jump
      } else {
        lives--;//fix this
        player.setPosition(380, 800);
      }
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
