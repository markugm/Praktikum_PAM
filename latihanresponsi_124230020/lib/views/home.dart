import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'login.dart';
import  'list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String username = "";
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    String user = await _authController.getCurrentUser();
    setState(() {
      username = user;
    });
  }

  void _logout() async {
    await _authController.logout();
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hai, $username!"), // Requirement PDF: Tampilkan username
        actions: [IconButton(onPressed: _logout, icon: const Icon(Icons.logout))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMenuItem("News", "articles", Icons.newspaper, Colors.blue),
            _buildMenuItem("Blog", "blogs", Icons.edit_note, Colors.orange),
            _buildMenuItem("Report", "reports", Icons.analytics, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, String endpoint, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: const Text("Lihat data terbaru"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Kirim endpoint ke halaman List
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleListView(endpoint: endpoint, title: title),
            ),
          );
        },
      ),
    );
  }
}