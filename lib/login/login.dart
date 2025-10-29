import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inmakes_backend/login/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  loginUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var docRef = await FirebaseFirestore.instance
        .collection('details')
        .where('email', isEqualTo: emailController.text.trim().toString())
        .get();

    var doc = docRef.docs;
    if (doc.isNotEmpty) {
      if (doc[0]['password'] == passwordController.text) {
        preferences.setString("email", doc[0]["email"]);
        preferences.setString("name", doc[0]["name"]);
        preferences.setBool('isLogged', true);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Password is incorrect')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Email is incorrect')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade900,
              Colors.green.shade800,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: width * 0.1),

                  TextFormField(
                    controller: emailController,
                    onChanged: (v) {
                      emailController.value = TextEditingValue(
                        text: v.toLowerCase(),
                        selection: emailController.selection,
                      );
                    },
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Enter email";
                      if (!RegExp(r'^[a-z0-9.]+@gmail\.com$').hasMatch(v)) {
                        return "Only Gmail addresses allowed";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email ",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Enter password";
                      if (v.length < 6) return "Minimum 6 characters";
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade900,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: loginUser,
                    child: const Text(
                      "Login",
                      style:
                      TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
