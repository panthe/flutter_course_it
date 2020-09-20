import 'package:flutter/material.dart';

class BoxFadeAndSlide extends StatefulWidget{
  final bool runAnimation;
  final Function callback;

  BoxFadeAndSlide({Key key, this.runAnimation = false, this.callback}): super(key: key);

  @override
  _BoxFadeAndSlideState createState() => _BoxFadeAndSlideState();
}

class _BoxFadeAndSlideState extends State<BoxFadeAndSlide> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation _fadeAnimation;
  Animation _slideAnimation;
  IconData _icon;

  @override
  void initState() {
    super.initState();
    _icon = Icons.forward;
    _initAnimationController();
    _initAnimation();
  }


  @override
  void didUpdateWidget(BoxFadeAndSlide oldWidget) {
    print('didUpdateWidget BoxFadeAndSlide');
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

  Widget build(context) {

    return SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0
                  ),
                ),
                child: Icon(
                  Icons.forward
                ),
              )
          ),
        )
    );
  }

  _initAnimationController() {
    _animationController = AnimationController(
        duration: Duration(seconds: 5),
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

  _initAnimation() {
    _fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5,0.0),
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticInOut
      )
    );
  }
}