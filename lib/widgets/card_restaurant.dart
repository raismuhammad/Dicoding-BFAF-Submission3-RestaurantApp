import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
      builder: (_, provider, __) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (_, snapshot) {
            final isFavorite = snapshot.data ?? false;

            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                    leading: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/" +
                            restaurant.pictureId,
                        width: 100,
                      ),
                    ),
                    title: Text(
                      restaurant.name,
                    ),
                    subtitle: Row(
                      children: [
                        Image.network(
                            height: 20,
                            "https://i.pinimg.com/originals/98/4d/22/984d22fce5cae2c01473f4abe8063fd1.png"),
                        Text(restaurant.rating.toString()),
                      ],
                    ),
                    trailing: isFavorite
                        ? IconButton(
                            onPressed: () =>
                                provider.deleteFavorite(restaurant.id),
                            color: Colors.pink,
                            icon: const Icon(Icons.favorite))
                        : IconButton(
                            onPressed: () => provider.addFavorites(
                              Favorites(
                                id: restaurant.id,
                                name: restaurant.name,
                                pictureId: restaurant.pictureId,
                              ),
                            ),
                            color: Colors.pink,
                            icon: const Icon(Icons.favorite_border),
                          ),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailPage(
                            id: restaurant.id,
                          );
                        }))),
              ),
            );
          },
        );
      },
    );
  }
// }
}
