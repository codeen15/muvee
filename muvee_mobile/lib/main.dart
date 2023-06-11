import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'configs/colors.dart';
import 'pages/auth_wrapper.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthService()),
          ],
          builder: (context, child) {
            return MaterialApp(
              title: 'Muvee',
              themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: secondaryColor,
                  iconTheme: IconThemeData(
                    color: Colors.white24,
                  ),
                ),
                textTheme: const TextTheme(
                  bodySmall: TextStyle(
                    color: Colors.white,
                  ),
                  bodyMedium: TextStyle(
                    color: Colors.white,
                  ),
                  bodyLarge: TextStyle(
                    color: Colors.white,
                  ),
                ),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: quaternaryColor,
                  background: secondaryColor,
                ),
                useMaterial3: true,
              ),
              home: const AuthWrapper(),
            );
          },
        );
      },
    );
  }
}
