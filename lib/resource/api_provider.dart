import 'package:dio/dio.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = "https://restaurant-api.dicoding.dev";

  // Future<RestaurantResult> fetchRestaurantList() async {
  //   try {
  //     Response response = await _dio.get(_url);
  //     return RestaurantResult.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error strackTrace: $stacktrace");
  //     return RestaurantResult.fromJson()
  //   }
  // }
}