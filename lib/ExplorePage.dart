import 'package:flutter/material.dart';
import 'pexels_service.dart';
import 'unsplash_service.dart';
import 'ExploreDetailPage.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Future<List<dynamic>>? wallpapers;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch wallpapers with a default query, such as "nature."
    wallpapers = fetchWallpapers("nature");
  }

  // Combine wallpapers from both Pexels and Unsplash
  Future<List<dynamic>> fetchWallpapers(String query) async {
    try {
      final pexelsWallpapers = await fetchPexelsWallpapers(query); // Pexels call
      final unsplashWallpapers = await fetchUnsplashWallpapers(query);  // Unsplash call

      // Combine results from both APIs
      return [...pexelsWallpapers, ...unsplashWallpapers];
    } catch (e) {
      throw Exception('Failed to fetch wallpapers from both APIs: $e');
    }
  }

  void searchWallpapers(String query) {
    setState(() {
      wallpapers = fetchWallpapers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search wallpapers...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,  // Set border color to theme color
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1), // Set background color to a light theme color
              ),
              onSubmitted: (value) {
                searchWallpapers(value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: wallpapers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final wallpapers = snapshot.data!;
                  return wallpapers.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: wallpapers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        final wallpaper = wallpapers[index];
                        final imageUrl = wallpaper['src'] != null
                            ? wallpaper['src']['medium']
                            : wallpaper['urls']['regular']; // Handle different API structures
                        final photographer = wallpaper['photographer'] != null
                            ? wallpaper['photographer']
                            : wallpaper['user']['name']; // Handle different API structures
                        return WallpaperCard(
                          imageUrl: imageUrl,
                          photographer: photographer,
                          onTap: () {
                            // Navigate to the detail page on tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExploreDetailPage(
                                  imageUrl: wallpaper['src'] != null
                                      ? wallpaper['src']['original']
                                      : wallpaper['urls']['full'],
                                  photographer: photographer,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                      : Center(
                    child: Text(
                      'No wallpapers available',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WallpaperCard extends StatelessWidget {
  final String imageUrl;
  final String photographer;
  final VoidCallback onTap;

  WallpaperCard({required this.imageUrl, required this.photographer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                photographer,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
