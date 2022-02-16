abstract class Animal
{
  int x; //determines x position
  int y; //determines  position
  int dx; //speed in x direction
  int dy; //speed in y direction
  int lives; //numbe of times object can be hit by other objects
  int size; //size = w = h
  int delay; //how long until another can spawn, every(x/60) seconds, so 60 would be 1 every second (unless framerate is changed, 60 is default)
  int imgCount; //used to determine when to change image
  int currentImg = 0; //used to determine which image is currrently being used
  PImage[] sprites = new PImage[7]; //array of images
  
  Animal(int x, int y, int dx, int dy, int lives, int size, int delay) //constructor
  {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.lives = lives;
    this.size = size;
    this.delay = delay;
    
    
    for (int i = 0; i < sprites.length; i++)
    {
      sprites[i] = loadImage("default.png"); //populating array with default images
    }
    sprites[6] = loadImage("defaultCrash.png"); //sprites[6] holds the crash sequence image for every subclass of animal
  }
  
  boolean crash(Animal other) //returns true if 2 objects collide
  {
    return (abs(this.x - other.x)<(this.size/2 + other.size/2) && abs(this.y - other.y) < (this.size/2 + other.size/2)); //calculates distance between objects
  }
  
  void render()
  {
    imageMode(CENTER); //turns the x,y value from top right to the middle
      
    for (int i = 0; i < sprites.length; i++)
    {
      sprites[i].resize(size, size); //resizes all the images in sprites array being used depending on size variable 
    }
    
    for (int j = 0; j < sprites.length; j++)
    {
      if (currentImg == j)
      {
        image(sprites[j], x, y); //renders different images depending on the value of currentImg
      }
    }
  }
  
  void crashImage() //this needs to be seperate from render otherwise the object will be off screen before crash image is shown
  {
    imageMode(CENTER);
    sprites[6].resize(size, size);
    image(sprites[6], x, y); //renders crash sequence image
  }
  
  abstract void move(); //abstract since each subclass moves differently
  
  void update()
  {
      move();
      render(); //render always last in update method
  }
}
