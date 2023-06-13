import 'package:bookshop_app/cubit/app_cubit_logic.dart';
import 'package:bookshop_app/cubit/cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitScreen extends StatelessWidget {
  const CubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider<CubitCubit>(
          create: (context) => CubitCubit(),
          child: const AppCubitLogic(),
        ));
  }
}
