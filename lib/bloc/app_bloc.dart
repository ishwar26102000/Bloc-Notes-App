// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:basic_bloc_notes_app/models.dart';
import 'package:bloc/bloc.dart';

import 'package:basic_bloc_notes_app/apis/login_api.dart';
import 'package:basic_bloc_notes_app/apis/notes_api.dart';
import 'package:basic_bloc_notes_app/bloc/action.dart';
import 'package:basic_bloc_notes_app/bloc/app_state.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocall loginApi;
  final NotesApiProtocall notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: null,
          fetchNotes: null,
        ),
      );

      final loginHandle =
          await loginApi.login(email: event.email, password: event.password);

      emit(
        AppState(
          isLoading: false,
          loginErrors: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchNotes: null,
        ),
      );
    });

    on<LoadNotesAction>((event, emit) async {
      emit(
        AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: state.loginHandle,
          fetchNotes: null,
        ),
      );

      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.fooBar()) {
        /// invalid login error , cannot fetch notes
        emit(
          AppState(
            isLoading: true,
            loginErrors: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchNotes: null,
          ),
        );
        return;
      } else {
        // this is a valid login handle
        final notes = await notesApi.getNotes(loginHandle: loginHandle!);
        emit(
          AppState(
            isLoading: false,
            loginErrors: null,
            loginHandle: loginHandle,
            fetchNotes: notes,
          ),
        );
      }
    });
  }
}
