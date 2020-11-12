import "package:eskap_app/models/suggestion.dart";
import "package:eskap_app/models/place.dart";
import "package:http/http.dart";
import "dart:convert";
import "dart:io";

class PlaceApiProvider {
  final client = Client();

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request = 'https://api-adresse.data.gouv.fr/search/?q=$input';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result != null) {
        return result['features']
            .map<Suggestion>((p) =>
                Suggestion(p["properties"]["id"], p["properties"]["label"]))
            .toList();
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
