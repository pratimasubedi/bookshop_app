import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'cubit_state.dart';

class CubitCubit extends Cubit<CubitState> {
  CubitCubit() : super(CubitInitial()) {
    emit(WelcomeState());
  }
}
