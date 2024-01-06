import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'authentication/login_screen.dart';
import 'main_screens/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyAw67o7K87EoPrlF6eKu1uLRmi8qsk-HbY",
      authDomain: "area-96e28.firebaseapp.com",
      projectId: "area-96e28",
      storageBucket: "area-96e28.appspot.com",
      messagingSenderId: "106019965666",
      appId: "1:106019965666:web:703cc8dd207db7bb54acbb"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOUGAREA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}


