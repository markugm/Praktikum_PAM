import 'package:flutter/material.dart';
import '../controllers/api_controller.dart';
import '../models/article_model.dart';
import 'detail.dart';

class ArticleListView extends StatefulWidget {
  final String endpoint; // 'articles', 'blogs', atau 'reports'
  final String title;

  const ArticleListView({super.key, required this.endpoint, required this.title});

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  final ApiController _apiController = ApiController();
  
  // List asli dari API
  List<ArticleModel> _allArticles = [];
  // List yang ditampilkan (hasil filter search)
  List<ArticleModel> _foundArticles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _apiController.fetchArticles(widget.endpoint);
      setState(() {
        _allArticles = data;
        _foundArticles = data; // Awalnya tampilkan semua
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error: $e");
    }
  }

  // LOGIKA SEARCH BAR
  void _runFilter(String keyword) {
    List<ArticleModel> results = [];
    if (keyword.isEmpty) {
      results = _allArticles;
    } else {
      results = _allArticles
          .where((item) => item.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundArticles = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          // --- SEARCH BAR AREA ---
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Cari ${widget.title}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
            ),
          ),
          
          // --- LIST AREA ---
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _foundArticles.isEmpty
                    ? const Center(child: Text("Data tidak ditemukan"))
                    : ListView.builder(
                        itemCount: _foundArticles.length,
                        itemBuilder: (context, index) {
                          final item = _foundArticles[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailView(article: item),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  // Gambar Thumbnail
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4), 
                                      bottomLeft: Radius.circular(4)
                                    ),
                                    child: Image.network(
                                      item.imageUrl,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (ctx, err, stack) => 
                                          Container(width: 100, height: 100, color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // Teks Judul
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(item.newsSite, style: const TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}