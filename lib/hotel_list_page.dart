import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hotel_detail_page.dart';

class HotelListPage extends StatelessWidget {
  final String city;

  const HotelListPage({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels in $city'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('hotels').where('city', isEqualTo: city).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var hotels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              var hotel = hotels[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: hotel['images'] != null && (hotel['images'] as List).isNotEmpty
                      ? Image.network(
                          hotel['images'][0],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50);
                          },
                        )
                      : Icon(Icons.broken_image, size: 50),
                  title: Text(
                    hotel['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${hotel['averagePricePerNight']} MAD per night'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelDetailPage(hotel: hotel),
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
