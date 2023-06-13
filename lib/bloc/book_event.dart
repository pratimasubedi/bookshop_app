part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class LoadBookCounter extends BookEvent {}

class AddBook extends BookEvent {
  final Book book;
  const AddBook(this.book);
  @override
  List<Object> get props => [book];
}

class RemoveBook extends BookEvent {
  final Book book;
  const RemoveBook(this.book);
  @override
  List<Object> get props => [book];
}
