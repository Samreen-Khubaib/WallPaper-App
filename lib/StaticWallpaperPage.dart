import 'package:flutter/material.dart';
import 'WallpaperDetailPage.dart'; // Import the detail page for wallpapers

class StaticWallpaperPage extends StatefulWidget {
  @override
  _StaticWallpaperPageState createState() => _StaticWallpaperPageState();
}

class _StaticWallpaperPageState extends State<StaticWallpaperPage> {
  static const List<Map<String, String>> allWallpapers = [
    {"image": "assets/wallpapers/quote1.jpg", "name": "Rise & Grind", "category": "Quote"},
    {"image": "assets/wallpapers/quote2.jpg", "name": "Life in Lines", "category": "Quote"},
    {"image": "assets/wallpapers/quote3.jpg", "name": "Soulful Sayings", "category": "Quote"},
    {"image": "assets/wallpapers/quote4.jpg", "name": "Mindful Reflections", "category": "Quote"},
    {"image": "assets/wallpapers/quote5.jpg", "name": "Sky's the Limit", "category": "Quote"},
    {"image": "assets/wallpapers/quote6.jpg", "name": "Ethereal Echoes", "category": "Quote"},
    {"image": "assets/wallpapers/quote7.jpg", "name": "Minimal Words", "category": "Quote"},
    {"image": "assets/wallpapers/quote8.jpg", "name": "Quote & Bloom", "category": "Quote"},
    {"image": "assets/wallpapers/quote9.jpg", "name": "Brave Souls", "category": "Quote"},
    {"image": "assets/wallpapers/quote10.jpg", "name": "Pastel Prose", "category": "Quote"},
    {"image": "assets/wallpapers/quote11.jpg", "name": "Mind Over Matter", "category": "Quote"},
    {"image": "assets/wallpapers/quote12.jpg", "name": "Inspire & Elevate", "category": "Quote"},
    {"image": "assets/wallpapers/quote13.jpg", "name": "Carpe Diem", "category": "Quote"},
    {"image": "assets/wallpapers/quote14.jpg", "name": "Be the Change", "category": "Quote"},
    {"image": "assets/wallpapers/quote15.jpg", "name": "Choose Happiness", "category": "Quote"},
    {"image": "assets/wallpapers/quote16.jpg", "name": "The Art of Letting Go", "category": "Quote"},
    {"image": "assets/wallpapers/scenery1.jpg", "name": "Serene Scenes", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery2.jpg", "name": "Celestial Views", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery3.jpg", "name": "Peak Serenity", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery4.jpg", "name": "Endless Vistas", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery5.jpg", "name": "Spring Awakens", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery6.jpg", "name": "Golden Horizons", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery7.jpg", "name": "Under the Stars", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery8.jpg", "name": "Ocean Serenity", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery9.jpg", "name": "Summer Horizons", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery10.jpg", "name": "Skyline Wonders", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery11.jpg", "name": "Serene Peaks", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery12.jpg", "name": "Mist Over the Lake", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery13.jpg", "name": "Verdant Escape", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery14.jpg", "name": "Pastel Skies", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery15.jpg", "name": "Chasing Sunbeams", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery16.jpg", "name": "Foggy Morning Views", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery17.jpg", "name": "Autumn Aura", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery18.jpg", "name": "Amber Serenity", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery19.jpg", "name": "Clay Tones", "category": "Scenery"},
    {"image": "assets/wallpapers/scenery20.jpg", "name": "Bronze Horizons", "category": "Scenery"},
    {"image": "assets/wallpapers/cute1.jpg", "name": "Smiles & Snuggles", "category": "Cute"},
    {"image": "assets/wallpapers/cute2.jpg", "name": "Charm & Cheer", "category": "Cute"},
    {"image": "assets/wallpapers/cute3.jpg", "name": "Playful Scribbles", "category": "Cute"},
    {"image": "assets/wallpapers/cute4.jpg", "name": "Heart & Hug", "category": "Cute"},
    {"image": "assets/wallpapers/cute5.jpg", "name": "Meow Moments", "category": "Cute"},
    {"image": "assets/wallpapers/cute6.jpg", "name": "Tiny Critters", "category": "Cute"},
    {"image": "assets/wallpapers/cute7.jpg", "name": "Dreamy Delights", "category": "Cute"},
    {"image": "assets/wallpapers/cute8.jpg", "name": "Simply Sweet", "category": "Cute"},
    {"image": "assets/wallpapers/cute9.jpg", "name": "Pastel Paradise", "category": "Cute"},
    {"image": "assets/wallpapers/cute10.jpg", "name": "Cotton Candy Skies", "category": "Cute"},
    {"image": "assets/wallpapers/cute11.jpg", "name": "Bubble Wrap Fun", "category": "Cute"},
    {"image": "assets/wallpapers/cute12.jpg", "name": "Sakura Breeze", "category": "Cute"},
    {"image": "assets/wallpapers/cute13.jpg", "name": "Dreamy Meadows", "category": "Cute"},
    {"image": "assets/wallpapers/cute14.jpg", "name": "Sweet Serenity", "category": "Cute"},
    {"image": "assets/wallpapers/cute15.jpg", "name": "Tiny Hearts", "category": "Cute"},
    {"image": "assets/wallpapers/cute16.jpg", "name": "Frosted Sugar", "category": "Cute"},
    {"image": "assets/wallpapers/cute17.jpg", "name": "Starry Serenade", "category": "Cute"},
    {"image": "assets/wallpapers/cute18.jpg", "name": "Pink Bliss", "category": "Cute"},
    {"image": "assets/wallpapers/cute19.jpg", "name": "Critter Canvas", "category": "Cute"},
    {"image": "assets/wallpapers/cute20.jpg", "name": "Velvet Vibes", "category": "Cute"},
    {"image": "assets/wallpapers/doodle1.jpg", "name": "Adorable Aesthetics", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle2.jpg", "name": "Sketchy Vibes", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle3.jpg", "name": "Monochrome Moods", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle4.jpg", "name": "Pastel Doodles", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle5.jpg", "name": "Kawaii Sketches", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle6.jpg", "name": "Cheerful Chalkboard", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle7.jpg", "name": "Scribble Style", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle8.jpg", "name": "Minimalist Mark", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle9.jpg", "name": "Line Art Love", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle10.jpg", "name": "Random Scribbles", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle11.jpg", "name": "Scribbled Thoughts", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle12.jpg", "name": "Inked Imagination", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle13.jpg", "name": "Scribble Universe", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle14.jpg", "name": "Doodle Bliss", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle15.jpg", "name": "Abstract Sketches", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle16.jpg", "name": "Colorful Chaos", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle17.jpg", "name": "Blooming Doodles", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle18.jpg", "name": "PencilPixies", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle19.jpg", "name": "Fuzzy Doodle Friends", "category": "Doodle"},
    {"image": "assets/wallpapers/doodle20.jpg", "name": "Doodle Bugs", "category": "Doodle"},
    {"image": "assets/wallpapers/dark1.jpg", "name": "Midnight Aesthetics", "category": "Dark"},
    {"image": "assets/wallpapers/dark2.jpg", "name": "Shadows & Silhouettes", "category": "Dark"},
    {"image": "assets/wallpapers/dark3.jpg", "name": "Dark Elegance", "category": "Dark"},
    {"image": "assets/wallpapers/dark4.jpg", "name": "Moody Hues", "category": "Dark"},
    {"image": "assets/wallpapers/dark5.jpg", "name": "Eclipse Essence", "category": "Dark"},
    {"image": "assets/wallpapers/dark6.jpg", "name": "Gothic Glam", "category": "Dark"},
    {"image": "assets/wallpapers/dark7.jpg", "name": "Twilight Tones", "category": "Dark"},
    {"image": "assets/wallpapers/dark8.jpg", "name": "Lunar Darkness", "category": "Dark"},
    {"image": "assets/wallpapers/dark9.jpg", "name": "Noir Vibes", "category": "Dark"},
    {"image": "assets/wallpapers/dark10.jpg", "name": "Edge of Night", "category": "Dark"},
    {"image": "assets/wallpapers/dark11.jpg", "name": "Velvet Night", "category": "Dark"},
    {"image": "assets/wallpapers/dark12.jpg", "name": "Phantom Veil", "category": "Dark"},
    {"image": "assets/wallpapers/dark13.jpg", "name": "Obsidian Echoes", "category": "Dark"},
    {"image": "assets/wallpapers/dark14.jpg", "name": "Darkness Unfolded", "category": "Dark"},
    {"image": "assets/wallpapers/dark15.jpg", "name": "Starlit Void", "category": "Dark"},
    {"image": "assets/wallpapers/dark16.jpg", "name": "Cloak of Darkness", "category": "Dark"},
    {"image": "assets/wallpapers/dark17.jpg", "name": "Stay With Me", "category": "Dark"},
    {"image": "assets/wallpapers/dark18.jpg", "name": "Escape", "category": "Dark"},
    {"image": "assets/wallpapers/dark19.jpg", "name": "Desire", "category": "Dark"},
    {"image": "assets/wallpapers/dark20.jpg", "name": "Losing You", "category": "Dark"},

  ];

