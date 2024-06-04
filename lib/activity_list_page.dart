import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'activity_detail_page.dart'; // Import your ActivityDetailPage

class ActivityListPage extends StatelessWidget {
  final String city;

  const ActivityListPage({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities in $city'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('activities').where('city', isEqualTo: city).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var activities = snapshot.data!.docs;

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              var activity = activities[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: activity['images'] != null && (activity['images'] as List).isNotEmpty
                      ? Image.network(
                          activity['images'][0],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50);
                          },
                        )
                      : Icon(Icons.broken_image, size: 50),
                  title: Text(
                    activity['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${activity['price']} MAD'),
                      Text('Duration: ${activity['duration']}'),
                      Text('Call to reserve: ${activity['phoneNumber']}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityDetailPage(activity: activity),
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
