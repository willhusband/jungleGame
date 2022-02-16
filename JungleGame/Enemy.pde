abstract class Enemy extends Animal
{
  int value; //how many points are recieved for killing enemy
  Enemy(int x, int y, int dx, int dy, int lives, int size, int delay, int value)
  {
    super(x,y,dx,dy,lives,size,delay);
    this.value = value;
  }
}
