import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String buttonText;
  IconData icon;
  RoundButton({
    Key? key,
    required this.buttonText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 95,
      child: Column(children: <Widget>[
        FloatingActionButton(
          heroTag: null,
          onPressed: () {},
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.black),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(buttonText,
              style: const TextStyle(color: Colors.grey, fontSize: 11)),
        )
      ]),
    );
  }
}
