import 'package:bookshop_app/cubit/cubit_cubit.dart';
import 'package:bookshop_app/cubit/cubit_state.dart';
import 'package:bookshop_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitLogic extends StatefulWidget {
  const AppCubitLogic({super.key});

  @override
  State<AppCubitLogic> createState() => _AppCubitLogicState();
}

class _AppCubitLogicState extends State<AppCubitLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CubitCubit, CubitState>(builder: (context, state) {
        if (state is WelcomeState) {
          return HomePage();
        } else {
          return Container();
        }
        ;
      }),
    );
  }
}
