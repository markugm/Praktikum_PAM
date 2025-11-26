import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  // Key untuk SharedPreferences
  final String _keyUsername = 'username';
  final String _keyPassword = 'password';
  final String _keyIsLoggedIn = 'isLoggedIn';
  final String _keyActiveUser = 'activeUser';

  // LOGIKA REGISTER: Simpan username & password ke memori HP
  Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyPassword, password);
    return true; 
  }

  // LOGIKA LOGIN: Cek apakah input cocok dengan data yang diregistrasi
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Ambil data yang tersimpan
    String? storedUser = prefs.getString(_keyUsername);
    String? storedPass = prefs.getString(_keyPassword);

    // Validasi sederhana
    if (storedUser != null && storedPass != null) {
      if (username == storedUser && password == storedPass) {
        await prefs.setBool(_keyIsLoggedIn, true);
        await prefs.setString(_keyActiveUser, username);
        return true;
      }
    }
    return false;
  }

  // Cek Status Login (untuk auto-login di main.dart)
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Ambil Username yang sedang login (untuk ditampilkan di Home)
  Future<String> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyActiveUser) ?? "User";
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false); // Set status login false
    // Note: Kita tidak menghapus username/password agar user bisa login lagi nanti
  }
}