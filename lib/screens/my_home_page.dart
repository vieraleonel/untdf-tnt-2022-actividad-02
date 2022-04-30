import 'package:ejemplo/routes.dart';
import 'package:ejemplo/screens/second_page.dart';
import 'package:ejemplo/widgets/card_row_item.dart';
import 'package:ejemplo/widgets/round_button.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  static const String routeName = '/';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.white,
              Colors.grey.shade100,
              Colors.grey.shade300,
            ],
                stops: const [
              0,
              0.5,
              .8
            ])),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 105)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "My Home",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Icon(
                    Icons.arrow_downward,
                    size: 30,
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundButton(
                  buttonText: "Add Smart Bulb",
                  icon: Icons.lightbulb_outline,
                ),
                RoundButton(
                  buttonText: "Add",
                  icon: Icons.add,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.second,
                          arguments: SecondPageArguments(
                              "Game of Thrones Characters", ""));
                    },
                    child: Text("BTN")),
              ],
            ),
            const Spacer(),
            Container(
              width: Size.infinite.width,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                "Your Groups",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const CardRowItem(),
            const CardRowItem(),
            const CardRowItem(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(child: MyBottomAppBarr()),
    );
  }
}

class MyBottomAppBarr extends StatefulWidget {
  const MyBottomAppBarr({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomAppBarr> createState() => _MyBottomAppBarrState();
}

class _MyBottomAppBarrState extends State<MyBottomAppBarr> {
  int index = 0;

  _setIndex(int index) => () {
        setState(() {
          this.index = index;
        });
      };

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.add_alarm,
                  size: 30, color: index == 0 ? Colors.blue : Colors.grey),
              onPressed: _setIndex(0),
            ),
            IconButton(
              icon: Icon(Icons.add_alarm,
                  size: 30, color: index == 1 ? Colors.blue : Colors.grey),
              onPressed: _setIndex(1),
            ),
            IconButton(
              icon: Icon(Icons.add_alarm,
                  size: 30, color: index == 2 ? Colors.blue : Colors.grey),
              onPressed: _setIndex(2),
            ),
            IconButton(
              icon: Icon(Icons.add_alarm,
                  size: 30, color: index == 3 ? Colors.blue : Colors.grey),
              onPressed: _setIndex(3),
            ),
            IconButton(
              icon: Icon(Icons.add_alarm,
                  size: 30, color: index == 4 ? Colors.blue : Colors.grey),
              onPressed: _setIndex(4),
            ),
          ],
        ));
  }
}
