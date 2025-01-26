// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds
    Timer(const Duration(seconds: 2), () async {
      // Check user's login status with Supabase
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        // Navigate to upload screen if logged in
        Navigator.pushReplacementNamed(context, '/upload');
      } else {
        // Navigate to login screen if not logged in
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xFf1e1e25),
      appBar: AppBar(
        backgroundColor: Color(0xFf1e1e25),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: SvgPicture.asset(
                'assets/img.svg',
                height: mediaQuery.size.height * 0.4,
                width: mediaQuery.size.width * 0.4,
                fit: BoxFit.cover, // Ensures the image covers the circle
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              'Welcome to Neon \nVirus Scanner',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
