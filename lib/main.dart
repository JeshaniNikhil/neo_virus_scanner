import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/Login/Login.dart';
import 'package:virus_scanner/Register/Register.dart';
import 'file_upload.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
    ),
  );
}
