import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/services/auth_service.dart';
import 'package:flutter/material.dart';

// Main Scaffold that can be used in all screens with personalized AppBar
class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const MainScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(title),
        // Display logout button if user is connected
        actions: user != null
            ? [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    authService.signOut();
                  },
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: body,
      ),
    );
  }
}
