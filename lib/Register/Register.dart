// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/customWidgets/customfonts.dart';
import 'package:virus_scanner/Login/Login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      // Call Supabase API to create user
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful!")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration failed. Please try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1e1e25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1e1e25),
        title: Center(
          child: Text(
            "Virus Scanner",
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Register',
                  style: GoogleFonts.inter(
                      fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              CustomTextField(
                controller: nameController,
                label: "Name",
                hintText: "Enter Your Name",
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return "Please Provide Your Name";
                  }
                  if (name.length > 50) {
                    return "Name must be less than 50 characters";
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
                    return "Name must contain only alphabets";
                  }
                  return null;
                },
              ),

              // Email Field
              CustomTextField(
                controller: emailController,
                label: "Email",
                hintText: "Enter Your Email",
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "Please Provide Your Email";
                  }
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  if (!RegExp(pattern).hasMatch(email)) {
                    return "Please Enter a Valid Email Address";
                  }
                  return null;
                },
              ),

              // Password Field
              CustomTextField(
                controller: passwordController,
                label: "Password",
                hintText: "Enter Your Password",
                obscureText: true,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Please Provide Your Password";
                  }
                  if (password.length < 8 || password.length > 20) {
                    return "Password must be 8-20 characters long";
                  }
                  return null;
                },
              ),

              // Confirm Password Field
              CustomTextField(
                controller: confirmPasswordController,
                label: "Confirm Password",
                hintText: "Confirm Your Password",
                obscureText: true,
                validator: (confirmPassword) {
                  if (confirmPassword == null || confirmPassword.isEmpty) {
                    return "Please Confirm Your Password";
                  }
                  if (confirmPassword != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              // Register Button
              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E9BFF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                child: Text(
                  'Register',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Already Registered? Login Here
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already Registered? ",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      TextSpan(
                        text: "Login Here",
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
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Color(0xFF98989F), fontSize: 15),
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(99),
              ),
              fillColor: const Color(0xFF2E2E38),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
