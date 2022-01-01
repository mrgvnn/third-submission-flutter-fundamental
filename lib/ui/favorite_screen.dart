import 'package:firstffasubmission/data/database/db_helper.dart';
import 'package:firstffasubmission/provider/favorite_restaurant_provider.dart';
import 'package:firstffasubmission/provider/restaurant_provider.dart';
import 'package:firstffasubmission/ui/widget/item_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = '/favorite_screen';

  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantFavoriteProvider>(
      create: (_) => RestaurantFavoriteProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            'Favorite Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return RestaurantItem(
                restaurant: provider.favorite[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
