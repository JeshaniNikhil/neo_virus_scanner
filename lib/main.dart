import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/Login%20credentials/Login.dart';

void main() {
  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
    ),
  );
}
