//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myweather/pages/choose_location.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {"/": (context) => ChooseLocation()});
  }
}
