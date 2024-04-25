import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:venue_drive/dashboard.dart';
import 'package:venue_drive/login.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
     theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgs.jpg'), 
            // fit: BoxFit.cover,
          ),
        ),
        child: SplashScreenView(
          navigateRoute: DashboardPage(),
          duration: 3000,
          imageSize: 300,
          imageSrc: 'assets/images/venue.png',
          backgroundColor: const Color(0xFF000000),
        ),
      ),
    );
  }
}


