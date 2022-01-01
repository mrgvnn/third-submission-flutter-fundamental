import 'package:firstffasubmission/data/api/api_service.dart';
import 'package:firstffasubmission/provider/detail_restaurant_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget{
  static const routeName = '/detail_screen';
  final String id;
  const DetailScreen({key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(context, id:id),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              final result = Provider.of<RestaurantDetailProvider>(context);
              return SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Image.network(
                          ApiService.largeImage + state.result.restaurant.pictureId,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(

                          color: Colors.purple,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                result.result.restaurant.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.muli(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  result.result.restaurant.description,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "Minuman : ",
                                  style: GoogleFonts.muli(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: result.result.restaurant.menus.drinks
                                        .map((drink) => Text(
                                              drink.name,
                                              style: const TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ))
                                        .toList(),
                                  )),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "Makanan : ",
                                  style: GoogleFonts.muli(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: result.result.restaurant.menus.foods
                                        .map((food) => Text(
                                              food.name,
                                              style: const TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ))
                                        .toList(),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 30),
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
          },
        ),
      ),
    );
  }
}

