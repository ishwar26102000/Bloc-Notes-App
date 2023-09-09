// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:basic_bloc_notes_app/generic/generic_dailog.dart';
import 'package:basic_bloc_notes_app/strings.dart'
    show
        emailAndPasswordEmptyDecription,
        emailAndPasswordEmptyDiaogTitle,
        login,
        ok;
import 'package:flutter/material.dart';

typedef OnLoginTappped = void Function(
  String email,
  String password,
);

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTappped onLoginTappped;
  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTappped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;
        
        if (email.isEmpty || password.isEmpty) {
          showGenericDialog<bool>(
            context: context,
            title: emailAndPasswordEmptyDiaogTitle,
            content: emailAndPasswordEmptyDecription,
            optionBuilder: () {
              return {
                ok: true,
              };
            },
          );
        } else {
          onLoginTappped(email, password);
        }
      },
      child: const Text(login),
    );
  }
}
