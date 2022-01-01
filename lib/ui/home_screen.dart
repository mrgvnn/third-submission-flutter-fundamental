import 'package:firstffasubmission/provider/restaurant_provider.dart';
import 'package:firstffasubmission/ui/widget/drawer_menu.dart';
import 'package:firstffasubmission/ui/widget/item_restaurant.dart';
import 'package:firstffasubmission/ui/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer;


class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  const HomeScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Api'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchBar.routeName);
              },
            ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: Consumer<RestaurantProvider>(builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantItem(
                  restaurant: state.result.restaurants[index],
                );
              },
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.NoConnection) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    child: Text('Refresh'),
                    onPressed: () {
                      state.refresh();
                    },
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        }),
      ),
    );
  }
}