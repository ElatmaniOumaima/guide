import 'dart:async';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < (widget.restaurant['images']?.length ?? 0) - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.restaurant['images'] != null && (widget.restaurant['images'] as List).isNotEmpty)
              Container(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.restaurant['images'].length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      widget.restaurant['images'][index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 50);
                      },
                    );
                  },
                ),
              )
            else
              Icon(Icons.broken_image, size: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.restaurant['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('Stars: ${widget.restaurant['stars']}'),
                  SizedBox(height: 10),
                  Text('Cuisines Served: ${widget.restaurant['cuisinesServed'].join(', ')}'),
                  SizedBox(height: 10),
                  Text('Phone: ${widget.restaurant['phoneNumber']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
