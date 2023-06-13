import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'book_model.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<LoadBookCounter>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const BookLoaded(books: <Book>[]));
    });
    on<AddBook>(
      (event, emit) {
        if (state is BookLoaded) {
          final state = this.state as BookLoaded;
          emit(
            BookLoaded(
              books: List.from(state.books)..add(event.book),
            ),
          );
          on<RemoveBook>((event, emit) {
            if (state is BookLoaded) {
              final state = this.state as BookLoaded;
              emit(BookLoaded(
                books: List.from(state.books)..remove(event.book),
              ));
            }
          });
        }
      },
    );
    on<RemoveBook>(
      (event, emit) {},
    );
  }
}
