import "package:eskap_app/models/suggestion.dart";
import "package:eskap_app/models/place.dart";
import "package:http/http.dart";
import "dart:convert";

class PlaceApiProvider {
  final client = Client();

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request = 'https://api-adresse.data.gouv.fr/search/?q=$input';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result != null) {
        print(result["features"][0]); //display the result
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

  Future<Place> getPlaceDetailFromCompleteAdress(String description) async {
    final request = 'https://api-adresse.data.gouv.fr/search/?q=$description';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result != null) {
        final Place place = Place();
        place.addresse = result["features"][0]["properties"]["label"];
        place.long = result["features"][0]["geometry"]["coordinates"][0];
        place.lat = result["features"][0]["geometry"]["coordinates"][1];
        place.id = (result["features"][0]["properties"]["id"]);
        // C'est le code postal pour l'instant :/
        print(place);
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
