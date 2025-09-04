// unsplash_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

const String unsplashApiKey = "o4EbqfWzTpKCHQoEPQZztwc1CpP4HIT7CTCY5jjppl8"; // Replace with your Unsplash API key.
const String unsplashBaseUrl = "https://api.unsplash.com/";

Future<List<dynamic>> fetchUnsplashWallpapers(String query, {int perPage = 20}) async {
  final url = Uri.parse("${unsplashBaseUrl}search/photos?query=$query&per_page=$perPage");

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Client-ID $unsplashApiKey',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['results']; // The wallpapers are under the 'results' key.
  } else {
    throw Exception('Failed to fetch wallpapers. Status code: ${response.statusCode}');
  }
}
