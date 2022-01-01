import 'dart:convert';

import 'package:firstffasubmission/model/restaurant.dart';

import 'package:http/http.dart' show Client;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'https://restaurant-api.dicoding.dev/list';
  static const String detail = 'https://restaurant-api.dicoding.dev/detail/';
  static const String search = 'https://restaurant-api.dicoding.dev/search?q=';

  static const smallImage = 'https://restaurant-api.dicoding.dev/images/small/';
  static const mediumImage =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static const largeImage = 'https://restaurant-api.dicoding.dev/images/large/';

  Client client;
  ApiService({this.client}) {
    client ??= Client();
  }

  Future<RestaurantResult> getRestaurants() async {
    final response = await client.get(Uri.parse(list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
