import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/db_provider.dart';

class FavoriteListPage extends StatelessWidget {
  static const routeName = "/favoriteListPage";
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Your Favorite",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<DbProvider>(builder: (context, provider, child) {
        final favorites = provider.favorites;

        return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return Padding(
                padding: EdgeInsets.only(right: 18, left: 18),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                    leading: Hero(
                      tag: favorite.pictureId,
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/" +
                            favorite.pictureId,
                        width: 100,
                      ),
                    ),
                    title: Text(favorite.name),
                  ),
                ),
              );
            });
      }),
    );
  }
}
