import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omwaytech/auth/bloc/login_bloc/login_bloc.dart';
import 'package:omwaytech/auth/bloc/register_bloc/register_bloc.dart';
import 'package:omwaytech/home/bloc/news_bloc/news_bloc.dart';
import 'package:omwaytech/home/ui/home_screen.dart';
import 'package:omwaytech/splash_screen.dart';
import 'package:omwaytech/utils/size.dart';
import 'package:omwaytech/utils/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => NewsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: const SplashScreen(),
      ),
    );
  }
}
