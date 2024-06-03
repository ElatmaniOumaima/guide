import 'package:flutter/material.dart';
import 'package:guide/dashboardPage.dart';
import 'package:guide/sign_up.dart';

import 'sign_in.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), debugShowCheckedModeBanner: true);
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      // Add your skip functionality here
                      // Navigate to dashboard page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage()),
                      );
                    },
                    child: Text(
                      'skip',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/images/morocco.png', // Correct the image path
                  height: 350,
                ),
                SizedBox(height: 0), // Add spacing between elements
                Text(
                  'AHLAN',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10), // Add spacing between elements
                Text(
                  'Your ultimate guide in Morocco',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // Add your sign in functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()),
                        );

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Sign in'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add your sign up functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Sign up'),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  'Contact us for more informations:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'imaneezzyneimaneezzy@gmail.com',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
