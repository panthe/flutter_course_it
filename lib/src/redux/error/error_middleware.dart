import 'package:flutter/material.dart';
import 'package:flutter_course_it/src/lang/localization.dart';
import 'package:redux/redux.dart';
import '../app/app_state.dart';
import 'error_actions.dart';

Middleware<AppState> createErrorMiddleware() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    BuildContext context = store.state.errorState.context;
    if (action is ShowError) {

      String msg = "";
      try {
        msg = Localization.of(context).trans(action.errorDescription);
      } catch (e) {
        msg = action.errorDescription;
      }
     Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content:new Text(msg),
            duration: Duration(minutes: 1),
            action: new SnackBarAction(
              textColor: Colors.black,
              label: "OK",
              onPressed: () => store.dispatch(DismissError()),
            ),
          )
      );
    }

    if (action is DismissError){
      Scaffold.of(context).hideCurrentSnackBar();
    }

    next(action);
  };
}