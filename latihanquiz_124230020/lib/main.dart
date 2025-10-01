import 'package:flutter/material.dart';
import 'login-page.dart';

// stating primary and secondary colors #menolakdefault
const Color primaryColor = Color(0xFF2C3E50); // Deep Indigo / Navy
const Color accentColor = Color(0xFFE67E22); // Carrot Orange

// stating color lagi
const MaterialColor primaryMaterialColor = MaterialColor(
  0xFF2C3E50,
  <int, Color>{
    50: Color(0xFFE5E7EB),
    100: Color(0xFFBCC4C9),
    200: Color(0xFF919CA4),
    300: Color(0xFF67757F),
    400: Color(0xFF495B6B),
    500: primaryColor, // Warna utama
    600: Color(0xFF27384A),
    700: Color(0xFF22303F),
    800: Color(0xFF1D2836),
    900: Color(0xFF141D29),
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
      debugShowCheckedModeBanner: false, // ilangin ribbon debug
      title: 'Vehicle Menu App',
      theme: ThemeData(
        primarySwatch: primaryMaterialColor,
        
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryMaterialColor)
            .copyWith(secondary: accentColor), 
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
        appBarTheme: const AppBarTheme(
          color: primaryColor,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          elevation: 0, 
        ),
      ),
      home: const LoginPage(),
    );
  }
}