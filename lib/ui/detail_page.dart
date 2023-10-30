import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  
  const DetailPage({super.key, required this.id});
  final String id;
  final isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(http.Client()),
        id: id,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.state == ResultState.hasData) {
                var restaurantDetail = state.result.restaurant;
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Detail Restaurant'),
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  "https://restaurant-api.dicoding.dev/images/large/" +
                                      restaurantDetail.pictureId),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      restaurantDetail.name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_border,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(restaurantDetail.city),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Image.network(
                                          height: 20,
                                          "https://i.pinimg.com/originals/98/4d/22/984d22fce5cae2c01473f4abe8063fd1.png"),
                                      Text(restaurantDetail.rating.toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 18),
                                  child: Text(
                                    restaurantDetail.description,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: Text(
                                    "Menu Makanan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        restaurantDetail.menus.foods.length,
                                    itemBuilder: (context, index) {
                                      var foods =
                                          restaurantDetail.menus.foods[index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Center(child: Text(foods.name)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: Text(
                                    "Menu Minuman :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        restaurantDetail.menus.drinks.length,
                                    itemBuilder: (context, index) {
                                      var drinks =
                                          restaurantDetail.menus.drinks[index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Center(child: Text(drinks.name)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: Text(
                                    "Customer Review :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        restaurantDetail.customerReviews.length,
                                    itemBuilder: (context, index) {
                                      var customerReview = restaurantDetail
                                          .customerReviews[index];
                                      return Card(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text(customerReview.name),
                                                  Text(customerReview.review),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Check your connection'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
