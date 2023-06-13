import 'package:bookshop_app/pages/homepage.dart';
import 'package:bookshop_app/utils/color_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({Key? key}) : super(key: key);

  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  String? userName;
  String? userEmail;
  String? userPhotoUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: const Text("Login With Google"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (userPhotoUrl != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(userPhotoUrl!),
                    radius: 20,
                  ),
                Text(userEmail ?? ""),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final GoogleSignInAccount? googleUser = await signInWithGoogle();
              if (googleUser != null) {
                showSelectedAccountDialog(googleUser);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Purple,
            ),
            child: const Text("Login with Google"),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              setState(() {
                userName = null;
                userEmail = null;
                userPhotoUrl = null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Purple,
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        setState(() {
          userName = user.displayName;
          userEmail = user.email;
          userPhotoUrl = user.photoURL;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
    return googleUser;
  }

  void showSelectedAccountDialog(GoogleSignInAccount googleUser) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Selected Account"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (googleUser.photoUrl != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(googleUser.photoUrl!),
                  radius: 20,
                ),
              const SizedBox(height: 10),
              Text("Name: ${googleUser.displayName}"),
              Text("Email: ${googleUser.email}"),
              Text("ID: ${googleUser.id}"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Purple,
              ),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
