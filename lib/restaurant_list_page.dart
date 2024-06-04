import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'restaurant_detail_page.dart'; // Import your RestaurantDetailPage

class RestaurantListPage extends StatelessWidget {
  final String city;

  const RestaurantListPage({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants in $city'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('restaurants').where('city', isEqualTo: city).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var restaurants = snapshot.data!.docs;

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = restaurants[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: restaurant['images'] != null && (restaurant['images'] as List).isNotEmpty
                      ? Image.network(
                          restaurant['images'][0],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50);
                          },
                        )
                      : Icon(Icons.broken_image, size: 50),
                  title: Text(
                    restaurant['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${restaurant['stars']} stars'),
                      Text('Cuisines: ${restaurant['cuisinesServed'].join(', ')}'),
                      Text('Phone: ${restaurant['phoneNumber']}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailPage(restaurant: restaurant),
                        ),
                      );
                    },
                    child: Text('View'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
