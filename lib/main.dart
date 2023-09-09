import 'package:basic_bloc_notes_app/apis/login_api.dart';
import 'package:basic_bloc_notes_app/apis/notes_api.dart';
import 'package:basic_bloc_notes_app/bloc/action.dart';
import 'package:basic_bloc_notes_app/bloc/app_bloc.dart';
import 'package:basic_bloc_notes_app/bloc/app_state.dart';
import 'package:basic_bloc_notes_app/generic/generic_dailog.dart';
import 'package:basic_bloc_notes_app/generic/loading_screen.dart';
import 'package:basic_bloc_notes_app/models.dart';
import 'package:basic_bloc_notes_app/strings.dart';
import 'package:basic_bloc_notes_app/views/iterable_list_view.dart';
import 'package:basic_bloc_notes_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreenPage(),
    );
  }
}

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(homepage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          builder: (context, state) {
            final notes = state.fetchNotes;
            if (notes == null) {
              return LoginView(
                onLoginTappped: (email, password) {
                  
                  context
                      .read<AppBloc>()
                      .add(LoginAction(email: email, password: password));
                },
              );
            } else {
              return notes.toListView();
            }
          },
          listener: (context, state) {
            //  loading screen
            if (state.isLoading) {
              LoadingScreen.instance().show(context: context, text: pleaseWait);
            } else {
              LoadingScreen.instance().hide();
            }
            final loginError = state.loginErrors;
            if (loginError != null) {
              showGenericDialog(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuilder: () => {ok: true},
              );
            }
            if (state.isLoading == false &&
                state.loginErrors == null &&
                state.loginHandle == const LoginHandle.fooBar() &&
                state.fetchNotes == null) {
              context.read<AppBloc>().add(const LoadNotesAction());
            }
          },
        ),
      ),
    );
  }
}
