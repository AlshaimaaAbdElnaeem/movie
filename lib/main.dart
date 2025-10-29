import 'package:flutter/material.dart';
import 'package:movie/features/navigation/nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',  // تخصيص الخط
        brightness: Brightness.dark,  // or light
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Color.fromARGB(19, 19, 19, 19),  // تخصيص لون الـ AppBar
        // ),
        scaffoldBackgroundColor: const Color.fromARGB(19, 19, 19, 19),  // تخصيص لون الخلفية العامة
      ),
      home: MyNavBar(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:movie/core/router/go_router.dart';

// void main() {
//   runApp(const PetFinder());
// }

// class PetFinder extends StatelessWidget {
//   const PetFinder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_ , child) {
//         return MaterialApp.router(
//           debugShowCheckedModeBanner: false,
//           title: 'PetFinder App',
//           routerConfig: getAppRouter(),
//         );
//       }
//     );
//   }
// }
