import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ApiController {
  final String _baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  // Endpoint dinamis: articles, blogs, atau reports
  Future<List<ArticleModel>> fetchArticles(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint/?limit=20'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List results = jsonResponse['results'];
      return results.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data dari API');
    }
  }
}