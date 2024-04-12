import 'package:firebase_test/screens/login_screen.dart';
import 'package:firebase_test/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final GlobalKey<FormState> _registrationKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                autocorrect: false,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Enter a valid email address';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,8}$')
                      .hasMatch(input)) {
                    return "The email address format is not valid";
                  }
                  return null;
                },
                onSaved: (input) => _emailController.text = input!,
                decoration: const InputDecoration(
                  hintText: 'Your email address',
                  filled: true,
                  fillColor: Colors.grey,
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                autocorrect: false,
                validator: (input) {
                  if (input!.length < 8) {
                    return 'Password must contain at least 8 characters';
                  }
                  return null;
                },
                onSaved: (input) => _passwordController.text = input!,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordCheckController,
                autocorrect: false,
                validator: (input) {
                  if (input! != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onSaved: (input) => _passwordCheckController.text = input!,
                decoration: const InputDecoration(
                  hintText: 'Please confirm your password',
                  filled: true,
                  fillColor: Colors.grey,
                  border: InputBorder.none,
                ),
                obscureText: _obscureText,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
              child: const Text('Create an account'),
              onPressed: () {
                if (_registrationKey.currentState!.validate()) {
                  authService
                      .createUserWithEmailAndPassword(
                          _emailController.text, _passwordController.text)
                      .then((user) {
                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              'Account created successfully, you can log in'),
                          action: SnackBarAction(
                            label: 'Log in',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      String? errorCode = authService.errorCode;
                      if (errorCode == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'This email address is already associated with an account'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('An error has occurred : $errorCode'),
                          ),
                        );
                      }
                    }
                  }).catchError((error) {});
                } else {
                  setState(() {
                    _autoValidate = AutovalidateMode.always;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
