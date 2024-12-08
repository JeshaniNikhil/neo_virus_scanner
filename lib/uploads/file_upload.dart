// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  int _currentIndex = 0; // Track selected index for bottom navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E2E38),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E2E38),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Text(
              "NeoVirus Scanner",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Neon',
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "File Upload",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Upload your files for scanning",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Icon(
                              Icons.folder_open,
                              color: Colors.blueAccent,
                              size: 45,
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/file_upload.svg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 200,
                                  child: LinearProgressIndicator(
                                    value: 0.5,
                                    backgroundColor: Colors.grey.shade800,
                                    color: Colors.cyanAccent,
                                    minHeight: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Max width Upload Button
            ElevatedButton(
              onPressed: () {
                // Implement file upload functionality here
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 56),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                shadowColor: Colors.blueAccent,
                elevation: 10,
              ),
              child: Text(
                "Upload Files",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.transparent, // Transparent background
        selectedItemColor:
            Colors.transparent, // Remove the default selected item color
        unselectedItemColor: Colors.grey,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
              color: _currentIndex == 0
                  ? null
                  : null, // Applying the gradient only when selected
            ),
            label: 'Home',
            backgroundColor: _currentIndex == 0
                ? Color(0xFF2E3B60) // Active background color
                : Colors.transparent, // Transparent background when not active
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 35,
              color: _currentIndex == 1
                  ? null
                  : null, // Applying the gradient only when selected
            ),
            label: 'Profile',
            backgroundColor: _currentIndex == 1
                ? Color(0xFF2E3B60) // Active background color
                : Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload_file,
              size: 35,
              color: _currentIndex == 2
                  ? null
                  : null, // Applying the gradient only when selected
            ),
            label: 'Upload',
            backgroundColor: _currentIndex == 2
                ? Color(0xFF2E3B60) // Active background color
                : Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 35,
              color: _currentIndex == 3
                  ? null
                  : null, // Applying the gradient only when selected
            ),
            label: 'Scan Results',
            backgroundColor: _currentIndex == 3
                ? Color(0xFF2E3B60) // Active background color
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
