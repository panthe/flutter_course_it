import 'package:flutter/material.dart';

class GoToButton extends StatelessWidget {
  final String title;
  final String route;
  final double height;
  final double minWidth;


  GoToButton({
    @required this.title,
    @required this.route,
    this.height,
    this.minWidth
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 3.0,
      height: height,
      minWidth: minWidth,
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      color: Colors.yellow,
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(title)
    );
  }
}