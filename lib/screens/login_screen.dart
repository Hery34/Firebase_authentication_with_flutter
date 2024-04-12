import 'package:firebase_test/forms/login_form.dart';
import 'package:firebase_test/scaffolds/main_scaffold.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(title: 'Connexion', body: LoginForm());
  }
}
