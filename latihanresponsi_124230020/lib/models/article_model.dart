class ArticleModel {
  final int id;
  final String title;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final String publishedAt;
  final String url;

  ArticleModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
      newsSite: json['news_site'] ?? 'Unknown',
      summary: json['summary'] ?? 'No summary available.',
      publishedAt: json['published_at'] ?? '',
      url: json['url'] ?? '',
    );
  }
}