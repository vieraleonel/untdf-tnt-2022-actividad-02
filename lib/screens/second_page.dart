import 'package:flutter/material.dart';

class SecondPageArguments {
  final String title;
  final String message;

  SecondPageArguments(this.title, this.message);
}

class SecondPage extends StatelessWidget {
  static const String routeName = '/second';

  String title;
  String? message;

  SecondPage({Key? key, required this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg = message ?? 'No message';
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 32),
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
