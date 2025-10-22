
import 'package:go_router/go_router.dart';

GoRouter getAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
  
    ],
  );
} 
abstract class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';


}