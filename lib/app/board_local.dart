import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_tic_tac_toe/common_widgets/action_buttons.dart';
import 'package:flutter_ai_tic_tac_toe/common_widgets/custom_dialog.dart';
import 'package:flutter_ai_tic_tac_toe/common_widgets/playing_board.dart';
import 'package:flutter_ai_tic_tac_toe/models/button.dart';
import 'package:flutter_ai_tic_tac_toe/routing/app_routes.dart';

class BoardLocal extends StatefulWidget {
  static const String routeName = '/local';
  @override
  _BoardLocalState createState() => _BoardLocalState();
}

class _BoardLocalState extends State<BoardLocal> {
  List<Button> _board;

  List<int> player1Moves = [];
  List<int> player2Moves = [];
  var whoPlays = true; //player1 always begin
  String playerChar = 'X', aiChar = 'O';

  List<Button> start() {
    return [
      Button(),
      Button(),
      Button(),
      Button(),
      Button(),
      Button(),
      Button(),
      Button(),
      Button(),
    ];
  }

  void resetGame() {
    //reset board to its initial state to play again
   setState(() {
     _board = start();
   });
   whoPlays = true;
   player1Moves.clear();
    player2Moves.clear();
  }

  bool checkWin(List<int> moves) {
    //All the winning possibilities :D
    if (moves.contains(0) && moves.contains(1) && moves.contains(2)) {
      return true;
    } else if (moves.contains(3) && moves.contains(4) && moves.contains(5)) {
      return true;
    } else if (moves.contains(6) && moves.contains(7) && moves.contains(8)) {
      return true;
    } else if (moves.contains(0) && moves.contains(3) && moves.contains(6)) {
      return true;
    } else if (moves.contains(1) && moves.contains(4) && moves.contains(7)) {
      return true;
    } else if (moves.contains(2) && moves.contains(5) && moves.contains(8)) {
      return true;
    } else if (moves.contains(0) && moves.contains(4) && moves.contains(8)) {
      return true;
    } else if (moves.contains(2) && moves.contains(4) && moves.contains(6)) {
      return true;
    } else {
      return false;
    }
  }

  void playMove(Button item, int position) {
    if (whoPlays) {
      setState(() {
        item.text = playerChar;
        item.color = Colors.redAccent;
      });
      player1Moves.add(position);
      if (checkWin(player1Moves)) {
        showDialog(
          context: context,
          builder: (_) => const CustomDialog(title: 'Player X won', content: ''),
        ).then((value) => resetGame());
      }
    } else {
      setState(() {
        item.text = aiChar;
        item.color = Colors.black;
      });
      player2Moves.add(position);
      if (checkWin(player2Moves)) {
        showDialog(
          context: context,
          builder: (_) => const CustomDialog(title: 'Player O won', content: ''),
        ).then((value) => resetGame());
      }
    }

    //check if tie
    if (player1Moves.length + player2Moves.length == 9) {
      showDialog(
        context: context,
        builder: (_) => const CustomDialog(title: 'Tie nobody won', content: ''),
      ).then((value) => resetGame());
      
    }

    whoPlays = !whoPlays;
    item.active = false;
  }

  @override
  void initState() {
    super.initState();
    _board = start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ChangeGameFloatingButton(text: 'AI', route: AppRoutes.board),
          SizedBox(width: 10),
          ClearFloatingButton(onPress: () => resetGame()),
        ],
      ),
      appBar: AppBar(
        title: Text(
          'Tic tac toe Human VS Human',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline_rounded),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.about);
            },
          ),
        ],
      ),
      body: PlayingBoard(
        board: _board,
        title: 'DON\'T PLAY DIRTY',
        itemBuilder: (context, i) {
          return GestureDetector(
            ///Here we are checking if the button is available or was already chosen
            onTap: () => _board[i].active ? playMove(_board[i], i) : null,
            child: Container(
              color: _board[i].color,
              height: 100,
              width: 100,
              child: Center(
                child: Text(
                  _board[i].text,
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

