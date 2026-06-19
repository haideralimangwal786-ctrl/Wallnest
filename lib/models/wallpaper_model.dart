class Wallpaper {
  final int id;
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final String originalUrl;
  final String large2xUrl;
  final String largeUrl;
  final String mediumUrl;
  final String smallUrl;
  final String portraitUrl;
  final String landscapeUrl;
  final String tinyUrl;

  Wallpaper({
    required this.id,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.originalUrl,
    required this.large2xUrl,
    required this.largeUrl,
    required this.mediumUrl,
    required this.smallUrl,
    required this.portraitUrl,
    required this.landscapeUrl,
    required this.tinyUrl,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'],
      originalUrl: json['src']['original'],
      large2xUrl: json['src']['large2x'],
      largeUrl: json['src']['large'],
      mediumUrl: json['src']['medium'],
      smallUrl: json['src']['small'],
      portraitUrl: json['src']['portrait'],
      landscapeUrl: json['src']['landscape'],
      tinyUrl: json['src']['tiny'],
    );
  }
} 