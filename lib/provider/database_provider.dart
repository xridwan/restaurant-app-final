import 'package:flutter/material.dart';
import 'package:restaurant_app_final/data/db/database_helper.dart';
import 'package:restaurant_app_final/data/model/restaurant.dart';
import 'package:restaurant_app_final/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookmarks();
    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addBookmark(Restaurant article) async {
    try {
      await databaseHelper.insertBookmark(article);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarkedArticle = await databaseHelper.getBookmarkByUrl(url);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeBookmark(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
