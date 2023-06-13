import 'dart:math';

import 'package:bookshop_app/realtime_database/read_example.dart';
import 'package:bookshop_app/realtime_database/write_example.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../utils/color_util.dart';

class RealtimeDatabase extends StatelessWidget {
  RealtimeDatabase({super.key});

  final DatabaseReference database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('dailySpecial/20210527/SFO/');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Database'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await dailySpecialRef
                      .set({'description': 'Vanilla latte', 'price': 4.99});
                  // await database.update({
                  //   'dailySpecial/price': 3.99,
                  //   'someOtherDailySpecial/price': 3.99
                  // });
                  print('Special of the day has been written');
                } catch (e) {
                  print('You got an error! $e');
                }
              },
              child: const Text('Simple'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReadExample()));
              },
              style: ElevatedButton.styleFrom(
                primary: Purple,
              ),
              child: const Text('Read'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WriteExamples()));
              },
              style: ElevatedButton.styleFrom(
                primary: Purple,
              ),
              child: const Text('Write'),
            ),
          ],
        ),
      ),
    );
  }
}
