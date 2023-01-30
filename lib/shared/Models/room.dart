class Room {
  static const collectionRoomName = "rooms";

  String id;
  String name;
  String dsec;
  String catId;

  Room(
      {required this.id,
      required this.name,
      required this.dsec,
      required this.catId});

  Room.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          dsec: json['dsec'] as String,
          catId: json['catId'] as String,
        );

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "dsec": dsec, "catId": catId};
  }
}
