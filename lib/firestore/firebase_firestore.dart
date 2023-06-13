import 'package:bookshop_app/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore extends StatelessWidget {
  FireStore({Key? key}) : super(key: key);

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  String? textNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Purple,
        title: const Text('Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                textNote = value;
              },
              decoration: InputDecoration(hintText: 'Enter...'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await users.add({
                  'name': 'Pratima',
                  'address': 'Kathmandu',
                  'notes': textNote,
                }).then((value) => print('User added'));
              },
              style: ElevatedButton.styleFrom(
                primary: Purple,
              ),
              child: const Text('Submit'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['address']),
                        trailing: Text(data['notes'] ?? ''),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
