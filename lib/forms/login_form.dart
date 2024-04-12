import 'package:firebase_test/screens/firebase_dashboard_screen.dart';
import 'package:firebase_test/screens/registration_screen.dart';
import 'package:firebase_test/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  bool _obscureText = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: TextFormField(
              controller: emailController,
              autocorrect: false,
              validator: (input) {
                if (input!.isEmpty) {
                  return 'Enter a valid email address';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(input)) {
                  return "The email address format is not valid";
                }
                return null;
              },
              onSaved: (input) => emailController.text = input!,
              decoration: const InputDecoration(
                hintText: 'your email adress',
                filled: true,
                fillColor: Colors.grey,
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: TextFormField(
              controller: passwordController,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                setState(() {
                  _isLoading = true;
                  const RegistrationScreen();
                });
              },
              validator: (input) {
                if (input!.length < 8) {
                  return 'Password must contain at least 8 characters';
                }
                return null;
              },
              onSaved: (input) => passwordController.text = input!,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.grey,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
            ),
          ),
          if (_isLoading)
            const FadeTransition(
              opacity: AlwaysStoppedAnimation(0.5),
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black)),
            child: const Text('Log in'),
            onPressed: () async {
              if (_loginKey.currentState!.validate()) {
                _loginKey.currentState!.save();
                await authService
                    .signInWithEmailAndPassword(
                        emailController.text, passwordController.text)
                    .then((user) {
                  if (user != null) {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FirebaseDashboardScreen()),
                    );
                  } else {
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Identification error"),
                      ),
                    );
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
