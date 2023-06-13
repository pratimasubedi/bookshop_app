part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  const BookLoaded({required this.books});

  @override
  List<Object> get props => [books];
}