  String selectedCategory = 'Quote'; // Default category

  Widget categoryButton(BuildContext context, String category) {
    final bool isSelected = category == selectedCategory;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        backgroundColor: isSelected ? Theme.of(context).primaryColor : Colors.white,
        foregroundColor: isSelected ? Colors.white : Theme.of(context).primaryColor,
        elevation: isSelected ? 6 : 4,
      ),
      child: Text(category),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredWallpapers = allWallpapers
        .where((wallpaper) => wallpaper["category"] == selectedCategory)
        .toList();

    return Scaffold(
      body: Column(
        children: [
          // Category filter buttons
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoryButton(context, 'Quote'),
                  SizedBox(width: 10),
                  categoryButton(context, 'Scenery'),
                  SizedBox(width: 10),
                  categoryButton(context, 'Cute'),
                  SizedBox(width: 10),
                  categoryButton(context, 'Doodle'),
                  SizedBox(width: 10),
                  categoryButton(context, 'Dark'),
                ],
              ),
            ),
          ),
          // Wallpaper grid display
          Expanded(
            child: filteredWallpapers.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: filteredWallpapers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return WallpaperCard(
                    image: filteredWallpapers[index]["image"]!,
                    name: filteredWallpapers[index]["name"]!,
                  );
                },
              ),
            )
                : Center(
              child: Text(
                'No wallpapers available for $selectedCategory',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WallpaperCard extends StatelessWidget {
  final String image;
  final String name;

  WallpaperCard({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WallpaperDetailPage(image: image, name: name),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,  // Use cover to make the image cover the whole space
                  alignment: Alignment.center, // Keeps the center of the image in focus
                  width: double.infinity, // Ensures the image stretches across the entire width of the card
                  height: double.infinity, // Ensures the image stretches across the entire height of the card
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

