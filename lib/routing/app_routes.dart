import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_tic_tac_toe/app/about.dart';
import 'package:flutter_ai_tic_tac_toe/app/board.dart';
import 'package:flutter_ai_tic_tac_toe/app/board_local.dart';
import 'package:flutter_ai_tic_tac_toe/app/scores.dart';

class AppRoutes {
  static const board = Board.routeName;
  static const local = BoardLocal.routeName;
  static const scores = Scores.routeName;
  static const about = About.routeName;

}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.board:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => Board(),
        );
      case AppRoutes.local:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => BoardLocal(),
        );
      case AppRoutes.scores:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => Scores(),
        );
      case AppRoutes.about:
        return MaterialPageRoute<dynamic>(
          builder: (_) => About(),
        );

      default:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => DefaultNoPage(),
        );
    }
  }
}

class DefaultNoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('404 PAGE DON\'T EXISTS'),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                //Go to page 3
                Navigator.pop(context);
              },
              child: Text('Go back'),
            )
          ],
        ),
      ),
    );
  }
}
