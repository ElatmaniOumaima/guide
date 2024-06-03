import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetail extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String duration;
  final String price;
  final String link;

  ActivityDetail({
    required this.title,
    required this.image,
    required this.description,
    required this.duration,
    required this.price,
    required this.link,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ACTIVITES'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Durée: $duration",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Prix: $price",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _launchURL(link);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: Text(
                      'Réservez sur Viator',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon1.jpg', height: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon2.jpg', height: 30),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon3.jpg', height: 30),
            label: 'Stats',
          ),
        ],
        currentIndex: 1, // Assuming this is the Activities tab
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          // Handle navigation to other pages if necessary
        },
      ),
    );
  }
}
