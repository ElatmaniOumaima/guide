import 'package:flutter/material.dart';
import 'package:guide/guide_page.dart'; // Ensure this is the correct path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(), // Set the DashboardPage as the home
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final List<String> _spots = [
    'images/spot1.png', // Replace with your image assets
    'images/spot2.png', // Replace with your image assets
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Spots',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement skip functionality here
                      },
                      child: Text(
                        'skip',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: () {
                      // Implement navigation to full view of spot image
                    },
                    child: Container(
                      key: ValueKey<int>(_currentIndex),
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_spots[_currentIndex]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _currentIndex = (_currentIndex - 1 + _spots.length) %
                              _spots.length;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _currentIndex = (_currentIndex + 1) % _spots.length;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Explore your search',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GuidePage()),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/guide.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CitiesPage()),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/cities.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: IconButton(
              icon: Icon(Icons.home, color: Colors.white, size: 32),
              onPressed: () {
                // Implement home button functionality here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cities')),
      body: Center(child: Text('Cities Page')),
    );
  }
}
