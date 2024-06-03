import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'myApp.dart';
import 'activities.dart';
import 'activity_detail.dart';
import 'city_detail_page.dart';
import 'city_search_page.dart';
import 'dashboardPage.dart';
import 'guide_page.dart';
import 'hotel_detail_page.dart';
import 'hotel_list_page.dart';
import 'restaurant_list_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Correct import for Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/activity_detail') {
          final ActivityDetail args = settings.arguments as ActivityDetail;
          return MaterialPageRoute(
            builder: (context) {
              return ActivityDetail(
                title: args.title,
                image: args.image,
                description: args.description,
                duration: args.duration,
                price: args.price,
                link: args.link,
              );
            },
          );
        }
        if (settings.name == '/city_detail') {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return CityDetailPage(city: args);
            },
          );
        }
        if (settings.name == '/hotel_detail') {
          final QueryDocumentSnapshot<Map<String, dynamic>> args = settings.arguments as QueryDocumentSnapshot<Map<String, dynamic>>;
          return MaterialPageRoute(
            builder: (context) {
              return HotelDetailPage(hotel: args);
            },
          );
        }
        if (settings.name == '/hotel_list') {
          final String args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return HotelListPage(city: args);
            },
          );
        }
        if (settings.name == '/restaurant_list') {
          final String args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return RestaurantListPage(city: args);
            },
          );
        }
        return null; // Fallback to default handling
      },
      routes: {
        '/': (context) => MyApp(), // Assuming MyApp in myApp.dart is the login page
        '/activities': (context) => ActivitiesPage(),
        '/city_search': (context) => CitySearchPage(),
        '/dashboard': (context) => DashboardPage(),
        '/guide': (context) => GuidePage(),
      },
    );
  }
}
