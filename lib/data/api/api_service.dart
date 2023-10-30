import 'package:dio/dio.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/search.dart';

class ApiService {

  static const baseUrl = "https://restaurant-api.dicoding.dev";
  static const _imageSmall = "https://restaurant-api.dicoding.dev/images/small/";
  static const _imageMedium = "https://restaurant-api.dicoding.dev/images/small/";
  static const _imageLarge = "https://restaurant-api.dicoding.dev/images/small/<pictureId>";

  ApiService(http.Client client);

  Future<RestaurantResult> restaurantlist() async {
    final response = await http.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }

  }

  Future<RestaurantDetailResult> restaurantDetailResult(String id) async {
    final response = await http.get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Data');
    }
  }

  Future fetchSearch(String path) async {
    final response = await http.get(Uri.parse(baseUrl + path));

    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search Restaurant');
    }
  }

}