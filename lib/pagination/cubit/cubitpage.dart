import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/posts_respository.dart';
import '../data/services/posts_service.dart';
import 'cubit/cubit_cubit.dart';
import 'cubit_screen.dart';

void main() {
  runApp(PaginationApp(
    repository: PostsRepository(PostsService()),
  ));
}

class PaginationApp extends StatelessWidget {
  final PostsRepository repository;

  const PaginationApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PostsCubit(repository),
        child: PostsView(),
      ),
    );
  }
}
