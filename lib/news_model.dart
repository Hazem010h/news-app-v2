class NewsModel {
  final String title;
  final String? urlToImage;
  final String publishedAt;
  final String url;

  const NewsModel({
    required this.title,
    required this.urlToImage,
    required this.publishedAt,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      url: json['url'] ?? '',
    );
  }

  /// Converts the whole `articles` list from the response into models.
  static List<NewsModel> fromJsonList(List<dynamic> list) {
    return list
        .map((item) => NewsModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
