import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class OfflineGalleryProvider with ChangeNotifier {
  List<FileSystemEntity> _images = [];

  List<FileSystemEntity> get images => _images;

  OfflineGalleryProvider() {
    _loadImages();
  }

  Future<void> _loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final imageDirectory = Directory('${directory.path}/offline_wallpapers');
    if (!imageDirectory.existsSync()) {
      imageDirectory.createSync();
    }
    _images = imageDirectory.listSync();
    notifyListeners();
  }

  Future<void> addImage(String imagePath) async {
    final imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      _images.add(imageFile);
      notifyListeners();
    }
  }
}
