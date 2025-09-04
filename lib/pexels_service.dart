import 'dart:convert';
import 'package:http/http.dart' as http;


const String apiKey = "voWWtTjsdtbyS7eCJc2qFmLlTJvkC0QHmOItPTXbU91rebNouJOg1I2K";
const String baseUrl = "https://api.pexels.com/v1/";

Future<List<dynamic>> fetchPexelsWallpapers(String query, {int perPage = 20}) async {
  final url = Uri.parse("${baseUrl}search?query=$query&per_page=$perPage");

  final response = await http.get(
    url,
    headers: {
      'Authorization': apiKey,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['photos']; // The wallpapers are under the 'photos' key.
  } else {
    throw Exception('Failed to fetch wallpapers. Status code: ${response.statusCode}');
  }
}
