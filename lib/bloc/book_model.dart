import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String name;
  final String image;

  const Book({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];

  static List<Book> books = [
    const Book(
      id: '0',
      name: 'Book',
      image: 'assets/images/book.jpg',
    ),
    const Book(
      id: '1',
      name: 'book1',
      image: 'assets/images/book1.jpg',
    ),
  ];
}
