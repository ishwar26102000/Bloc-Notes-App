// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:basic_bloc_notes_app/strings.dart' show enterYourEmaillHere;
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailTextField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: enterYourEmaillHere,
      ),
    );
  }
}
