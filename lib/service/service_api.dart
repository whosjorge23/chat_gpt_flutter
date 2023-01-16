import 'dart:convert';

import 'package:chat_gpt_flutter/model/country.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  final String baseUrl = 'https://api.nationalize.io/';

  Future<List<Country>> fetchName(String name) async {
    var uri = Uri.parse('$baseUrl?name=$name');
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body);
    return (jsonResponse['country'] as List)
        .map((e) => Country.fromJson(e))
        .toList();
  }
}
