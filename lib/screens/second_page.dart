import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondPageArguments {
  final String title;
  final String message;

  SecondPageArguments(this.title, this.message);
}

class SecondPage extends StatefulWidget {
  static const String routeName = '/second';

  String title;
  String? message;

  SecondPage({Key? key, required this.title, this.message}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Character> _characters = [];

  void _getData() async {
    http
        .get(Uri.parse("https://thronesapi.com/api/v2/Characters"))
        .then((response) {
      setState(() {
        _characters = charactersFromJson(response.body);
      });
    });
  }

  Future<List<Character>> _getDataFuture() async {
    return http
        .get(Uri.parse("https://thronesapi.com/api/v2/Characters"))
        .then((response) {
      return charactersFromJson(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    String msg = widget.message ?? 'No message';
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 32),
            ),
            Text("Ejemplo con lista manual"),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              height: 200,
              child: ListView.builder(
                  itemCount: _characters.length,
                  itemBuilder: (BuildContext context, int index) {
                    Character character = _characters[index];

                    return Card(
                      child: Row(
                        children: [
                          Image(
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            image: NetworkImage(character.imageUrl),
                          ),
                          Container(
                            width: 250,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(character.fullName),
                                const Padding(padding: EdgeInsets.only(top: 8)),
                                Text(character.family),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("Ejemplo con FutureBuilder"),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              height: 200,
              child: FutureBuilder<List<Character>>(
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("ERROR!!!");
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          Character? character = snapshot.data?[index] ??
                              Character(
                                  id: 1,
                                  firstName: "firstName",
                                  lastName: "lastName",
                                  fullName: "fullName",
                                  title: "title",
                                  family: "family",
                                  image: "image",
                                  imageUrl: "imageUrl");

                          return Card(
                            child: Row(
                              children: [
                                Image(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(character.imageUrl),
                                ),
                                Container(
                                  width: 250,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(character.fullName),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 8)),
                                      Text(character.family),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                  return const CircularProgressIndicator();
                },
                future: _getDataFuture(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Volver - " + msg)),
          ],
        ),
      ),
    );
  }
}

// Generated with https://app.quicktype.io/

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
