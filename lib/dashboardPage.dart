import 'package:flutter/material.dart';
import 'package:guide/myApp.dart';
import 'city_search_page.dart';
import 'guide_page.dart'; // Ensure this is the correct path

class DashboardPage extends StatefulWidget {
  final String userName;

  DashboardPage({required this.userName});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final List<String> _spots = [
    'assets/images/spot1.png', // Replace with your image assets
    'assets/images/spot2.png', // Replace with your image assets
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
                      'Welcome, ${widget.userName}!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                SizedBox(height: 30),
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
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Text(
                  'Explore your search',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/guide.png'),
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
                          MaterialPageRoute(
                              builder: (context) => CitySearchPage()),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/cities.png'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
