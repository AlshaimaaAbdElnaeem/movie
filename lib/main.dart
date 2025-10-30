import 'package:flutter/material.dart';
import 'package:movie/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/presentation/cubit/movie_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieCubit(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Inter', // تخصيص الخط
              brightness: Brightness.dark, // or light

              scaffoldBackgroundColor: const Color.fromARGB(19, 19, 19, 19),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
