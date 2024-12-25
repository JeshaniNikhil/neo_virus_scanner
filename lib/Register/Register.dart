import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool showPassword = false;
  bool showConfirmPassword = false;

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
        Navigator.pushNamed(context, '/login'); // Navigate to login page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Registration failed. Please try again.")),
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
      backgroundColor: const Color(0xFF1E1E25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E25),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Virus Scanner",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Register',
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: nameController,
                label: "Name",
                hintText: "Enter Your Name",
                validator: (name) {
                  if (name == null || name.trim().isEmpty) {
                    return "Please Provide Your Name";
                  }
                  if (name.trim().length > 50) {
                    return "Name must be less than 50 characters";
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name.trim())) {
                    return "Name must contain only alphabets";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: emailController,
                label: "Email",
                hintText: "Enter Your Email",
                validator: (email) {
                  if (email == null || email.trim().isEmpty) {
                    return "Please Provide Your Email";
                  }
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  if (!RegExp(pattern).hasMatch(email.trim())) {
                    return "Please Enter a Valid Email Address";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: passwordController,
                label: "Password",
                hintText: "Enter Your Password",
                obscureText: !showPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
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
              CustomTextField(
                controller: confirmPasswordController,
                label: "Confirm Password",
                hintText: "Confirm Your Password",
                obscureText: !showConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
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
              const SizedBox(height: 40),
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
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
  final Widget? suffixIcon;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  const TextStyle(color: Color(0xFF98989F), fontSize: 15),
              filled: true,
              fillColor: const Color(0xFF2E2E38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(99),
                borderSide: BorderSide.none,
              ),
              suffixIcon: suffixIcon,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
