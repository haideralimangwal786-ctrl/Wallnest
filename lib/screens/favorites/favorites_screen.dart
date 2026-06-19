import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallnest/providers/favorites_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:wallnest/providers/offline_gallery_provider.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final favoriteUrls = favoritesProvider.favoriteUrls;
        if (favoriteUrls.isEmpty) {
          return const Center(
            child: Text('You have no favorite wallpapers yet.'),
          );
        }
        return MasonryGridView.builder(
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: favoriteUrls.length,
          itemBuilder: (context, index) {
            final url = favoriteUrls[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenWallpaper(imageUrl: url),
                  ),
                );
              },
              child: Card(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class FullScreenWallpaper extends StatelessWidget {
  const FullScreenWallpaper({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Wallpaper'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<FavoritesProvider>(
                context,
                listen: false,
              ).removeFavorite(imageUrl);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  foregroundColor: Colors.blue,
                ),
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
                            onPressed: () async {
                              bool result = await AsyncWallpaper.setWallpaper(
                                url: imageUrl,
                                wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                              );
                              print("HomeScreen: $result");
                              Navigator.pop(context);
                            },
                            child: const Text("Home"),
                          ),
                          TextButton(
                            onPressed: () async {
                              bool result = await AsyncWallpaper.setWallpaper(
                                url: imageUrl,
                                wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
                              );
                              print("LockScreen: $result");
                              Navigator.pop(context);
                            },
                            child: const Text("Lock"),
                          ),
                          TextButton(
                            onPressed: () async {
                              bool result = await AsyncWallpaper.setWallpaper(
                                url: imageUrl,
                                wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
                              );
                              print("Both: $result");
                              Navigator.pop(context);
                            },
                            child: const Text("Both"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.wallpaper),
                label: const Text('Set as wallpaper'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
