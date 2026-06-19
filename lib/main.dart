import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallnest/providers/favorites_provider.dart';
import 'package:wallnest/theme/theme_provider.dart';
import 'package:wallnest/theme/themes.dart';
import 'package:wallnest/screens/home/home_screen.dart';
import 'package:wallnest/providers/offline_gallery_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => OfflineGalleryProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'WallNest',
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
