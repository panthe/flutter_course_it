import 'package:flutter/material.dart';
import 'package:flutter_course_it/src/widgets/animations/animated_container_example.dart';
import 'package:flutter_course_it/src/widgets/animations/box_fade_and_slide.dart';
import 'package:flutter_course_it/src/widgets/animations/lottie_example.dart';

class AnimatedCollectionUI extends StatefulWidget{
  @override
  _AnimatedCollectionUIState createState() => _AnimatedCollectionUIState();
}

class _AnimatedCollectionUIState extends State<AnimatedCollectionUI> {
  bool _runAnimationFadeAndSlide;
  bool _runAnimationAnimatedContainer;
  bool _runAnimationLottie;

  @override
  void initState() {
    super.initState();
    _runAnimationFadeAndSlide = false;
    _runAnimationAnimatedContainer = false;
    _runAnimationLottie = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            _rowAnimationFadeAndSlide(),
            _rowAnimationAnimatedContainer(),
            _rowAnimationLottie(),
          ],
        )
      )
    );
  }

  _rowAnimationFadeAndSlide() {
    return Container(
      height: 250.0,
      child: Row(
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
              onPressed: () => _animationFadeAndSlideStart(),
              child: Text("Box Fade & Slide")
          ),
          BoxFadeAndSlide(
            runAnimation: _runAnimationFadeAndSlide,
            callback: _animationFadeAndSlideCompleted,
          ),
        ],
      )
    );
  }

  _animationFadeAndSlideStart() {
    print('_animationFadeAndSlideStart');
    setState(() {
      _runAnimationFadeAndSlide = true;
    });
  }

  _animationFadeAndSlideCompleted() {
    print('_animationFadeAndSlideCompleted');
    setState(() {
      _runAnimationFadeAndSlide = false;
    });
  }

  _animationAnimatedContainerStart() {
    print('_animationAnimatedContainerStart');
    setState(() {
      _runAnimationAnimatedContainer = !_runAnimationAnimatedContainer;
    });
  }

  _rowAnimationAnimatedContainer() {
    return Container(
        height: 250.0,
        child: Row(
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
                onPressed: () => _animationAnimatedContainerStart(),
                child: Text("AnimatedContainer")
            ),
            AnimatedContainerExample(
              isGrowing: _runAnimationAnimatedContainer,
            )
          ],
        )
    );
  }

  _animationLottieStart() {
    print('_animationLottieStart');
    setState(() {
      _runAnimationLottie = true;
    });
  }

  _animationLottieCompleted() {
    print('_animationLottieCompleted');
    setState(() {
      _runAnimationLottie = false;
    });
  }

  _rowAnimationLottie() {
    return Container(
        height: 250.0,
        child: Row(
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
                onPressed: () => _animationLottieStart(),
                child: Text("Lottie")
            ),
            LottieExample(
              runAnimation: _runAnimationLottie,
              callback: _animationLottieCompleted,
            )
          ],
        )
    );
  }
}