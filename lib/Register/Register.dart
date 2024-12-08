// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_scanner/customWidgets/customfonts.dart';

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
<<<<<<<<< Temporary merge branch 1
              SizedBox(height: 20),

              // Name Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                    child: Customfonts(
                        title: 'Name',
                        color: Colors.white,
                        fontsize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Color(0xFF98989F), fontSize: 15),
                        filled: true,
                        hintText: 'Enter Your Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99)),
                        fillColor: Color(0xFF2E2E38),
=========
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
                  child: Customfonts(
                      title: 'Name',
                      color: Colors.white,
                      fontsize: 25,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: Color(0xFF98989F), fontSize: 15),
                      filled: true,
                      hintText: 'Enter Your Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(99)),
                      fillColor: Color(0xFF2E2E38),
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Please Provide Your Email";
                      }
                      // Regular expression for validating an email
                      String pattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(email)) {
                        return "Please Enter a Valid Email Address";
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
                  child: Customfonts(
                      title: 'Email',
                      color: Colors.white,
                      fontsize: 25,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: Color(0xFF98989F), fontSize: 15),
                      filled: true,
                      hintText: 'Enter Your Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(99)),
                      fillColor: Color(0xFF2E2E38),
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Please Provide Your Email";
                      }
                      // Regular expression for validating an email
                      String pattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(email)) {
                        return "Please Enter a Valid Email Address";
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
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
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Enter Your Password',
                      hintStyle:
                          TextStyle(color: Color(0xFF98989F), fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(99)),
                      fillColor: Color(0xFF2E2E38),
                    ),
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "Please Provide Your Password";
                      }
                      if (password.length < 8) {
                        return "Password must be at least 8 characters long";
                      }
                      if (password.length > 20) {
                        return "Password must be no more than 20 characters long";
                      }
                      String pattern =
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(password)) {
                        return "Password must contain at least one lowercase letter, one uppercase letter, one digit, and one special character";
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double
                      .infinity, // Make the button stretch across the available width
                  height: 50, // Define button height
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6E9BFF),
                          Color(0xFF1E5CE4),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
>>>>>>>>> Temporary merge branch 2
                      ),
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return "Please Provide Your Name";
                        }
                        if (name.length > 50) {
                          return "Name must be less than 50 characters";
                        }
                        if (!RegExp(r'^[a-zA-Z ]+\$').hasMatch(name)) {
                          return "Name must contain only alphabets";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Email Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                    child: Customfonts(
                        title: 'Email',
                        color: Colors.white,
                        fontsize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Color(0xFF98989F), fontSize: 15),
                        filled: true,
                        hintText: 'Enter Your Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99)),
                        fillColor: Color(0xFF2E2E38),
                      ),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return "Please Provide Your Email";
                        }
                        String pattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$';
                        if (!RegExp(pattern).hasMatch(email)) {
                          return "Please Enter a Valid Email Address";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
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
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Enter Your Password',
                        hintStyle:
                            TextStyle(color: Color(0xFF98989F), fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99)),
                        fillColor: Color(0xFF2E2E38),
                      ),
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return "Please Provide Your Password";
                        }
                        if (password.length < 8 || password.length > 20) {
                          return "Password must be 8-20 characters long";
                        }
                        String pattern =
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,20}\$';
                        if (!RegExp(pattern).hasMatch(password)) {
                          return "Password must include uppercase, lowercase, digit, and special character";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Confirm Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                    child: Customfonts(
                        title: 'Confirm Password',
                        color: Colors.white,
                        fontsize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Confirm Your Password',
                        hintStyle:
                            TextStyle(color: Color(0xFF98989F), fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99)),
                        fillColor: Color(0xFF2E2E38),
                      ),
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
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Registration logic here
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    child: Customfonts(
                      title: 'Register',
                      color: Colors.white,
                      fontsize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Already Registered? Login Here
              GestureDetector(
                onTap: () {
                  // Navigate to login screen
                },
                child: Text(
                  "Already Registered? Login Here",
                  style: GoogleFonts.inter(
                      color: Color(0xFF6E9BFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
