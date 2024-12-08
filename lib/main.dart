import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/Login_credentials/Login.dart';
import 'file_upload.dart';
void main() {
  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FileUploadScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
    ),
  );
}
