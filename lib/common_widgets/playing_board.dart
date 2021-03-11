import 'package:flutter/material.dart';
import 'package:flutter_ai_tic_tac_toe/models/button.dart';

class PlayingBoard extends StatelessWidget {
  const PlayingBoard({
    Key key,
    @required List<Button> board,
    @required this.title,
    @required this.itemBuilder,
  })  : _board = board,
        super(key: key);

  final List<Button> _board;
  final String title;
  final Function itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 90,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _board.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: itemBuilder,
          ),
        ],
      ),
    );
  }
}
