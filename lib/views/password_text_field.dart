// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:basic_bloc_notes_app/strings.dart' show enterYourPasswordHere;
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      obscureText: true,
      // obscuringCharacter: '🕥',
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),
    );
  }
}
