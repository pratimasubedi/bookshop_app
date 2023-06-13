import 'dart:io';

import 'package:bookshop_app/firestore/firebase_firestore.dart';
import 'package:bookshop_app/pages/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/color_util.dart';
import 'firebasestore_database.dart';

class UserDetailsPage extends StatefulWidget {
  final String name;
  final String email;

  UserDetailsPage({required this.name, required this.email});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final picker = ImagePicker();
  File? _image;
  File? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image selected'),
        ),
      );
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image selected'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Purple,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      FutureBuilder(
                        future: FireStoreDatabase().getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    snapshot.data.toString(),
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                // const CircularProgressIndicator(),
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 37,
                            color: Colors.white,
                          ),
                          onPressed: () => pickGalleryImage(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(widget.email),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('9800000000'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              subtitle: Text('Kathmandu, Nepal'),
            ),
          ],
        ),
      ),
    );
  }
}
