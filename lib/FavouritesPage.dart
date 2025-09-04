import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'SavedWallpapersService.dart';
import 'WallpaperDetailPage.dart';
import 'InstallDynamicPage.dart';  // Import your InstallDynamicPage
import 'ExploreDetailPage.dart';   // Import ExploreDetailPage

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late SavedWallpapersService _service;
  List<String> savedWallpapers = [];
  Map<String, VideoPlayerController> videoControllers = {};

  @override
  void initState() {
    super.initState();
    _service = SavedWallpapersService();
    _loadSavedWallpapers();
  }

  Future<void> _loadSavedWallpapers() async {
    List<String> wallpapers = await _service.getSavedWallpapers();
    setState(() {
      savedWallpapers = wallpapers;
      _initializeVideoControllers();
    });
  }

  void _initializeVideoControllers() {
    for (String wallpaper in savedWallpapers) {
      if (wallpaper.endsWith('.mp4') && !videoControllers.containsKey(wallpaper)) {
        final controller = VideoPlayerController.asset(wallpaper);

        controller.initialize().then((_) {
          if (mounted) {
            setState(() {});
          }
          controller.setLooping(true);
          controller.play();
        }).catchError((error) {
          print("Error initializing video: $error");
        });

        videoControllers[wallpaper] = controller; // Correctly add the controller to the map
      }
    }
  }

  Future<void> _removeWallpaper(String wallpaper) async {
    if (videoControllers.containsKey(wallpaper)) {
      videoControllers[wallpaper]?.dispose();
      videoControllers.remove(wallpaper);
    }
    await _service.removeWallpaper(wallpaper);
    _loadSavedWallpapers();
  }

  @override
  void dispose() {
    for (var controller in videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/fav.png', // Replace with your desired image
                fit: BoxFit.cover,
                width: double.infinity,
                height: 110,
              ),
            ),
          ),
          savedWallpapers.isEmpty
              ? Center(child: Text('No wallpapers saved yet.'))
              : Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: savedWallpapers.length,
              itemBuilder: (context, index) {
                String wallpaper = savedWallpapers[index];
                bool isVideoWallpaper = wallpaper.endsWith('.mp4');
                bool isApiWallpaper = wallpaper.startsWith('http');  // Check if the wallpaper is from API

                String photographerName = 'Photographer $index'; // Assuming you fetch this info with the wallpaper URL

                return GestureDetector(
                  onTap: () {
                    if (isApiWallpaper) {
                      // Navigate to ExploreDetailPage for wallpapers fetched from API
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExploreDetailPage(
                            imageUrl: wallpaper,
                            photographer: photographerName, // Pass photographer name
                          ),
                        ),
                      );
                    } else if (isVideoWallpaper) {
                      // Navigate to InstallDynamicPage for video wallpapers
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstallDynamicPage(
                            selectedVideoPath: wallpaper,
                          ),
                        ),
                      );
                    } else {
                      // Navigate to wallpaper detail page for image wallpapers
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WallpaperDetailPage(
                            image: wallpaper,
                            name: 'Wallpaper $index',
                          ),
                        ),
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: isVideoWallpaper
                            ? videoControllers[wallpaper]?.value.isInitialized == true
                            ? AspectRatio(
                          aspectRatio: videoControllers[wallpaper]!.value.aspectRatio,
                          child: VideoPlayer(videoControllers[wallpaper]!),
                        )
                            : Center(child: CircularProgressIndicator())
                            : wallpaper.startsWith('http')
                            ? Image.network(
                          wallpaper,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Icon(Icons.error, color: Colors.red));
                          },
                        )
                            : Image.asset(
                          wallpaper,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _removeWallpaper(wallpaper),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
