import 'package:firstffasubmission/data/api/api_service.dart';
import 'package:firstffasubmission/model/restaurant.dart';
import 'package:firstffasubmission/provider/favorite_restaurant_provider.dart';
import 'package:firstffasubmission/theme/theme.dart';
import 'package:firstffasubmission/ui/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavoriteProvider>(
        builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavorited(restaurant.id),
            builder: (context, snapshot) {
              var isFav = snapshot.data ?? false;
            return Material(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailScreen(
                      id: restaurant.id,
                    );
                  }));
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                        child: Container(
                          width: 150,
                          height: 150,
                          child: ClipRRect(
                            child: Image.network(ApiService.smallImage + restaurant.pictureId),
                          ),
                        ),
                      ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                size: 16,
                              ),
                              Text(
                                restaurant.city,
                                style: orangeTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                              ),
                              Text(
                                restaurant.rating.toString(),
                                style: orangeTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        icon: isFav
                            ? IconButton(
                          onPressed: () =>
                              provider.removeFavorite(restaurant.id),
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        )
                            : IconButton(
                          onPressed: () =>
                              provider.addFavorite(restaurant),
                          icon: const Icon(Icons.favorite_border),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
