import 'package:shared_preferences/shared_preferences.dart';

class SavedWallpapersService {
  // Save wallpaper to SharedPreferences
  Future<void> saveWallpaper(String wallpaperPath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Get current saved wallpapers
      List<String> savedWallpapers = prefs.getStringList('savedWallpapers') ?? [];

      // Avoid saving duplicates
      if (!savedWallpapers.contains(wallpaperPath)) {
        savedWallpapers.add(wallpaperPath);
        await prefs.setStringList('savedWallpapers', savedWallpapers);
      }
    } catch (e) {
      print("Error saving wallpaper: $e");
    }
  }

  // Get all saved wallpapers
  Future<List<String>> getSavedWallpapers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList('savedWallpapers') ?? [];
    } catch (e) {
      print("Error retrieving saved wallpapers: $e");
      return []; // Return an empty list in case of error
    }
  }

  // Remove wallpaper from SharedPreferences
  Future<void> removeWallpaper(String wallpaperPath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> savedWallpapers = prefs.getStringList('savedWallpapers') ?? [];

      // Remove wallpaper and save updated list
      savedWallpapers.remove(wallpaperPath);
      await prefs.setStringList('savedWallpapers', savedWallpapers);
    } catch (e) {
      print("Error removing wallpaper: $e");
    }
  }
}
