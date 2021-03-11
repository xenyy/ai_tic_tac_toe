import 'package:flutter/material.dart';

class ClearFloatingButton extends StatelessWidget {
  const ClearFloatingButton({
    Key key,
    @required this.onPress,
  }) : super(key: key);

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.amberAccent,
      splashColor: Colors.white,
      icon: Icon(Icons.clear),
      label: Text('Clear'),
      elevation: 0.0,
      highlightElevation: 0.0,
      heroTag: 2,
      onPressed: onPress,
    );
  }
}

class ChangeGameFloatingButton extends StatelessWidget {
  const ChangeGameFloatingButton({
    Key key, @required this.text,  @required this.route,
  }) : super(key: key);

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amberAccent,
      splashColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      elevation: 0.0,
      highlightElevation: 0.0,
      heroTag: 1,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
      },
    );
  }
}
