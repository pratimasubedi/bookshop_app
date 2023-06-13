import 'package:equatable/equatable.dart';
import 'package:bookshop_app/bloc/book_bloc.dart';
import 'package:bookshop_app/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_model.dart';
import 'package:flutter/widgets.dart';

// Widget build(BuildContext context) {
//   return Provider<Example>(
//     create: (_) => Example(),
//     builder: (context, child) {
//       // Use the context to access the provider
//       return Text(context.watch<Example>().toString());
//     },
//   );
// }

class BlocPage extends StatelessWidget {
  const BlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<BookBloc, BookState>(builder: (context, state) {
          if (state is BookInitial) {
            return const CircularProgressIndicator(
              color: Purple,
            );
          }
          if (state is BookLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${state.books.length}',
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      for (int index = 0; index < state.books.length; index++)
                        Positioned(
                          top: 100,
                          left: 200,
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              state.books[index].image,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong!');
          }
        }),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: const Icon(Icons.local_activity_outlined),
          backgroundColor: Colors.purple,
          onPressed: () {
            // final currentState = context.read<BookBloc>().state;
            // if (currentState is BookLoaded && currentState.books.isNotEmpty) {
            context.read<BookBloc>().add(AddBook(Book.books[0]));
          },
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          child: const Icon(Icons.remove),
          backgroundColor: Colors.purple,
          onPressed: () {
            context.read<BookBloc>().add(RemoveBook(Book.books[0]));
          },
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          child: const Icon(Icons.remove),
          backgroundColor: Colors.purple,
          onPressed: () {
            context.read<BookBloc>().add(RemoveBook(Book.books[0]));
          },
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          child: const Icon(Icons.remove),
          backgroundColor: Colors.purple,
          onPressed: () {
            context.read<BookBloc>().add(RemoveBook(Book.books[0]));
          },
        ),
      ]),
    );
  }
}
