import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/search.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class CardSearch extends StatelessWidget {
  final Restaurant restaurant;

  const CardSearch({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
          leading: Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              "https://restaurant-api.dicoding.dev/images/medium/" + restaurant.pictureId,
              width: 100,
            ),
          ),
          title: Text(
            restaurant.name,
          ),
          subtitle: Row(children: [
            Image.network(height: 20,"https://i.pinimg.com/originals/98/4d/22/984d22fce5cae2c01473f4abe8063fd1.png"),
            Text(restaurant.rating.toString()),
          ],),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(id: restaurant.id,);
          }))
          ),
        ),
      );
  }
}