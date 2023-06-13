import 'package:bookshop_app/utils/color_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:bookshop_app/database/custom_database.dart';

class CustomDatabase extends StatefulWidget {
  CustomDatabase({required this.app});
  final FirebaseApp app;

  @override
  _CustomDatabaseState createState() => _CustomDatabaseState();
}

class _CustomDatabaseState extends State<CustomDatabase> {
  final referenceDatabase = FirebaseDatabase.instance;
  final bookName = 'BookTitle';
  final bookController = TextEditingController();
  late DatabaseReference _booksRef;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database =
        FirebaseDatabase.instanceFor(app: widget.app);
    _booksRef = database.reference().child('Books');
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: const Text('Realtime Database'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        bookName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: bookController,
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .child('Books')
                              .push()
                              .child(bookName)
                              .set(bookController.text);
                          bookController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Purple,
                        ),
                        child: const Text('Save Book'),
                      ),
                      Flexible(
                        child: FirebaseAnimatedList(
                          query: _booksRef,
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            return ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    _booksRef.child(snapshot.key!).remove(),
                              ),
                              title: Text((snapshot.value
                                      as Map<String, dynamic>)['BookTitle'] ??
                                  ''),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
