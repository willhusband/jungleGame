class Entry //used when working out the leaderboard
{
  String name;
  int score;
  Entry(int score,String name)
  {
    this.name = name;
    this.score = score; //used a class in order to ensure name and score are kept together when calculating order of scores
  }
}
