import 'package:flutter/material.dart';
import 'package:wallnest/models/category_model.dart';
import 'package:wallnest/screens/search/search_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final Map<String, IconData> _categoryIcons = {
    'nature': Icons.nature,
    'pets': Icons.pets,
    'computer': Icons.computer,
    'restaurant': Icons.restaurant,
    'fitness_center': Icons.fitness_center,
    'directions_car': Icons.directions_car,
    'blur_on': Icons.blur_on,
    'stars': Icons.stars,
    'home': Icons.home,
    'palette': Icons.palette,
    'location_city': Icons.location_city,
    'brightness_2': Icons.brightness_2,
    'crop_square': Icons.crop_square,
  };

  final List<Color> _lightColors = [
    Colors.red[100]!,
    Colors.pink[100]!,
    Colors.purple[100]!,
    Colors.deepPurple[100]!,
    Colors.indigo[100]!,
    Colors.blue[100]!,
    Colors.lightBlue[100]!,
    Colors.cyan[100]!,
    Colors.teal[100]!,
    Colors.green[100]!,
    Colors.lightGreen[100]!,
    Colors.lime[100]!,
    Colors.yellow[100]!,
  ];

  final List<Color> _darkColors = [
    Colors.red[900]!,
    Colors.pink[900]!,
    Colors.purple[900]!,
    Colors.deepPurple[900]!,
    Colors.indigo[900]!,
    Colors.blue[900]!,
    Colors.lightBlue[900]!,
    Colors.cyan[900]!,
    Colors.teal[900]!,
    Colors.green[900]!,
    Colors.lightGreen[900]!,
    Colors.lime[900]!,
    Colors.yellow[900]!,
  ];

  final List<Category> _categories = [
    Category(
      name: 'Nature',
      imageUrl:
          'https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'nature',
    ),
    Category(
      name: 'Animals',
      imageUrl:
          'https://images.pexels.com/photos/158471/new-zealand-lake-peyto-park-158471.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'pets',
    ),
    Category(
      name: 'Technology',
      imageUrl:
          'https://images.pexels.com/photos/3861969/pexels-photo-3861969.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'computer',
    ),
    Category(
      name: 'Food',
      imageUrl:
          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'restaurant',
    ),
    Category(
      name: 'Sports',
      imageUrl:
          'https://images.pexels.com/photos/1618269/pexels-photo-1618269.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'fitness_center',
    ),
    Category(
      name: 'Cars',
      imageUrl:
          'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'directions_car',
    ),
    Category(
      name: 'Abstract',
      imageUrl:
          'https://images.pexels.com/photos/2110951/pexels-photo-2110951.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'blur_on',
    ),
    Category(
      name: 'Space',
      imageUrl:
          'https://images.pexels.com/photos/355952/pexels-photo-355952.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'stars',
    ),
    Category(
      name: 'Architecture',
      imageUrl:
          'https://images.pexels.com/photos/256150/pexels-photo-256150.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'home',
    ),
    Category(
      name: 'Art',
      imageUrl:
          'https://images.pexels.com/photos/1194420/pexels-photo-1194420.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'palette',
    ),
    Category(
      name: 'City',
      imageUrl:
          'https://images.pexels.com/photos/1851164/pexels-photo-1851164.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'location_city',
    ),
    Category(
      name: 'Dark',
      imageUrl:
          'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'brightness_2',
    ),
    Category(
      name: 'Minimal',
      imageUrl:
          'https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      iconName: 'crop_square',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.5,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(query: category.name),
              ),
            );
          },
          child: Card(
            elevation: 4,
            color: _lightColors[index % _lightColors.length],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _categoryIcons[category.iconName],
                  size: 40,
                  color: _darkColors[index % _darkColors.length],
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
