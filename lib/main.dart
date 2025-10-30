import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/navigation/nav_bar.dart';

void main() {
  runApp(MyApp());
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
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Color.fromARGB(19, 19, 19, 19),  // تخصيص لون الـ AppBar
        // ),
        scaffoldBackgroundColor: const Color.fromARGB(19, 19, 19, 19),  // تخصيص لون الخلفية العامة
      ),
      home: MyNavBar(),
    );
  }
    );
}

  }
