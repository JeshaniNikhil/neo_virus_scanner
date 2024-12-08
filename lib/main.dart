// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/Login/Login.dart';
import 'package:virus_scanner/Register/Register.dart';
import 'package:virus_scanner/customWidgets/bottomNavbar.dart';
import 'package:virus_scanner/splash%20screen%20data/splash_screen.dart';
import 'uploads/file_upload.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FileUploadScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
    ),
  );
}
