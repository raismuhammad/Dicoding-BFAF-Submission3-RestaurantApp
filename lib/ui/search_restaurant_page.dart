import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widgets/card_search.dart';

class SearchRestaurantPage extends StatefulWidget {
  static const routeName = "/SearchRestaurantPage";

  const SearchRestaurantPage({super.key});

  @override
  State<SearchRestaurantPage> createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  String query = "";
  late TextEditingController _editingController;

  @override
  void initState() {
    // TODO: implement initState
    _editingController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _editingController.dispose();
    super.dispose();
  }

  Widget _seachState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Consumer<SearchProvider>(
        builder: (context, state, _) {
          return TextField(
            // controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFFc80064),
              ),
              filled: true,
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: 'Search',
              fillColor: Colors.white,
            ),
            onChanged: (text) {
              setState(
                () {
                  state.fetchAllSearch(text);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Consumer<SearchProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              if (state.result.founded != 0) {
                return ListView.builder(
                    itemCount: state.result.founded,
                    itemBuilder: (BuildContext context, index) {
                      var restaurant = state.result.restaurants[index];
                      return CardSearch(restaurant: restaurant);
                    });
              } else {
                return const Material(
                  child: Text('No Data'),
                );
              }
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text('Check your connection'),
                ),
              );
            } else {
              return const Center(
                child: Material(
                  child: SizedBox(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _seachState(context),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SizedBox(height: MediaQuery.of(context).size.height, child: _buildList(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
