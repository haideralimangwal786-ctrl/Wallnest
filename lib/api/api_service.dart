import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallnest/models/wallpaper_model.dart';

class ApiService {
  final String _apiKey = "qTD98Ax5xD1Vn2zHexyrMgdkXGUafSxJnSNBHDpiuLW9hQN5Z7hSNpKS"; // <-- Replace with your API key
  final String _baseUrl = "https://api.pexels.com/v1/";

  Future<List<Wallpaper>> getTrendingWallpapers({int page = 1}) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}curated?per_page=20&page=$page"),
      headers: {'Authorization': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> photos = data['photos'];
      return photos.map((photo) => Wallpaper.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }

  Future<List<Wallpaper>> searchWallpapers(String query, {int page = 1}) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}search?query=$query&per_page=20&page=$page"),
      headers: {'Authorization': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> photos = data['photos'];
      return photos.map((photo) => Wallpaper.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
} 