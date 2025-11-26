import 'package:flutter/material.dart';
import 'views/login.dart';
import 'views/home.dart';
import 'controllers/auth_controller.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cek apakah user sudah login sebelumnya
  final auth = AuthController();
  final bool isLoggedIn = await auth.isUserLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'PAM Responsi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Jika true ke Home, jika false ke Login
      home: isLoggedIn ? const HomeView() : const LoginView(),
    );
  }
}