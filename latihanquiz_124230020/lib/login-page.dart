import 'package:flutter/material.dart';
import 'home-page.dart';
import 'main.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // State untuk mengontrol visibilitas password
  bool _isPasswordVisible = false; 

  void _attemptLogin() {
    if (_formKey.currentState!.validate()) {
      // Autentikasi sederhana
      if (_usernameController.text == 'admin' && _passwordController.text == '123') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Selamat datang ${_usernameController.text}!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(username: _usernameController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username atau Password salah!"),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo/Icon yang menawan
                Icon(
                  Icons.directions_car_filled, 
                  size: 100, 
                  color: primaryColor, 
                ),
                const SizedBox(height: 10),
                const Text(
                  'Vehicle ShowApp',
                  style: TextStyle(
                    fontSize: 24, // Font lebih besar dan tegas
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Input Username
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: accentColor, width: 2.0), // Aksen saat fokus
                    ),
                    prefixIcon: const Icon(Icons.person, color: primaryColor),
                  ),
                  validator: (value) => value!.isEmpty ? 'Masukkan username Anda' : null,
                ),
                const SizedBox(height: 20),
                
                // Input Password dengan Toggle Hide/View
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible, // Kontrol Hide/View
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: accentColor, width: 2.0),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: primaryColor),
                    // Tombol Toggle Password
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Masukkan password Anda' : null,
                ),
                const SizedBox(height: 40),
                
                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _attemptLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'MASUK', 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5, // Sedikit jarak antar huruf
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}