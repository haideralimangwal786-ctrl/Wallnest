import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallnest/api/api_service.dart';
import 'package:wallnest/models/wallpaper_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallnest/screens/fullscreen_wallpaper/fullscreen_wallpaper_screen.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  List<Wallpaper> _wallpapers = [];
  int _page = 1;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchWallpapers();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _fetchWallpapers();
    }
  }

  Future<void> _fetchWallpapers() async {
    setState(() {
      _isLoading = true;
    });
    final newWallpapers = await ApiService().getTrendingWallpapers(page: _page);
    setState(() {
      _wallpapers.addAll(newWallpapers);
      _page++;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _wallpapers.isEmpty && _isLoading
        ? const Center(child: CircularProgressIndicator())
        : MasonryGridView.builder(
            controller: _scrollController,
            gridDelegate:
                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: _wallpapers.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _wallpapers.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final wallpaper = _wallpapers[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullscreenWallpaperScreen(wallpaper: wallpaper),
                    ),
                  );
                },
                child: Hero(
                  tag: wallpaper.id,
                  child: Card(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: wallpaper.portraitUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
  }
} 