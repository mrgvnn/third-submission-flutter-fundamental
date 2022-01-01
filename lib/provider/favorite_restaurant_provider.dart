import 'package:firstffasubmission/data/database/db_helper.dart';
import 'package:firstffasubmission/model/restaurant.dart';
import 'package:firstffasubmission/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantFavoriteProvider({this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  Restaurant _restaurant;
  Restaurant get restaurant => _restaurant;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavs();
    if (_favorite.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFav(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message =
      'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favorited = await databaseHelper.getFavbyId(id);
    return favorited?.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFav(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message =
      'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }
}
