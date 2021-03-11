import 'package:flutter/material.dart';


class Scores extends StatelessWidget {
  static const String routeName = '/scores' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scores table'),
      ),
    );
  }
}
