import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class InstallWallpaperPage extends StatelessWidget {
  final String selectedImage;

  InstallWallpaperPage({required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Set Wallpaper',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 600,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(selectedImage),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                await _requestPermission();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await _setWallpaper(
                                  selectedImage,
                                  WallpaperManager.HOME_SCREEN,
                                  context,
                                );
                              },
                              icon: Icon(Icons.home, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              label: Text(
                                'Set on Home Screen',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await _setWallpaper(
                                  selectedImage,
                                  WallpaperManager.LOCK_SCREEN,
                                  context,
                                );
                              },
                              icon: Icon(Icons.lock, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              label: Text(
                                'Set on Lock Screen',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await _setWallpaper(
                                  selectedImage,
                                  WallpaperManager.BOTH_SCREEN,
                                  context,
                                );
                              },
                              icon: Icon(Icons.wallpaper, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              label: Text(
                                'Set on Both Screens',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.wallpaper, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              label: Text(
                'Set Wallpaper',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Set Wallpaper
  Future<void> _setWallpaper(String imagePath, int location, BuildContext context) async {
    try {
      ByteData bytes = await rootBundle.load(imagePath);
      final tempPath = '/storage/emulated/0/Download/temp_wallpaper.png';
      final file = await File(tempPath).writeAsBytes(bytes.buffer.asUint8List());

      bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wallpaper Set Successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Set Wallpaper')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Request Permissions
  Future<void> _requestPermission() async {
    await Permission.storage.request();
  }
}
