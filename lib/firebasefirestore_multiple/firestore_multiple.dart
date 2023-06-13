import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/color_util.dart';

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

Future<void> addMultipleData() async {
  try {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.set(usersCollection.doc('doc1'), {
      'name': 'Ram',
      'age': 25,
      'address': 'Kathmandu',
    });
    batch.set(usersCollection.doc('doc2'), {
      'name': 'Shyam',
      'age': 30,
      'address': 'Kathmandu',
    });
    batch.set(usersCollection.doc('doc3'), {
      'name': 'Hari',
      'age': 35,
      'address': 'Kathmandu',
    });

    await batch.commit();
    print('Multiple data added to Firestore successfully!');
  } catch (e) {
    print('Error adding multiple data to Firestore: $e');
  }
}

class FirestoreMultiple extends StatelessWidget {
  const FirestoreMultiple({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: const Text('Firestore Multiple Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            addMultipleData();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Purple),
          child: const Text('Add Multiple Data'),
        ),
      ),
    );
  }
}
