import 'package:flutter/material.dart';
import 'package:movie/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/navigation/nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',  // تخصيص الخط
        brightness: Brightness.dark,  // or light
       
        scaffoldBackgroundColor: const Color.fromARGB(19, 19, 19, 19), 
      ),
      home: const SplashScreen(),
    );
  }

    );
}

}
