import 'package:flutter/foundation.dart';

import 'package:basic_bloc_notes_app/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginErrors;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchNotes;

  const AppState.empty()
      : isLoading = false,
        loginErrors = null,
        loginHandle = null,
        fetchNotes = null;

  const AppState({
    required this.isLoading,
    required this.loginErrors,
    required this.loginHandle,
    required this.fetchNotes,
  });

  @override
  String toString() => {
        'isLoding': isLoading,
        'loginError': loginErrors,
        'loginHandle': loginHandle,
        'fetchNotes': fetchNotes,
      }.toString();
}
