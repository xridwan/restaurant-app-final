import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app_final/data/model/restaurant.dart';
import 'package:restaurant_app_final/data/model/restaurant_detail.dart';
import 'package:restaurant_app_final/utils/config.dart';

class ApiService {
  Future<RestaurantResult> getList() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}list'));
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed get data");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<RestaurantSearch> getSearch({String query = " "}) async {
    try {
      final response =
          await http.get(Uri.parse('${Config.baseUrl}search?q=$query'));
      if (response.statusCode == 200) {
        return RestaurantSearch.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed get data");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<RestaurantDetail> getDetail(String id) async {
    final response = await http.get(Uri.parse("${Config.baseUrl}detail/$id"));
    try {
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed get data");
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
