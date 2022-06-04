import 'package:ejemplo/data/models/character.dart';
import 'package:http/http.dart' as http;

class CharacterService {
  Future<List<Character>> getAll() {
    return http
        .get(Uri.parse("https://thronesapi.com/api/v2/Characters"))
        .then((response) => charactersFromJson(response.body));
  }
}
