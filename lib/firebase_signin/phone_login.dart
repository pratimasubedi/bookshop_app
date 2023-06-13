import 'package:bookshop_app/pages/homepage.dart';
import 'package:bookshop_app/utils/color_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDReceived = '';
  bool otpCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.purple,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Phone Authentication'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: otpCodeVisible,
              child: TextField(
                controller: otpCodeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (otpCodeVisible) {
                  verifyOTP();
                } else {
                  loginWithPhone();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Purple,
              ),
              child: Text(otpCodeVisible ? 'Login' : 'Verify'),
            ),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    final String phoneNumber = '+977${phoneController.text}';

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print('You are logged in successfully');
          showToast('You are logged in successfully');
        }).catchError((error) {
          print('Failed to sign in: $error');
          showToast('Failed to sign in: $error');
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        showToast(e.message ?? 'Verification Failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          otpCodeVisible = true;
          verificationIDReceived = verificationId;
        });

        // Send the OTP code to the user's phone number
        showToast('OTP code sent to $phoneNumber ${otpCodeController.text}');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIDReceived,
      smsCode: otpCodeController.text,
    );

    await auth.signInWithCredential(credential).then((value) {
      print('You are logged in successfully');
      showToast('You are logged in successfully');
    }).catchError((error) {
      print('Failed to sign in: $error');
      showToast('Failed to sign in: $error');
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Purple,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
