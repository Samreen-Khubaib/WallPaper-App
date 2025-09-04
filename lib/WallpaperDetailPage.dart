import 'package:flutter/material.dart';
import 'InstallWallpaperPage.dart'; // Update to match your specific detail page
import 'SavedWallpapersService.dart'; // Import the service for saving wallpapers

class WallpaperDetailPage extends StatelessWidget {
  final String image;
  final String name;

  WallpaperDetailPage({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Set Wallpaper Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InstallWallpaperPage(selectedImage: image),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Set Wallpaper'),
                        SizedBox(width: 10),
                        Icon(Icons.wallpaper),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  // Save Wallpaper Button
                  ElevatedButton(
                    onPressed: () async {
                      await SavedWallpapersService().saveWallpaper(image);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Wallpaper saved!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Save'),
                        SizedBox(width: 10),
                        Icon(Icons.favorite),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
