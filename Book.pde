class Book {
  PImage cover;
  String coverUrl;
  
  
  Book (String coverUrl) {
    this.coverUrl = coverUrl;
    loadCover();
  }
  
  void loadCover () {
    this.cover = loadImage(this.coverUrl);
  }
  
  PImage getCover () {
    return this.cover;
  }
  
}