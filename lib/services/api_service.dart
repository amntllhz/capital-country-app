import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class ApiService {
  Future<List<Country>> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((country) => Country(
                name: country['name']['common'],
                capital:
                    country['capital'] != null ? country['capital'][0] : 'N/A',
                region: country['region'],
                flagUrl: country['flags']['png'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
