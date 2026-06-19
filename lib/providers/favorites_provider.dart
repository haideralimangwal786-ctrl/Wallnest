import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallnest/models/wallpaper_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<String> _favoriteUrls = [];

  List<String> get favoriteUrls => _favoriteUrls;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteUrls = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  Future<void> toggleFavorite(Wallpaper wallpaper) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoriteUrls.contains(wallpaper.portraitUrl)) {
      _favoriteUrls.remove(wallpaper.portraitUrl);
    } else {
      _favoriteUrls.add(wallpaper.portraitUrl);
    }
    await prefs.setStringList('favorites', _favoriteUrls);
    notifyListeners();
  }

  bool isFavorite(Wallpaper wallpaper) {
    return _favoriteUrls.contains(wallpaper.portraitUrl);
  }

  Future<void> removeFavorite(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteUrls.remove(imageUrl);
    await prefs.setStringList('favorites', _favoriteUrls);
    notifyListeners();
  }
}
