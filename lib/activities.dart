import 'package:flutter/material.dart';
import 'activity_detail.dart'; // Import the ActivityDetail class

class Activity {
  final String title;
  final String image;
  final String description;
  final String duration;
  final String price;
  final String link;

  Activity({
    required this.title,
    required this.image,
    required this.description,
    required this.duration,
    required this.price,
    required this.link,
  });
}

class ActivitiesPage extends StatelessWidget {
  final List<Activity> activities = [
    Activity(
      title: "Excursion d'une demi-journée à la vallée du Paradis au départ d'Agadir",
      image: 'assets/images/image1.jpg',
      description: "Recommended by 97% of travellers",
      duration: "5 hours",
      price: "14,90€",
      link: 'https://www.viator.com',
    ),
    Activity(
      title: "Promenade à dos de chameau au coucher du soleil à Agadir ou Taghazout avec transferts",
      image: 'assets/images/image2.jpg',
      description: "Recommended by 90% of travellers",
      duration: "1 hour",
      price: "17,99€",
      link: 'https://www.viator.com',
    ),
    Activity(
      title: "Safari d'une journée complète dans le petit désert avec déjeuner",
      image: 'assets/images/image3.jpg',
      description: "Recommended by 85% of travellers",
      duration: "7-8 hours",
      price: "38,5€",
      link: 'https://www.viator.com',
    ),
  ];

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
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.asset(activity.image, fit: BoxFit.cover, width: 100),
                  title: Text(activity.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text("Durée: ${activity.duration}"),
                      Text("Prix: ${activity.price} par adulte"),
                      SizedBox(height: 5),
                      Text(activity.description),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dès ${activity.price}", style: TextStyle(fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActivityDetail(
                                title: activity.title,
                                image: activity.image,
                                description: activity.description,
                                duration: activity.duration,
                                price: activity.price,
                                link: activity.link,
                              ),
                            ),
                          );
                        },
                        child: Text('Voir maintenant'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
