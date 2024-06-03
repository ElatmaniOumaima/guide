import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'activities.dart'; // Import the activities page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.tourism_app/channel');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TourismHomePage(),
    );
  }

  Future<void> _callJavaCode() async {
    try {
      final String result = await platform.invokeMethod('methodName');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to call Java code: '${e.message}'.");
    }
  }
}

class TourismHomePage extends StatefulWidget {
  @override
  _TourismHomePageState createState() => _TourismHomePageState();
}

class _TourismHomePageState extends State<TourismHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    ActivitiesPage(), // Use the new activities page
    Text('Stats'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Implement back button action
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search button action
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
