import 'package:flutter/material.dart';
import 'activity_detail.dart';

class ActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Excursion to Paradise Valley'),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityDetail(
                    title: 'Excursion to Paradise Valley',
                    image: 'assets/images/paradise_valley.jpg',
                    description: 'A wonderful excursion to Paradise Valley.',
                    duration: '5 hours',
                    price: '14.90€',
                    link: 'https://www.viator.com',
                  )),
                );
              },
              child: Text('View'),
            ),
          ),
          // Add more activities here
        ],
      ),
    );
  }
}
