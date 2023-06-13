import 'package:bookshop_app/about_us/cubit/about_us_cubit.dart';
import 'package:bookshop_app/pages/loginpage.dart';
import 'package:bookshop_app/pages/signup.dart';
import 'package:bookshop_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/book_bloc.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BookBloc()..add(LoadBookCounter()),
        ),
        BlocProvider(
          create: (_) => AboutUsCubit()..fetch(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/Login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
        },
      ),
    );
  }
}
