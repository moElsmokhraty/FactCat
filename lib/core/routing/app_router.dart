import 'package:flutter/material.dart';
import 'package:fact_cat/core/routing/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/main/presentation/views/main_view/main_view.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.main:
        return transitionPage(ProviderScope(child: const MainView()));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Text(
                  'No route defined for ${settings.name}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }

  static PageRouteBuilder transitionPage(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
