import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/Login/Login.dart';
import 'package:virus_scanner/Register/Register.dart';
import 'package:virus_scanner/customWidgets/bottomNavbar.dart';
import 'uploads/file_upload.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottomnavbar(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
    ),
  );
}
