import 'package:flutter/material.dart';
import 'package:flutter_v1/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDGfAtRq4FSNa4hX4SLCiGgIDlh4rQH05U",
        authDomain: "flutter-v1-b615c.firebaseapp.com",
        projectId: "flutter-v1-b615c",
        storageBucket: "flutter-v1-b615c.appspot.com",
        messagingSenderId: "693675958959",
        appId: "1:693675958959:web:fecd2954ab3acce9802a5a"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App', // Change this to your app's title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Customize your theme as needed
      ),
      home: const SignInScreen(),
    );
  }
}
