import 'package:flutter/material.dart';

class AppBar extends StatefulWidget {
  const AppBar({super.key, required MaterialAccentColor backgroundColor, required bool centerTitle, required Text title});

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child:  AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text('Home Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
