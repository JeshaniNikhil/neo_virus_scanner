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
     
    );
  }
}
