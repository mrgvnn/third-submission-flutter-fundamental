import 'package:firstffasubmission/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/item_restaurant.dart';

class SearchBar extends StatefulWidget {
  static const routeName = '/search_bar';

  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<RestaurantProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantItem(
                        restaurant: state.result.restaurants[index],
                      );
                    },
                    padding: const EdgeInsets.only(top: kToolbarHeight + 24),
                    shrinkWrap: true,
                  ),
                  _searchAppbar(context, state)
                ],
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
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      child: const Text('Refresh'),
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
      ),
    );
  }

  Container _searchAppbar(BuildContext context, RestaurantProvider state) {
    return Container(
      height: kToolbarHeight + 20,
      padding: const EdgeInsets.only(top: 25),
      color: Colors.purple,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: _textSearch,
        textInputAction: TextInputAction.search,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          hintText: 'Cari Restoran Favoritmu',
          hintStyle: const TextStyle(
            color: Colors.white54,
          ),
        ),
        onSubmitted: (value) {
          state.setQuery(value);
        },
      ),
    );
  }

  @override
  void dispose() {
    _textSearch.dispose();
    super.dispose();
  }
}