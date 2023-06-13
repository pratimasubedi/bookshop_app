import 'package:bookshop_app/todo_functionality/todopage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: TodoPage(),
    );
  }
}
