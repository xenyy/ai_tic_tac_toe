import 'package:flutter/material.dart';
import 'package:flutter_ai_tic_tac_toe/routing/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Subscribe for more it\'s free',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Rubik'
      ),
      initialRoute: AppRoutes.board,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
