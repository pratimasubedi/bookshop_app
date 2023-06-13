import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreDatabase {
  String? downloadURL;

  Future getData() async {
    try {
      await downloadURLExample();
      return downloadURL;
    } catch (e) {
      debugPrint('Error - $e');
      return null;
    }
  }

  Future<void> downloadURLExample() async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child('test/20230606_081320.jpg')
        .getDownloadURL();
    debugPrint(downloadURL.toString());
  }
}
