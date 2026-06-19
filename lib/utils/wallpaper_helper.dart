import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:async_wallpaper/async_wallpaper.dart'
    if (dart.library.html) 'package:async_wallpaper/async_wallpaper_web.dart';

class WallpaperHelper {
  static Future<void> downloadWallpaper(
    String url,
    BuildContext context,
  ) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final http.Response response = await http.get(Uri.parse(url));
        final Uint8List imageBytes = response.bodyBytes;
        // final result = await ImageGallerySaver.saveImage(imageBytes);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wallpaper downloaded successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download wallpaper: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  static Future<void> setWallpaper(
    String url,
    BuildContext context, {
    String location = "home",
  }) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Setting wallpaper...')));
    int wallpaperLocation;
    if (location == "home") {
      wallpaperLocation = AsyncWallpaper.HOME_SCREEN;
    } else if (location == "lock") {
      wallpaperLocation = AsyncWallpaper.LOCK_SCREEN;
    } else {
      wallpaperLocation = AsyncWallpaper.BOTH_SCREENS;
    }
    try {
      print("Attempting to set wallpaper from URL: $url");
      final success = await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: wallpaperLocation,
        goToHome: false,
      );
      if (success) {
        print("Wallpaper set successfully.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wallpaper set successfully!')),
        );
      } else {
        print("AsyncWallpaper returned false.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to set wallpaper.')),
        );
      }
    } catch (e) {
      print("Error setting wallpaper: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error setting wallpaper: $e')));
    }
  }
}
