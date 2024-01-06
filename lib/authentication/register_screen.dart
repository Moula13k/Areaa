import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main_screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String adminEmail = "";
  String adminPassword = "";

  registerAdmin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
      );

      User? newAdmin = userCredential.user;

      // Save additional admin information to Firestore
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(newAdmin!.uid)
          .set({
        // Add any additional fields you want to store for the admin
        "email": adminEmail,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => const HomeScreen()),
      );
    } catch (error) {
      print("Error during registration: $error");

      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          // Handle the case where the email is already in use
          final snackBar = SnackBar(
            content: Text(
              "Email is already in use. Try logging in or use a different email.",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            backgroundColor: Color.fromRGBO(250, 186, 108, 50),
            duration: const Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          // Handle other FirebaseAuthException errors
          final snackBar = SnackBar(
            content: Text(
              "Error Occurred: ${error.message}",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            backgroundColor: Color.fromRGBO(250, 186, 108, 50),
            duration: const Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        // Handle other types of errors
        final snackBar = SnackBar(
          content: Text(
            "Error Occurred: $error",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          backgroundColor: Color.fromRGBO(250, 186, 108, 50),
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // image
                  Image.asset("images/admin.png"),

                  // email text field
                  TextField(
                    onChanged: (value) {
                      adminEmail = value;
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(244, 116, 0, 50),
                            width: 2,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          )),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.email,
                        color: Color.fromRGBO(250, 186, 108, 50),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  // password text field
                  TextField(
                    onChanged: (value) {
                      adminPassword = value;
                    },
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(244, 116, 0, 50),
                            width: 2,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          )),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.key,
                        color: Color.fromRGBO(250, 186, 108, 50),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),

                  // button register
                  ElevatedButton(
                    onPressed: () {
                      registerAdmin();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
