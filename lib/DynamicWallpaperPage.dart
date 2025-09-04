import 'package:flutter/material.dart';
import 'VideoDetailPage.dart';

class DynamicWallpaperPage extends StatefulWidget {
  @override
  _DynamicWallpaperPageState createState() => _DynamicWallpaperPageState();
}

class _DynamicWallpaperPageState extends State<DynamicWallpaperPage> {
  final Map<String, List<Map<String, String>>> categories = {
    'Warm': [
      {"video": "assets/videos/warm1.mp4", "name": "Solitude Scapes", "preview": "assets/dynamic/warm1.jpg"},
      {"video": "assets/videos/warm2.mp4", "name": "Golden Quiet", "preview": "assets/dynamic/warm2.jpg"},
      {"video": "assets/videos/warm3.mp4", "name": "Eclipse Frames", "preview": "assets/dynamic/warm3.jpg"},
      {"video": "assets/videos/warm7.mp4", "name": "Aesthetic Echo", "preview": "assets/dynamic/warm4.jpg"},
      {"video": "assets/videos/warm4.mp4", "name": "Warm Horizon", "preview": "assets/dynamic/warm5.jpg"},
      {"video": "assets/videos/warm5.mp4", "name": "Lonely Light", "preview": "assets/dynamic/warm6.jpg"},
      {"video": "assets/videos/warm6.mp4", "name": "Ethereal Glow", "preview": "assets/dynamic/warm7.jpg"},
      {"video": "assets/videos/warm8.mp4", "name": "Soft Shadows", "preview": "assets/dynamic/warm8.jpg"},
      {"video": "assets/videos/warm9.mp4", "name": "Amber Silence", "preview": "assets/dynamic/warm9.jpg"},
      {"video": "assets/videos/warm10.mp4", "name": "Dusky Dreams", "preview": "assets/dynamic/warm10.jpg"},
      {"video": "assets/videos/warm11.mp4", "name": "Gloom & Glow", "preview": "assets/dynamic/warm11.jpg"},
      {"video": "assets/videos/warm12.mp4", "name": "Still Serenity", "preview": "assets/dynamic/warm12.jpg"},
      {"video": "assets/videos/warm13.mp4", "name": "Muted Vibes", "preview": "assets/dynamic/warm13.jpg"},
      {"video": "assets/videos/warm14.mp4", "name": "Lonely Aesthetics", "preview": "assets/dynamic/warm14.jpg"},
      {"video": "assets/videos/warm15.mp4", "name": "Whispering Light", "preview": "assets/dynamic/warm15.jpg"},
      {"video": "assets/videos/warm16.mp4", "name": "Glow of Alone", "preview": "assets/dynamic/warm16.jpg"},
      {"video": "assets/videos/warm17.mp4", "name": "Fading Warmth", "preview": "assets/dynamic/warm17.jpg"},
      {"video": "assets/videos/warm18.mp4", "name": "Inferno Grace", "preview": "assets/dynamic/warm18.jpg"},
      {"video": "assets/videos/warm19.mp4", "name": "Aurora Sparks", "preview": "assets/dynamic/warm19.jpg"},
      {"video": "assets/videos/warm20.mp4", "name": "Gilded Hues", "preview": "assets/dynamic/warm20.jpg"},

    ],
    'Anime': [
      {"video": "assets/videos/anime1.mp4", "name": "AnimeScape", "preview": "assets/dynamic/anime1.jpg"},
      {"video": "assets/videos/anime2.mp4", "name": "KawaiiWall", "preview": "assets/dynamic/anime2.jpg"},
      {"video": "assets/videos/anime3.mp4", "name": "Anime Aura", "preview": "assets/dynamic/anime3.jpg"},
      {"video": "assets/videos/anime4.mp4", "name": "OtakuWalls", "preview": "assets/dynamic/anime4.jpg"},
      {"video": "assets/videos/anime5.mp4", "name": "Shonen Shimmer", "preview": "assets/dynamic/anime5.jpg"},
      {"video": "assets/videos/anime6.mp4", "name": "Neon Nippon", "preview": "assets/dynamic/anime6.jpg"},
      {"video": "assets/videos/anime7.mp4", "name": "Anime Haven", "preview": "assets/dynamic/anime7.jpg"},
      {"video": "assets/videos/anime8.mp4", "name": "Anime Realm", "preview": "assets/dynamic/anime8.jpg"},
      {"video": "assets/videos/anime9.mp4", "name": "Gojo", "preview": "assets/dynamic/anime9.jpg"},
      {"video": "assets/videos/anime10.mp4", "name": "Fantasy Rift", "preview": "assets/dynamic/anime10.jpg"},


    ],
    'Nature': [
      {"video": "assets/videos/nature1.mp4", "name": "Green Horizons", "preview": "assets/dynamic/nature1.jpg"},
      {"video": "assets/videos/nature2.mp4", "name": "NatureScape", "preview": "assets/dynamic/nature2.jpg"},
      {"video": "assets/videos/nature3.mp4", "name": "Wilderness Art", "preview": "assets/dynamic/nature3.jpg"},
      {"video": "assets/videos/nature4.mp4", "name": "Earthly Canvas", "preview": "assets/dynamic/nature4.jpg"},
      {"video": "assets/videos/nature5.mp4", "name": "Bloom Walls", "preview": "assets/dynamic/nature5.jpg"},
      {"video": "assets/videos/nature6.mp4", "name": "Skyline Serenity", "preview": "assets/dynamic/nature6.jpg"},
      {"video": "assets/videos/nature7.mp4", "name": "Breezy Canvas", "preview": "assets/dynamic/nature7.jpg"},
      {"video": "assets/videos/nature8.mp4", "name": "Nature Zephyr", "preview": "assets/dynamic/nature8.jpg"},
      {"video": "assets/videos/nature9.mp4", "name": "Serenity Frames", "preview": "assets/dynamic/nature9.jpg"},
      {"video": "assets/videos/nature10.mp4", "name": "Scenic Aura", "preview": "assets/dynamic/nature10.jpg"},
      {"video": "assets/videos/nature11.mp4", "name": "Petal Whispers", "preview": "assets/dynamic/nature11.jpg"},
      {"video": "assets/videos/nature12.mp4", "name": "Mystic Glade", "preview": "assets/dynamic/nature12.jpg"},
      {"video": "assets/videos/nature13.mp4", "name": "Lakeside Dreams", "preview": "assets/dynamic/nature13.jpg"},
      {"video": "assets/videos/nature14.mp4", "name": "Oceanic Bliss", "preview": "assets/dynamic/nature14.jpg"},

    ],

  };

  String selectedCategory = 'Warm'; // Default category

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
    return Scaffold(
      body: Column(
        children: [
          // Category filter buttons (Navbar)
          // Category filter buttons (Navbar)
          // Category filter buttons (Navbar)
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity, // Ensures the navbar takes full width
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centers the buttons in the Row
              children: categories.keys.take(3).map((category) { // Display only the first 3 categories (optional)
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: categoryButton(context, category),
                );
              }).toList(),
            ),
          ),


          // Wallpaper grid display
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.6, // Adjusted to make the grid items taller
              ),
              itemCount: categories[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  final wallpaper = categories[selectedCategory]![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoDetailPage(
                            videoPath: wallpaper['video']!,
                            name: wallpaper['name']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), // Round the corners of the card
                      ),
                      elevation: 4.0, // Optional: Elevation for a shadow effect
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0), // Round the corners of the content
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                wallpaper['preview']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                wallpaper['name']!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

            ),
          ),
        ],
      ),
    );
  }


}
