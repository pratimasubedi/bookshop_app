import 'package:equatable/equatable.dart';

class AboutUsModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool status;
  const AboutUsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory AboutUsModel.fromMap(Map<String, dynamic> map) {
    return AboutUsModel(
      id: map['id'].toInt() as int,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] == 1 ? true : false,
    );
  }

  @override
  List<Object> get props => [id, title, description, status];
}
