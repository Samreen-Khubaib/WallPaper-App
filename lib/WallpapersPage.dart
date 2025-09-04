import 'package:flutter/material.dart';
import 'StaticWallpaperPage.dart'; // Import Static Wallpaper Page
import 'DynamicWallpaperPage.dart'; // Import Dynamic Wallpaper Page

class WallpapersPage extends StatefulWidget {
  @override
  _WallpapersPageState createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs: Static and Dynamic
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: TabBar(
          controller: _tabController,
          indicator: CustomTabIndicator(
            color: Colors.purple[800]!,
            radius: 20,
            width: 120,
          ),
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            Tab(
              child: Text(
                'Static',
                style: TextStyle(
                  fontFamily: 'BaguetScript', // Apply the custom font
                  fontSize: 18, // Adjust the size as needed
                  fontWeight: FontWeight.bold, // Optional: Add weight for emphasis
                ),
              ),
            ),
            Tab(
              child: Text(
                'Dynamic',
                style: TextStyle(
                  fontFamily: 'BaguetScript', // Apply the custom font
                  fontSize: 18, // Adjust the size as needed
                  fontWeight: FontWeight.bold, // Optional
                ),
              ),
            ),

          ],
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StaticWallpaperPage(), // Use StaticWallpaperPage
          DynamicWallpaperPage(), // Use DynamicWallpaperPage
        ],
      ),
    );
  }
}

class CustomTabIndicator extends Decoration {
  final Color color;
  final double radius;
  final double width;

  CustomTabIndicator({
    required this.color,
    this.radius = 0.0,
    this.width = 100.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(color: color, radius: radius, width: width);
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final Color color;
  final double radius;
  final double width;

  _CustomTabIndicatorPainter({
    required this.color,
    this.radius = 0.0,
    this.width = 100.0,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double height = configuration.size!.height;
    final double centerX = offset.dx + configuration.size!.width / 2;
    final Rect rect = Rect.fromCenter(
      center: Offset(centerX, height / 2),
      width: width,
      height: height * 0.8,
    );

    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rRect, paint);
  }
}