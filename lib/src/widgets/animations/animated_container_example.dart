import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  final bool isGrowing;

  AnimatedContainerExample({this.isGrowing});

  @override
  _AnimatedContainerExampleState createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isGrowing;

  @override
  void initState() {
    super.initState();
    _isGrowing = widget.isGrowing;
  }

  @override
  void didUpdateWidget(AnimatedContainerExample oldWidget) {
    print('didUpdateWidget AnimatedContainerExample');
    super.didUpdateWidget(oldWidget);
    if (_isGrowing != widget.isGrowing) {
      setState(() {
        _isGrowing = widget.isGrowing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(left:25.0),
      width: _isGrowing ? 50.0 : 150.0,
      child: Image.asset("assets/img/earth2.png"),
      duration: Duration(seconds: 2),
      curve: Curves.easeInOutCirc,
    );

  }
}