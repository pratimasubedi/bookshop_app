part of 'about_us_cubit.dart';

abstract class AboutUsState extends Equatable {
  const AboutUsState();

  @override
  List<Object> get props => [];
}

class AboutUsInitial extends AboutUsState {}

class AboutUsFetching extends AboutUsState {}

class AboutUsFetchSuccess extends AboutUsState {
  final List<AboutUsModel> aboutList;
  const AboutUsFetchSuccess(
    this.aboutList,
  );
  @override
  List<Object> get props => [aboutList];
}

class AboutUsFetchFailure extends AboutUsState {
  final String e;
  const AboutUsFetchFailure({
    this.e = "Unexpected Error",
  });

  @override
  List<Object> get props => [e];
}
