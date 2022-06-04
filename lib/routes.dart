import 'dart:developer';

import 'package:ejemplo/screens/characters_page.dart';
import 'package:ejemplo/screens/my_home_page.dart';
import 'package:ejemplo/screens/second_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String second = '/second';
  static const String characters = '/characters';
}

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(
          builder: (_) => const MyHomePage(), settings: settings);

    case Routes.second:
      final SecondPageArguments args =
          settings.arguments as SecondPageArguments;
      return MaterialPageRoute(
          builder: (_) => SecondPage(
                title: args.title,
                message: args.message,
              ),
          settings: settings);

    case Routes.characters:
      return MaterialPageRoute(
          builder: (_) => CharactersPage(), settings: settings);

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Text("404"),
              ),
          settings: settings);
  }
}
