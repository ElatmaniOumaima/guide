import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

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
    if (await canLaunch(url)) {
      await launch(url);
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
                    "Vivez une aventure à travers Paradise Valley et dirigez-vous de la ville à la campagne pour voir la vraie nature et respirer l'oxygène pur.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Âge: 0-99, 30 pers. maximum par groupe",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Durée: $duration",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Horaire de début: vérifier la disponibilité",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Billet mobile",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Guide en direct: arabe, Allemand, Anglais, Français, Espagnol",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Réservez votre place",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "à partir de",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "$price par adulte",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _launchURL(link);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800], // Updated parameter name
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
