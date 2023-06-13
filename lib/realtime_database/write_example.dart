import 'package:bookshop_app/utils/color_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExamples extends StatefulWidget {
  const WriteExamples({super.key});

  @override
  State<WriteExamples> createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('dailySpecial/20210527/SFO/');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: const Text('Write Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  dailySpecialRef
                      .set({'description': 'Vanilla latte', 'price': 4.99})
                      .then((_) => print('Specialof the day has been written'))
                      .catchError((error) => print('You got an error!$error'));
                },
                style: ElevatedButton.styleFrom(
                  primary: Purple,
                ),
                child: const Text('Simple set'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
