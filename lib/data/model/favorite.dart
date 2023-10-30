class Favorites {
  late String? id;
  late String name;
  late String pictureId;

  Favorites({this.id, required this.name, required this.pictureId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      "pictureId": pictureId
    };
  }

  Favorites.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    pictureId = map['pictureId'];
  }

}