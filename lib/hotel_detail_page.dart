import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HotelDetailPage extends StatefulWidget {
  final QueryDocumentSnapshot hotel;

  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < (widget.hotel['images']?.length ?? 0) - 1) {
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.hotel['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.hotel['images'] != null ? widget.hotel['images'].length : 0,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      widget.hotel['images'][index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 50);
                      },
                    );
                  },
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      if (_currentPage < widget.hotel['images'].length - 1) {
                        _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.hotel['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Price per night: ${widget.hotel['averagePricePerNight']} MAD'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Stars: ${widget.hotel['stars']}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Restaurant: ${widget.hotel['hasRestaurant'] ? 'Yes' : 'No'}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Parking: ${widget.hotel['hasParking'] ? 'Yes' : 'No'}'),
                ),
                if (widget.hotel['phoneNumber'] != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Call for availability: ${widget.hotel['phoneNumber']}'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
