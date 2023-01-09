import 'package:bloc_test/presentation/screens/home_screen.dart';
import 'package:bloc_test/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: ((context) => MyHomePage(
                  title: "Home Screen",
                  color: Colors.blueAccent,
                )));
      case "/secondscreen":
        return MaterialPageRoute(
            builder: ((context) => SecondScreen(
                  title: "Second Screen",
                  color: Colors.orange,
                )));

      default:
        return null;
    }
  }
}
