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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String role = 'client'; // default role is 'client'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A5A9F), // Match the outer background color
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF8A9FDB), // Match the inner container color
            borderRadius: BorderRadius.circular(16),
          ),
          width: 350, // Width of the form container
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Sign in Page',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(_emailController, 'Your Email'),
              _buildTextField(_passwordController, 'Your Password', obscureText: true),
              _buildRoleDropdown(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final userCredential = await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    String collection = role == 'client' ? 'users' : 'guides';
                    final userDoc = await _firestore
                        .collection(collection)
                        .doc(userCredential.user!.uid)
                        .get();
                    if (userDoc.exists) {
                      // Navigate to respective page based on role
                      if (role == 'guide') {
                        Navigator.pushReplacementNamed(context, '/guidePage');
                      } else {
                        Navigator.pushReplacementNamed(context, 'lib/myApp.dart');
                      }
                    } else {
                      print("User role mismatch");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Sign in'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B418C), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Color(0xFFD9D9D9), // Match the text field color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
        obscureText: obscureText,
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFFB4A8A8), // Match the dropdown color
          borderRadius: BorderRadius.circular(16),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: role,
            onChanged: (String? newValue) {
              setState(() {
                role = newValue!;
              });
            },
            items: <String>['client', 'guide']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
