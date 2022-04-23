import 'package:flutter/material.dart';

class SimpleIcon extends StatelessWidget {
  const SimpleIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 45,
        height: 45,
        margin: const EdgeInsets.only(left: 10),
        child: Material(
          child: Ink(
            child: Icon(
              Icons.book,
              size: 20,
              color: Colors.amber.withOpacity(0.9),
            ),
            decoration: ShapeDecoration(
              color: Colors.amber.withOpacity(0.2),
              shape: const CircleBorder(),
            ),
          ),
        ));
  }
}
