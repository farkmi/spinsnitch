import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_wrapper.dart';
import 'services/recognition_service.dart';
import 'config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(apiBaseUrl: AppConfig.apiBaseUrl)),
        Provider(create: (_) => RecognitionService()),
      ],
      child: MaterialApp(
        title: 'SpinSnitch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
            surface: const Color(0xFF121212),
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
          cardTheme: CardThemeData(
            color: const Color(0xFF1E1E1E),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF121212),
            elevation: 0,
            centerTitle: true,
          ),
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: const Color(0xFF1E1E1E),
            indicatorColor: Colors.teal.withAlpha(51),
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        themeMode: ThemeMode.dark, // Default to dark mode as requested
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (auth.isAuthenticated) {
      return const MainNavigationWrapper();
    } else {
      return const LoginScreen();
    }
  }
}
