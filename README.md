# firebase_test

A read-to-use aunthentication Firebase project

## Description

This application allows to set up authentication using firebase authentication, with all the best practices, from code architecture to error handling and displays.

## Application settings

- You must first create a project on firebase
- Once, your project created, add firebase to your Flutter application
- Install [CLI Firebase](https://firebase.google.com/docs/cli?hl=fr&authuser=0&_gl=1*pt1vnc*_ga*MjM1NzU5ODgyLjE3MTI2NzE0MzQ.*_ga_CW55HF8NVT*MTcxMjkxNDMxNy44LjEuMTcxMjkxNTAxOC42MC4wLjA.#install_the_firebase_cli)
- Open your Flutter project in your favorite IDE and then run this command from anywhere :

```
dart pub global activate flutterfire_cli
```

- Then, in the root of your Flutter project directory, run this command, your projectID is provided by Firebase conifguration:

```
flutterfire configure --project=yourprojectID
```

- Initialize your app in your main.dart :

```
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

## That's it, you should be able to use the firebase authentication with this application.
