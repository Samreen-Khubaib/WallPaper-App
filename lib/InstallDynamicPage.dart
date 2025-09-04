import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart'; // Added for device info

class InstallDynamicPage extends StatefulWidget {
  final String selectedVideoPath;

  InstallDynamicPage({required this.selectedVideoPath});

  @override
  _InstallDynamicPageState createState() => _InstallDynamicPageState();
}

class _InstallDynamicPageState extends State<InstallDynamicPage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    requestPermissions(context);
    _initializeVideo(widget.selectedVideoPath);
  }

  Future<void> requestPermissions(BuildContext context) async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 30) {
        // Android 11+ (API 30 and above)
        if (await Permission.manageExternalStorage
            .request()
            .isGranted) {
          print("Manage External Storage permission granted");
        } else {
          _showPermissionSnackbar(context);
        }
      } else {
        // Android 10 and below
        if (await Permission.storage
            .request()
            .isGranted) {
          print("Storage permission granted");
        } else {
          _showPermissionSnackbar(context);
        }
      }
    } else {
      print("Non-Android platform detected, permissions not required.");
    }
  }

  void _showPermissionSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Storage permission is required to set wallpaper."),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _initializeVideo(String videoPath) {
    _controller?.dispose(); // Dispose existing controller
    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        setState(() {}); // Refresh UI after initialization
        _controller?.setLooping(true);
        _controller?.play(); // Auto-play video
      });
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose to free resources
    super.dispose();
  }

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
          'Set Dynamic Wallpaper',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 600, // Fixed height for video container
                width: 300,  // Fixed width for video container
                decoration: BoxDecoration(
                  color: Colors.blue.shade50, // Background color while loading
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: _controller?.value.isInitialized ?? false
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Apply rounded corners
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                )
                    : Center(child: CircularProgressIndicator()), // Show loader while loading
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ElevatedButton(
              onPressed: _setWallpaper, // Call _setWallpaper method directly
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Set Dynamic Wallpaper',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setWallpaper() async {
    try {
      final directory = await getTemporaryDirectory();
      final tempPath = '${directory.path}/temp_wallpaper.mp4';
      final byteData = await DefaultAssetBundle.of(context).load(
          widget.selectedVideoPath);
      final file = await File(tempPath).writeAsBytes(
          byteData.buffer.asUint8List());

      // Set wallpaper without unsupported parameters
      bool result = await AsyncWallpaper.setLiveWallpaper(
        filePath: file.path, // Set for both screens by default
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result
            ? 'Wallpaper Set Successfully!'
            : 'Failed to Set Wallpaper.'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error setting wallpaper: $e'),
      ));
    }
  }
}
