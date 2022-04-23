import 'package:ejemplo/widgets/simple_icon.dart';
import 'package:flutter/material.dart';

class CardRowItem extends StatelessWidget {
  const CardRowItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: Size.infinite.width,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(children: [
          const SimpleIcon(),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "EntryWay",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "1 light on",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ]),
          ),
          const Spacer(),
          Switch(value: true, onChanged: (newValue) {}),
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.chevron_right,
                size: 30,
              ))
        ]));
  }
}
