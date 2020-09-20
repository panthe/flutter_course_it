import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieExample extends StatefulWidget {
  final bool runAnimation;
  final Function callback;

  LottieExample({Key key, this.runAnimation = false, this.callback}): super(key: key);

  @override
  _LottieExampleState createState() => _LottieExampleState();
}

class _LottieExampleState extends State<LottieExample> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }


  @override
  void didUpdateWidget(LottieExample oldWidget) {
    print('didUpdateWidget LottieExample');
    super.didUpdateWidget(oldWidget);
    if (widget.runAnimation) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150.0,
        child: Lottie.asset(
            'assets/anim/twitter_animated_icon.json',
            controller: _animationController,
            onLoaded: (composition) {
              _animationController
                ..duration = composition.duration;
            }
        ),
      )
    );
  }

  _initAnimationController() {
    _animationController = AnimationController(
        vsync: this
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("Animation Completed");
          widget.callback();
          _animationController.reset();
        }
      });
  }
}