import 'package:flutter/material.dart';
import 'package:restaurant_app_final/data/api/api_service.dart';
import 'package:restaurant_app_final/data/model/restaurant.dart';
import 'package:restaurant_app_final/data/model/restaurant_detail.dart';
import 'package:restaurant_app_final/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService});

  late RestaurantResult _restaurantResult;
  late RestaurantDetail _restaurantDetail;
  late RestaurantSearch _restaurantSearch;
  late ResultState _state;
  String _message = '';
  String _query = ' ';

  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  RestaurantDetail get detail => _restaurantDetail;
  RestaurantSearch get search => _restaurantSearch;
  ResultState get state => _state;

  RestaurantProvider getRestaurants() {
    _fetchRestaurants();
    return this;
  }

  RestaurantProvider getSearch() {
    _searchRestaurant();
    return this;
  }

  RestaurantProvider getRestaurant(String id) {
    _fetchRestaurant(id);
    return this;
  }

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.getList();
      if (article.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = article;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    }
  }

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetail(id);
      if (!response.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = response;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    }
  }

  Future<dynamic> _searchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getSearch(query: _query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    }
  }

  void onSearch(String query) {
    _query = query;
    _searchRestaurant();
  }
}
