import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/show_service.dart';
import '../services/towatch_service.dart';
import 'login.dart';
import 'nav.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        User? user = authService.user;

        if (user == null) {
          return const LoginPage();
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => ShowService()),
              ChangeNotifierProvider(create: (context) => ToWatchService()),
            ],
            builder: (context, child) {
              return Navigator(
                key: _navigatorKey,
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => const NavPage(),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
