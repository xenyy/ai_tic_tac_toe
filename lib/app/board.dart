import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_tic_tac_toe/common_widgets/action_buttons.dart';
import 'package:flutter_ai_tic_tac_toe/common_widgets/custom_dialog.dart';
import 'package:flutter_ai_tic_tac_toe/common_widgets/playing_board.dart';
import 'package:flutter_ai_tic_tac_toe/models/button.dart';
import 'package:flutter_ai_tic_tac_toe/routing/app_routes.dart';

class Board extends StatefulWidget {
  static const String routeName = '/';
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Button> _board;
  List<int> playerMoves = [];
  List<int> aiMoves = [];
  var whoPlays = true; //player always begin
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
    //reset board to its initial state
    setState(() {
      _board = start();
    });
    whoPlays = true;
    playerMoves.clear();
    aiMoves.clear();
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
    //Player moves
    if (whoPlays) {
      setState(() {
        item.text = playerChar;
        item.color = Colors.redAccent;
      });
      playerMoves.add(position);
      whoPlays = !whoPlays;
      item.active = false;
      if (checkWin(playerMoves)) {
        showDialog(
          context: context,
          builder: (_) => const CustomDialog(
            title: 'The human player won',
            content: 'The world is save now',
          ),
        ).then((value) => resetGame());
      } else {
        //If the player don't make a winner move let the AI play
        int move = aiMove();
        if (move != -1) {
          aiMoves.add(move);
          _board.asMap().forEach((key, value) {
            if (key == move) {
              setState(() {
                value.color = Colors.black;
                value.text = aiChar;
                value.active = false;
              });
            }
          });
        } else {
          showDialog(
            context: context,
            builder: (_) => const CustomDialog(
              title: 'None of us won',
              content: 'The battle will continue',
            ),
          ).then((value) => resetGame());
        }

        if (checkWin(aiMoves)) {
          showDialog(
            context: context,
            builder: (_) => const CustomDialog(
              title: 'The AI won',
              content: 'Humanity must surrender to the machines',
            ),
          ).then((value) => resetGame());
        }
        whoPlays = !whoPlays;
      }
    } else {
      print('Don\'t cheat it is AI turn');
    }
  }

  int aiMove() {
    //Ai moves
    if (!whoPlays) {
      //Get available positions
      List<int> _avMoves = [];
      _board.asMap().forEach((i, value) {
        if (!(playerMoves + aiMoves).contains(i)) {
          _avMoves.add(i);
        }
      });

      //check tie game
      if (_avMoves.isEmpty) {
        return -1;
      }

      ///If AI can do a move that makes it win takes that move
      //Adding [...List] spread the list and creates a copy so we don't mess the original moves list
      for (var i = 0; i <= _avMoves.length - 1; i++) {
        List<int> _winningAiMove = [...aiMoves];
        _winningAiMove.add(_avMoves[i]);
        if (checkWin(_winningAiMove)) {
          print('AI picks this move to win');
          return _avMoves[i];
        }
      }

      ///There is a move where the player can win? AI block user and takes that move
      for (var i = 0; i <= _avMoves.length - 1; i++) {
        List<int> _winningPlayerMove = [...playerMoves];
        _winningPlayerMove.add(_avMoves[i]);
        if (checkWin(_winningPlayerMove)) {
          print('AI picks this move to block user');
          return _avMoves[i];
        }
      }

      ///Neither of us can win so we will pick an available corner to move
      List<int> _avCorners = [];
      List<int> _corners = [0, 2, 6, 8];
      _avMoves.any((element) {
        if (_corners.contains(element)) {
          _avCorners.add(element);
        }
        return false;
      });
      if (_avCorners.length > 0) {
        print('Ai picks random corner available');
        return (_avCorners..shuffle()).first;
      }

      ///If there are no corners to move check if center is available
      if (_avMoves.contains(4)) {
        print('Ai picks center if available');
        return 4;
      }

      ///No center go to an available edge center
      List<int> _avEdgeCenters = [];
      List<int> _edgeCenters = [1, 3, 5, 7];
      _avMoves.any((element) {
        if (_edgeCenters.contains(element)) {
          _avEdgeCenters.add(element);
        }
        return false;
      });
      if (_avEdgeCenters.length > 0) {
        print('Ai picks random edge center available');
        return (_avEdgeCenters..shuffle()).first;
      }
    } else {
      print('Don\'t cheat it is users turn');
    }
    //No more possible moves the AI can think of
    print('I dont know what to do');
    return -1;
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
          ChangeGameFloatingButton(text: 'MP', route: AppRoutes.local),
          SizedBox(width: 10),
          ClearFloatingButton(onPress: () => resetGame()),
        ],
      ),
      appBar: AppBar(
        title: Text(
          'Tic tac toe Human VS AI',
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
        title: 'TRY TO BEAT ME',
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
