import 'package:bookshop_app/utils/color_util.dart';
import 'package:flutter/material.dart';

class ReadExample extends StatefulWidget {
  const ReadExample({super.key});

  @override
  State<ReadExample> createState() => _ReadExampleState();
}

class _ReadExampleState extends State<ReadExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Purple,
        backgroundColor: Colors.transparent,
        title: const Text('Read Example'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
