import 'package:bookshop_app/pages/loginpage.dart';
import 'package:flutter/material.dart';
import '../utils/color_util.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          style: ElevatedButton.styleFrom(
            primary: Purple,
          ),
          child: Text('Logout')),
    ));
  }
}
