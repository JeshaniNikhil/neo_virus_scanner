import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:virus_scanner/constants/constant.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});
  @override
  State<Bottomnavbar> createState() => _BottomNavbar();
}

class _BottomNavbar extends State<Bottomnavbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60, // Set a fixed height for the navigation bar
        backgroundColor: Colors.transparent, // Set transparent background
        color: Colors.deepPurple, // Set the color of the navigation bar
        items: [
          Icon(color: iconColor, Icons.home, size: 30),
          Icon(color: iconColor, Icons.search, size: 30),
          Icon(
            color: iconColor,
            Icons.notifications,
            size: 30,
          ),
          Icon(
            color: iconColor,
            Icons.person_2_outlined,
            size: 30,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
