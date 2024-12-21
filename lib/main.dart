// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/Login/Login.dart';
import 'package:virus_scanner/Register/Register.dart';
import 'package:virus_scanner/customWidgets/bottomNavbar.dart';
import 'package:virus_scanner/splash%20screen%20data/splash_screen.dart';
import 'uploads/file_upload.dart';
import 'file_analysis/file_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ehketgceejfwurpmbymf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVoa2V0Z2NlZWpmd3VycG1ieW1mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2MzU4MjIsImV4cCI6MjA1MDIxMTgyMn0.JeFMZdy1dBTR70SzVGHENavXoIIUD3qhVOm9U5UYkTY',
  );
  //error solve thay gay che    
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const Login(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
    ),
  );
}
