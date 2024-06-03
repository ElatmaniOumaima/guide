import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  final userDoc = await _firestore
                      .collection('users')
                      .doc(userCredential.user!.uid)
                      .get();
                  final role = userDoc['role'];
                  // Navigate to respective page based on role
                  if (role == 'guide') {
                    Navigator.pushReplacementNamed(context, '/guidePage');
                  } else {
                    Navigator.pushReplacementNamed(context, 'lib/myApp.dart');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
