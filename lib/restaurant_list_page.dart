import 'package:flutter/material.dart';

class RestaurantListPage extends StatelessWidget {
  final String city;

  const RestaurantListPage({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants in $city'),
      ),
      body: Center(
        child: Text('List of restaurants in $city'),
      ),
    );
  }
}
