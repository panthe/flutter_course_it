import 'package:flutter/material.dart';
import 'package:flutter_course_it/src/config/routes.dart';
import 'package:flutter_course_it/src/widgets/common/go_to_button.dart';

class HomeUI extends StatefulWidget{

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  ScrollController _scrollController;

  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent
      && !_scrollController.position.outOfRange) {
      print("${_scrollController.debugLabel} - Reach the bottom");
    }
    if (_scrollController.offset <= _scrollController.position.minScrollExtent
      && !_scrollController.position.outOfRange) {
      print("${_scrollController.debugLabel} - Reach the top");
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
      debugLabel: "HomePageScrollController"
    );
    _scrollController.addListener(_scrollListener);
  }


  @override
  void dispose() {
    super.dispose();
  }

  Widget build(context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GoToButton(
            title: "Animazioni",
            route: AnimatedCollectionRoute,
            height: 30.0,
            minWidth: 80.0,
          )
        ],
      ),
    );
  }

}