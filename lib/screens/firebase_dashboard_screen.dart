import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/model/firebase_user.dart';
import 'package:firebase_test/scaffolds/main_scaffold.dart';
import 'package:flutter/material.dart';

class FirebaseDashboardScreen extends StatelessWidget {
  const FirebaseDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      return const Text("You are not logged in");
    }

    final FirebaseUser user = FirebaseUser.fromFireBaseUser(firebaseUser);

    return MainScaffold(
      title: "My firebase informations",
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                    "Your firebase main informations are displayed here :",
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("User ID"),
                      subtitle: Text(user.uid),
                    ),
                    ListTile(
                      title: const Text("Email"),
                      subtitle: Text(user.email),
                    ),
                    ListTile(
                      title: const Text("Display Name"),
                      subtitle: Text(user.displayName ?? "No display name"),
                    ),
                    ListTile(
                      title: const Text("Creation Time"),
                      subtitle: Text(user.creationTime.toString()),
                    ),
                    ListTile(
                      title: const Text("Last Sign In Time"),
                      subtitle: Text(user.lastSignInTime?.toString() ??
                          "No last sign in time"),
                    ),
                    ListTile(
                      title: const Text("Photo URL"),
                      subtitle: Text(user.photoURL ?? "No photo URL"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
