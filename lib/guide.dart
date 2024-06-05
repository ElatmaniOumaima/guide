import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guide Reservation App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Guide(),
    );
  }
}

class Guide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GuidesListPage(
      onReserve: (guideId, guideName) {
        String clientName = "John Doe"; // Replace with actual client name
        String clientEmail =
            "john.doe@example.com"; // Replace with actual client email
        reserveGuide(context, guideId, guideName, clientName, clientEmail);
      },
    );
  }

  Future<void> reserveGuide(BuildContext context, String guideId,
      String guideName, String clientName, String clientEmail) async {
    try {
      await FirebaseFirestore.instance.collection('reservations').add({
        'guideId': guideId,
        'guideName': guideName,
        'clientName': clientName,
        'clientEmail': clientEmail,
        'reservationDate': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guide reserved successfully')),
      );
    } catch (e) {
      print('Error reserving guide: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reserving guide')),
      );
    }
  }
}

class GuidesListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Function(String, String) onReserve;

  GuidesListPage({required this.onReserve});

  Future<List<Map<String, dynamic>>> fetchGuides() async {
    final snapshot = await _firestore.collection('guidedata').get();
    return snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guides'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchGuides(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching guides'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No guides available'));
          } else {
            final guides = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        guide['guidedImageUrl'] != null
                            ? Image.network(
                                guide['guidedImageUrl'],
                                height: 150, // Adjust the height as needed
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Center(
                                          child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox(
                                    height: 150,
                                    child: Center(
                                        child: Text('Error loading image')),
                                  );
                                },
                              )
                            : SizedBox(
                                height: 150, // Adjust the height as needed
                                child: Center(child: Text('No Image')),
                              ),
                        SizedBox(height: 10),
                        Text('Name: ${guide['name']}'),
                        Text('City: ${guide['city']}'),
                        Text('Price: \$${guide['price']}'),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                onReserve(guide['id'], guide['name']);
                              },
                              child: Text('Reserve'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple[300],
                              ),
                            ),
                            Row(
                              children: List.generate(5, (ratingIndex) {
                                return IconButton(
                                  icon: Icon(
                                    Icons.star,
                                    color: ratingIndex < 3
                                        ? Colors.amber
                                        : Colors.grey, // Example rating
                                  ),
                                  onPressed: () {
                                    // Implement ranking logic here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Rated ${ratingIndex + 1} stars')));
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
