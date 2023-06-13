import 'package:bookshop_app/firebase_signin/phone_login.dart';
import 'package:bookshop_app/main.dart';
import 'package:bookshop_app/utils/color_util.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'google_login.dart';

class FirebaseSignInPage extends StatelessWidget {
  const FirebaseSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Purple,
        title: const Text("Select Option"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginWithGoogle()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Purple,
                ),
                child: Text("Login with google")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginWithPhone()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Purple,
                ),
                child: const Text("Login with Phone")),
          ],
        ),
      ),
    );
  }
}
