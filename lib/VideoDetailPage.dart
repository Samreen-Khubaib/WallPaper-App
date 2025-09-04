import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'InstallDynamicPage.dart';
import 'SavedWallpapersService.dart'; // Import your service for saving wallpapers

class VideoDetailPage extends StatefulWidget {
  final String videoPath;
  final String name;

  VideoDetailPage({required this.videoPath, required this.name});

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Video player background
          Positioned.fill(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Center(child: CircularProgressIndicator()),
          ),

          // Action buttons (Set Wallpaper & Save)
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
                          builder: (context) => InstallDynamicPage(
                            selectedVideoPath: widget.videoPath,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Set as Wallpaper'),
                        SizedBox(width: 10),
                        Icon(Icons.wallpaper),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  // Save Wallpaper Button
                  ElevatedButton(
                    onPressed: () async {
                      await SavedWallpapersService().saveWallpaper(widget.videoPath);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Dynamic wallpaper saved!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
