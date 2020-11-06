import 'dart:convert';

import 'package:http/http.dart' as http;

final String BASE_URL = "https://api.giphy.com/v1/gifs";
final API_KEY = "PSCIKvK1nPk5X9tTEW0m5WrCiADgA2NY";

Future<Map<String, dynamic>> getTreending(int limit, String rating) async {
  String query = "/trending?api_key=$API_KEY&limit=$limit&rating=$rating";
  http.Response response = await http.get(BASE_URL + query);

  return json.decode(response.body);
}

Future<Map<String, dynamic>> getSearch(
    int limit, String rating, String text) async {
  String query = "/search?api_key=$API_KEY&limit=$limit&rating=$rating&q=$text";
  http.Response response = await http.get(BASE_URL + query);

  return json.decode(response.body);
}
