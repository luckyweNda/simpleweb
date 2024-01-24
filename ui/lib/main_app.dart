import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simpleweb/home_page.dart';
import 'package:simpleweb/login_page.dart';
import 'package:simpleweb/register_page.dart';

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterPage(),
  ),
]);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
