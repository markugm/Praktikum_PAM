import 'package:flutter/material.dart';
import 'login-page.dart';

//state warna maroon kustom
const MaterialColor maroon = MaterialColor(
  0xFF800000, 
  <int, Color>{
    50: Color(0xFFFDE5E5),
    100: Color(0xFFF8BFBF),
    200: Color(0xFFF29696),
    300: Color(0xFFEC7070),
    400: Color(0xFFE85353),
    500: Color(0xFF800000), // Warna utama
    600: Color(0xFF730000),
    700: Color(0xFF630000),
    800: Color(0xFF540000),
    900: Color(0xFF3B0000),
  },
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Menu App',
      theme: ThemeData(
        primarySwatch: maroon, 
        primaryColor: maroon,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: maroon, 
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      home: const LoginPage(),
    );
  }
}