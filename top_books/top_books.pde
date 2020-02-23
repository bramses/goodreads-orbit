// brain icon :: Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
PImage centerImg;
ArrayList fiveStarBooks = new ArrayList<Book>();
ArrayList fourStarBooks = new ArrayList<Book>();
ArrayList threeStarBooks = new ArrayList<Book>();
ArrayList twoStarBooks = new ArrayList<Book>();

void bookCircle (ArrayList<Book> books, float radius, int dir) {
  float FRAME_COUNTER = frameCount * 0.006 * dir;
  
  float angle = 360 / books.size();
  for (int i = 0; i < books.size(); i++) {
     float x = cos(radians(angle * i) + FRAME_COUNTER) * radius;
     float y = sin(radians(angle * i) + FRAME_COUNTER) * radius;
     Book book = books.get(i);
     image(book.getCover(), x, y);
  }
}

void setup () {
  imageMode(CENTER);
  size(900, 900);
  background(0);
  noStroke();

  
  String path = sketchPath();
  String[] filenames = listFileNames(path + "/data");
  sortByRating(filenames);
}

void sortByRating(String[] filenames) {
  for (String filename : filenames) {
    char rating = filename.charAt(filename.length() - 1);
    if (rating == '5') {
      fiveStarBooks.add(new Book(filename));
    }
    else if (rating == '4') {
      fourStarBooks.add(new Book(filename));
    }
    else if (rating == '3') {
      threeStarBooks.add(new Book(filename));
    }
    else if (rating == '2') {
      twoStarBooks.add(new Book(filename));
    }
  }
}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void draw () {
  background(0);
  centerImg = loadImage("brain.png");
  centerImg.resize(100, 100);
  translate(width / 2, height / 2 - 50);
  image(centerImg, 0, 0);
  bookCircle(fiveStarBooks, 140, 1);
  bookCircle(fourStarBooks, 220, -1);
  bookCircle(threeStarBooks, 300, 1);
  bookCircle(twoStarBooks, 380, -1);
  saveFrame();
}