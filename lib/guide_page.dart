import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  String guidedImageUrl = '';
  String price = '';
  String city = '';
  String name = '';
  bool isAvailable = true;
  String documentId = '';

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      final path = result.files.single.path;
      if (path != null) {
        try {
          final ref =
              _storage.ref().child('guided_images/${result.files.single.name}');
          await ref.putFile(File(path));
          guidedImageUrl = await ref.getDownloadURL();
          setState(() {});
          print('Image uploaded successfully: $guidedImageUrl');
        } catch (e) {
          print('Error uploading image: $e');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error uploading image')));
        }
      } else {
        print('File path is null');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error selecting image')));
      }
    } else {
      print('No file selected');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No file selected')));
    }
  }

  Future<void> saveGuideData() async {
    if (guidedImageUrl.isEmpty ||
        price.isEmpty ||
        city.isEmpty ||
        name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    try {
      if (documentId.isEmpty) {
        await _firestore.collection('guidedata').add({
          'guidedImageUrl': guidedImageUrl,
          'price': price,
          'city': city,
          'name': name,
          'isAvailable': isAvailable,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Guide profile saved successfully')));
        print('Guide profile saved successfully');
      } else {
        await _firestore.collection('guidedata').doc(documentId).update({
          'guidedImageUrl': guidedImageUrl,
          'price': price,
          'city': city,
          'name': name,
          'isAvailable': isAvailable,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Guide profile updated successfully')));
        print('Guide profile updated successfully');
      }
    } catch (e) {
      print('Error saving guide data: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error saving guide profile')));
    }
  }

  Future<void> fetchGuideData() async {
    try {
      final snapshot = await _firestore.collection('guidedata').get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          documentId = snapshot.docs.first.id;
          guidedImageUrl = data['guidedImageUrl'];
          price = data['price'];
          city = data['city'];
          name = data['name'];
          isAvailable = data['isAvailable'];
        });
      }
    } catch (e) {
      print('Error fetching guide data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching guide profile')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Reservations'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  guidedImageUrl.isEmpty
                      ? Center(child: Text('No image uploaded'))
                      : Image.network(guidedImageUrl),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Upload your picture'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[300],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      fillColor: Colors.deepPurple[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => setState(() => name = value),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'City',
                      fillColor: Colors.deepPurple[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => setState(() => city = value),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Price',
                      fillColor: Colors.deepPurple[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => setState(() => price = value),
                  ),
                  SizedBox(height: 20),
                  SwitchListTile(
                    title: Text('Available for Bookings'),
                    value: isAvailable,
                    onChanged: (value) => setState(() => isAvailable = value),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: saveGuideData,
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[300],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: fetchGuideData,
                        child: Text('Update'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[300],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Text('Reservations Tab Content'),
            ),
          ],
        ),
      ),
    );
  }
}
