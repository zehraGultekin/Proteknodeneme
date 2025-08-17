
import 'package:go_router/go_router.dart';
import 'package:proteknodenee/core/theme/router/app_routes.dart';
import 'package:proteknodenee/features/auth/view/pages/login_page.dart';
import 'package:proteknodenee/features/home/view/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: AppRoute.login.path,
  routes: [
    GoRoute(
      path: AppRoute.login.path,
      name: AppRoute.login.name,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (context, state) => const HomePage(),
    ),
  ],
);