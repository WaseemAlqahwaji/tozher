class UploadedImage {
  final String url;
  final String displayUrl;
  final String deleteUrl;

  const UploadedImage({
    required this.url,
    required this.displayUrl,
    required this.deleteUrl,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) {
    return UploadedImage(
      url: json['url'] as String,
      displayUrl: json['display_url'] as String,
      deleteUrl: json['delete_url'] as String? ?? '',
    );
  }
}
