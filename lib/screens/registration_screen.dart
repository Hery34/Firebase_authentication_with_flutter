import 'package:firebase_test/forms/registration_form.dart';
import 'package:firebase_test/scaffolds/main_scaffold.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(title: 'Registration', body: RegistrationForm());
  }
}
