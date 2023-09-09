import 'package:basic_bloc_notes_app/views/emal_text_field.dart';
import 'package:basic_bloc_notes_app/views/login_button.dart';
import 'package:basic_bloc_notes_app/views/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  final OnLoginTappped onLoginTappped;

  const LoginView({
    super.key,
    required this.onLoginTappped,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(emailController: emailController),
          PasswordTextField(passwordController: passwordController),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
            onLoginTappped: onLoginTappped,
          ),
        ],
      ),
    );
  }
}
