// import 'package:firstffasubmission/model/restaurant.dart';
// import 'package:firstffasubmission/provider/favorite_restaurant_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class FavoriteButton extends StatelessWidget {
//   final Restaurant favorite;
//
//   const FavoriteButton({this.favorite});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RestaurantFavoriteProvider>(
//       builder: (context, provider, child) {
//         return FutureBuilder<bool>(
//           future: provider.isFavorited(favorite.id),
//           builder: (context, snapshot) {
//             var isFavorite = snapshot.data ?? false;
//             return isFavorite
//                 ? InkWell(
//               onTap: () {
//                 provider.removeRestaurant(favorite.id);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 margin: const EdgeInsets.all(10),
//                 child: const Icon(
//                   Icons.favorite_rounded,
//                   color: Colors.red,
//                 ),
//               ),
//             )
//                 : InkWell(
//               onTap: () {
//                 provider.addRestaurant(favorite);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 margin: const EdgeInsets.all(10),
//                 child: const Icon(
//                   Icons.favorite_outline_rounded,
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }