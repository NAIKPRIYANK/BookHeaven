import 'package:book_heaven/database/sqflite_database_service.dart';

import 'package:book_heaven/presentation/resources/router/route_manager.dart';
import 'package:book_heaven/presentation/resources/theme/theme_manager.dart';
import 'package:book_heaven/presentation/screens/home/bloc.dart';
import 'package:book_heaven/presentation/screens/home/event.dart' as home;

import 'package:book_heaven/presentation/screens/login/bloc.dart';
import 'package:book_heaven/presentation/screens/login/event.dart';
import 'package:book_heaven/presentation/screens/onboarding/bloc.dart';
import 'package:book_heaven/presentation/screens/onboarding/event.dart'
    as onboard;
import 'package:book_heaven/presentation/screens/register/bloc.dart';
import 'package:book_heaven/presentation/screens/register/event.dart'
    as register;

import 'package:book_heaven/presentation/screens/splash/bloc.dart';
import 'package:book_heaven/presentation/screens/splash/event.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;


  

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        
        BlocProvider(create: (_) => LoginBloc()..add(InitEvent())),

        BlocProvider(create: (_) => HomeBloc()..add(home.InitEvent())),
        BlocProvider(create: (_) => SplashBloc()..add(SplashInitEvent())),
        BlocProvider(create: (_) => OnboardingBloc()..add(onboard.InitEvent())),
        BlocProvider(create: (_) => RegisterBloc()..add(register.InitEvent()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashPage,
        theme: getApplicationTheme(),
      ),
    );
  }
}
