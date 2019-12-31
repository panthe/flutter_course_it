import 'package:redux/redux.dart';
import 'app/app_state.dart';
import 'app/app_reducer.dart';
import 'error/error_middleware.dart';
import 'message/message_middleware.dart';


Store<AppState> createStore() {
  return Store(
      appReducer,
      initialState: AppState.initial(),
      middleware: []
        ..add(createErrorMiddleware())
        ..add(createMessageMiddleware())

  );
}