import 'package:equatable/equatable.dart';

abstract class CubitState extends Equatable {}

class CubitInitial extends CubitState {
  @override
  List<Object> get props => [];
}

class WelcomeState extends CubitState {
  @override
  List<Object> get props => [];
}
