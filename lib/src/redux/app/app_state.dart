import 'package:meta/meta.dart';
import '../error/error_state.dart';
import '../message/message_state.dart';

@immutable
class AppState {
  final ErrorState errorState;
  final MessageState messageState;

  AppState({
    this.errorState,
    this.messageState,
  });

  factory AppState.initial() {
    return AppState(
      errorState: ErrorState.initial(),
      messageState: MessageState.initial(),
    );
  }

  AppState copyWith({
    ErrorState errorState,
    MessageState messageState,
  }) {
    return AppState(
      errorState: errorState ?? this.errorState,
      messageState: messageState ?? this.messageState,
    );
  }
}