import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/color_util.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Declare variables for email and password
  String _email = '';
  String _password = '';

  // Declare a FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _createUserWithEmailAndPassword();
              },
              style: ElevatedButton.styleFrom(
                primary: Purple,
              ),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create a new user with email and password
  void _createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      // User successfully signed up
      // Navigate to the next screen or perform any desired actions
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
