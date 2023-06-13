import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../about_us_model.dart';
import '../api_service.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());

  FutureOr<void> fetch() async {
    emit(AboutUsFetching());
    try {
      var res = await GetIt.I<ApiService>().fetchAboutUs();
      emit(AboutUsFetchSuccess(res));
    } catch (e) {
      emit(const AboutUsFetchFailure());
    }
  }
}
