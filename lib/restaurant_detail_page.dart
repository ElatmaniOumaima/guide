import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (restaurant['images'] != null && (restaurant['images'] as List).isNotEmpty)
              Container(
                height: 200,
                child: PageView.builder(
                  itemCount: restaurant['images'].length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      restaurant['images'][index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 50);
                      },
                    );
                  },
                ),
              )
            else
              Icon(Icons.broken_image, size: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    restaurant['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('Stars: ${restaurant['stars']}'),
                  SizedBox(height: 10),
                  Text('Cuisines Served: ${restaurant['cuisinesServed'].join(', ')}'),
                  SizedBox(height: 10),
                  Text('Phone: ${restaurant['phoneNumber']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
