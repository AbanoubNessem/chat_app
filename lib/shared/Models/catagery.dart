class Categery {
  static String sportsId = "sports";
  static String musicId = "music";
  static String moviesId = "movies";

  String id;
  late String name;
  late String image;

  Categery(this.name, this.id, this.image);

  Categery.fromId(this.id) {
    name = "$id";
    image = "assets/images/$id.png";
  }

  static List<Categery> getCategeries() {
    return [
      Categery.fromId(sportsId),
      Categery.fromId(moviesId),
      Categery.fromId(musicId),
    ];
  }
}
