import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bookshop_app/pages/storage_service.dart';
import '../utils/color_util.dart';

class DatabaseStorage extends StatefulWidget {
  const DatabaseStorage({Key? key}) : super(key: key);

  @override
  State<DatabaseStorage> createState() => _DatabaseStorageState();
}

class _DatabaseStorageState extends State<DatabaseStorage> {
  final Storage storage = Storage();

  String? filePath;
  String? fileName;

  Future<void> selectImage() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (results == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No file has been selected'),
        ),
      );
      return;
    }

    setState(() {
      filePath = results.files.single.path!;
      fileName = results.files.single.name;
    });

    storage.uploadFile(filePath!, fileName!).then((value) {
      print('Done');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Image selected'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Purple,
                ),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });

    print(filePath);
    print(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Storage'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: selectImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Purple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
