import 'package:basic_bloc_notes_app/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NotesApiProtocall {
  const NotesApiProtocall();

  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle});
}

@immutable
class NotesApi implements NotesApiProtocall {
  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null,
      );
}
