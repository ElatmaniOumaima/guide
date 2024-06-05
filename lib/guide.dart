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
              padding: EdgeInsets.all(8.0),
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    leading: guide['guidedImageUrl'] != null
                        ? Image.network(
                            guide['guidedImageUrl'],
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 50);
                            },
                          )
                        : Icon(Icons.broken_image, size: 50),
                    title: Text(
                      guide['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${guide['price']} \$ per day'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        onReserve(guide['id'], guide['name']);
                      },
                      child: Text('Reserve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[300],
                      ),
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
