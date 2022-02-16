class Player extends Animal
{
  boolean shot = false;
  int originalLiveCount;
  
  Player(int x, int y, int dx, int dy, int lives, int size, int delay)
  {
    super(x,y,dx,dy,lives,size,delay);
    
    originalLiveCount = lives;
    
    sprites[0] = loadImage("monkeyChill.png");
    sprites[1] = loadImage("monkeyRight1.png");
    sprites[2] = loadImage("monkeyLeft.png");
    sprites[3] = loadImage("monkeyThrow2.png");
    
    sprites[6] = loadImage("monkeyCrash.png");
  }
  
  @Override
  void move()
  {
    currentImg = 0;
    if(keyPressed == true) //if this wasnt here a key press would be repeated until another, rather than until released
    {
      if (keyCode == RIGHT)
      {
       currentImg = 1;   //changes the images when player is moving / shooting
        x = x + dx;
      }
      if(keyCode == LEFT)
      {
        currentImg = 2;
        x = x - dx;
      }
      if (keyCode == DOWN)
      {
        currentImg = 3;
        shot = true; //drops rock
      }
    }
    else
    {
      shot = false; //returns shot to false after it has been pressed
    }
  }
}
