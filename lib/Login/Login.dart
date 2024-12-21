import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/customWidgets/customfonts.dart';
import 'package:virus_scanner/uploads/file_upload.dart';
import 'package:virus_scanner/register/register.dart'; // Import the Register screen
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final SupabaseClient supabase = Supabase.instance.client;

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        // Successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FileUploadScreen()),
        );
      } else {
        // Error handling
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid login credentials')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFf1e1e25),
      appBar: AppBar(
        backgroundColor: const Color(0xFf1e1e25),
        title: Center(
          child: Text(
            "Virus Scanner",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Login',
                style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Email input field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                  child: Customfonts(
                      title: 'Email',
                      color: Colors.white,
                      fontsize: 25,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                          color: Color(0xFF98989F), fontSize: 15),
                      filled: true,
                      hintText: 'Enter Your Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(99)),
                      fillColor: const Color(0xFF2E2E38),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Password input field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                  child: Customfonts(
                      title: 'Password',
                      color: Colors.white,
                      fontsize: 20,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Enter Your Password',
                      hintStyle: const TextStyle(
                          color: Color(0xFF98989F), fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(99)),
                      fillColor: const Color(0xFF2E2E38),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Login button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6E9BFF),
                      Color(0xFF1E5CE4),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  child: const Customfonts(
                    title: 'Login',
                    color: Colors.white,
                    fontsize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Not Registered? Register Here
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: "Not Registered? ",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: "Register Here",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6E9BFF),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
