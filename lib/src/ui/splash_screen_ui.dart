import 'package:flutter/material.dart';

class SplashScreenUI extends StatefulWidget{

  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> with SingleTickerProviderStateMixin{
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this
    )
    ..forward()
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('splash'));
      }
    });
    /*
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('splash'))
    );
     */
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget build(context) {
    print("Build");
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        String seconds = _animationController.lastElapsedDuration?.inSeconds?.toString();
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  "assets/img/splash_img.png"
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Center(
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    seconds == null ? "" : seconds,
                    style: TextStyle(
                      fontSize: 68,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.black,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    seconds == null ? "" : seconds,
                    style: TextStyle(
                      fontSize: 68,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            )
        );
      }
    );
  }


}