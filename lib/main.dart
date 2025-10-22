import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/router/go_router.dart';

void main() {
  runApp(const PetFinder());
}

class PetFinder extends StatelessWidget {
  const PetFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'PetFinder App',
          routerConfig: getAppRouter(),
        );
      }
    );
  }
}