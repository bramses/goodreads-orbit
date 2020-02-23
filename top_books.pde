PImage centerImg;
Book[] fiveStarBooks = new Book[10];
Book[] fourStarBooks = new Book[10];
Book[] threeStarBooks = new Book[10];
Book[] twoStarBooks = new Book[10];
Book[] oneStarBooks = new Book[10];
Book rich;

void bookCircle (Book[] books, float radius, int dir) {
  float FRAME_COUNTER = frameCount * 0.001 * dir;
  
  float angle = 360 / books.length;
  for (int i = 0; i < books.length; i++) {
     float x = cos(radians(angle * i) + FRAME_COUNTER) * radius;
     float y = sin(radians(angle * i) + FRAME_COUNTER) * radius;
     
     image(rich.getCover(), x, y);
  }
}

void setup () {
  imageMode(CENTER);
  size(900, 900);
  background(0);
  noStroke();
  rich = new Book("richest-man-cover.jpg");

}

void draw () {
  background(0);
  centerImg = loadImage("books_centerimg.jpg");
  centerImg.resize(100, 150);
  translate(width / 2, height / 2);
  image(centerImg, 0, 0);
  bookCircle(fiveStarBooks, 120, 1);
  bookCircle(fourStarBooks, 180, -1);
  bookCircle(threeStarBooks, 240, 1);
  bookCircle(twoStarBooks, 300, -1);
  bookCircle(oneStarBooks, 360, 1);
}