import 'package:flutter/material.dart';
import 'package:flutter_course_it/src/widgets/animations/box_fade_and_slide.dart';

class AnimatedCollectionUI extends StatefulWidget{
  @override
  _AnimatedCollectionUIState createState() => _AnimatedCollectionUIState();
}

class _AnimatedCollectionUIState extends State<AnimatedCollectionUI> {
  bool _runAnimation;


  @override
  void initState() {
    super.initState();
    _runAnimation = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              MaterialButton(
                  elevation: 3.0,
                  height: 26.0,
                  minWidth: 80.0,
                  padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  color: Colors.yellow,
                  onPressed: () => _startAnimation(),
                  child: Text("Box Fade & Slide")
              ),
              BoxFadeAndSlide(runAnimation: _runAnimation)
            ],
          ),

        ],
      )
    );
  }

  _startAnimation() {
    setState(() {
      _runAnimation = true;
    });
  }
}