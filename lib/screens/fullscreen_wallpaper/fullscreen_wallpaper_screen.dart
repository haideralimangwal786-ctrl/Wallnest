import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallnest/models/wallpaper_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallnest/providers/favorites_provider.dart';
import 'package:wallnest/utils/wallpaper_helper.dart';

class FullscreenWallpaperScreen extends StatelessWidget {
  final Wallpaper wallpaper;
  const FullscreenWallpaperScreen({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: wallpaper.id,
            child: CachedNetworkImage(
              imageUrl: wallpaper.portraitUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                return IconButton(
                  icon: Icon(
                    favoritesProvider.isFavorite(wallpaper)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    favoritesProvider.toggleFavorite(wallpaper);
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Set Wallpaper"),
                          content: const Text(
                            "Choose where to set the wallpaper:",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                WallpaperHelper.setWallpaper(
                                  wallpaper.originalUrl,
                                  context,
                                  location: "home",
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text("Home"),
                            ),
                            TextButton(
                              onPressed: () {
                                WallpaperHelper.setWallpaper(
                                  wallpaper.originalUrl,
                                  context,
                                  location: "lock",
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text("Lock"),
                            ),
                            TextButton(
                              onPressed: () {
                                WallpaperHelper.setWallpaper(
                                  wallpaper.originalUrl,
                                  context,
                                  location: "both",
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text("Both"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.wallpaper),
                  label: const Text('Set as Wallpaper'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
