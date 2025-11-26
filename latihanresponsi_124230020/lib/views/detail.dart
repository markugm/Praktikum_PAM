import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article_model.dart';
import '../main.dart';

class DetailView extends StatelessWidget {
  final ArticleModel article;

  const DetailView({super.key, required this.article});

  // Fungsi Launch URL
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(article.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text('Tidak bisa membuka: $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Berita")),
      // Floating Action Button untuk membuka link 
      floatingActionButton: FloatingActionButton(
        onPressed: _launchUrl,
        tooltip: 'Buka di Browser',
        child: const Icon(Icons.open_in_new),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("Published: ${article.publishedAt.substring(0, 10)}", 
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 20),
                  Text(article.summary, style: const TextStyle(fontSize: 16, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}