import 'dart:convert';

List<Character> charactersFromJson(String str) =>
    List<Character>.from(json.decode(str).map((x) => Character.fromJson(x)));

String charactersToJson(List<Character> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Character {
  Character({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.title,
    required this.family,
    required this.image,
    required this.imageUrl,
  });

  int id;
  String firstName;
  String lastName;
  String fullName;
  String title;
  String family;
  String image;
  String imageUrl;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        title: json["title"],
        family: json["family"],
        image: json["image"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "title": title,
        "family": family,
        "image": image,
        "imageUrl": imageUrl,
      };
}
