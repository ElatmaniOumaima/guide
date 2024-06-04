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
  bool isAvailable = true;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      final path = result.files.single.path;
      if (path != null) {
        try {
          final ref = _storage.ref().child('guided_images/${result.files.single.name}');
          await ref.putFile(File(path));
          guidedImageUrl = await ref.getDownloadURL();
          setState(() {});
          print('Image uploaded successfully: $guidedImageUrl');
        } catch (e) {
          print('Error uploading image: $e');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image')));
        }
      } else {
        print('File path is null');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error selecting image')));
      }
    } else {
      print('No file selected');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No file selected')));
    }
  }

  Future<void> saveGuideData() async {
    if (guidedImageUrl.isEmpty || price.isEmpty || city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    try {
      await _firestore.collection('guidedata').add({
        'guidedImageUrl': guidedImageUrl,
        'price': price,
        'city': city,
        'isAvailable': isAvailable,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Guide profile saved successfully')));
      print('Guide profile saved successfully');
    } catch (e) {
      print('Error saving guide data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving guide profile')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            guidedImageUrl.isEmpty
                ? Center(child: Text('No image uploaded'))
                : Image.network(guidedImageUrl),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Upload Guided Image'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Price'),
              onChanged: (value) => price = value,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(hintText: 'Enter City'),
              onChanged: (value) => city = value,
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Available for Bookings'),
              value: isAvailable,
              onChanged: (value) => setState(() => isAvailable = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveGuideData,
              child: Text('Save Guide Profile'),
            ),
          ],
        ),
      ),
    );
  }
}