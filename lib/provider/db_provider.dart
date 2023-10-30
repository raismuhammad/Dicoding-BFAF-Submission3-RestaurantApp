import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/database/database_helper.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class DbProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;

  List<Favorites> _favorites = [];
  List<Favorites> get favorites => _favorites;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorites();
  }

  ResultState _state = ResultState.noData;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  Future<bool> isFavorite(String id) async {
    final favoritedRestaurant = await _dbHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void _getAllFavorites() async {
    try {
      _favorites = await _dbHelper.getFavorites();
    notifyListeners();
    } catch (e) {
      _state = ResultState.noData;
      _message = "Data favorite masih kosong";
    }
    notifyListeners();
  }

  Future<void> addFavorites(Favorites favorites) async {
    try {
      await _dbHelper.insertFavorite(favorites);
      _getAllFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void deleteFavorite(String id) async {
    try {
      await _dbHelper.deleteFavorite(id);
      _getAllFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Error: $e";
      notifyListeners();
    }
  }
}
