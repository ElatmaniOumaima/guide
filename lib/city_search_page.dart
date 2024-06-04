import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'city_detail_page.dart';

class CitySearchPage extends StatefulWidget {
  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  String? _selectedCity;
  List<Map<String, dynamic>> _allCities = [];
  final List<String> _mostVisitedCities = ['Fes', 'Marrakesh', 'Rabat', 'Tanger'];

  @override
  void initState() {
    super.initState();
    _fetchCities();
  }

  void _fetchCities() async {
    var citiesSnapshot = await FirebaseFirestore.instance.collection('cities').get();
    setState(() {
      _allCities = citiesSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  void _navigateToCityDetailPage(Map<String, dynamic> city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CityDetailPage(city: city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a city:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select City'),
              value: _selectedCity,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                });
              },
              items: _allCities.map<DropdownMenuItem<String>>((Map<String, dynamic> city) {
                return DropdownMenuItem<String>(
                  value: city['name'],
                  child: Text(city['name']),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedCity != null) {
                  var selectedCityData =
                      _allCities.firstWhere((city) => city['name'] == _selectedCity, orElse: () => {});
                  if (selectedCityData.isNotEmpty) {
                    _navigateToCityDetailPage(selectedCityData);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('City details not found')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a city')),
                  );
                }
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Text(
              'Most visited cities in Morocco',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _mostVisitedCities.length,
                itemBuilder: (context, index) {
                  var cityName = _mostVisitedCities[index];
                  var city = _allCities.firstWhere((city) => city['name'] == cityName, orElse: () => {});
                  if (city.isNotEmpty) {
                    return GestureDetector(
                      onTap: () => _navigateToCityDetailPage(city),
                      child: GridTile(
                        child: Image.network(
                          city['images'][0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50);
                          },
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black54,
                          title: Text(city['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            city['description'].length > 50
                                ? city['description'].substring(0, 50) + '...'
                                : city['description'],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // Return an empty container if city details not found
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
