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
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: primaryColor, // Ensure this is set at the top level
        type: BottomNavigationBarType.fixed, // Ensures fixed layout
        selectedItemColor: Colors.blueAccent, // Color for the selected item
        unselectedItemColor: Colors.white, // Color for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
            ),
            label: "", // Empty label
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 25,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 25,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_rounded,
              size: 25,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
