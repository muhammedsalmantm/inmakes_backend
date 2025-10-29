import 'package:flutter/material.dart';
import 'package:inmakes_backend/Home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'Login_signup.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLogged=false;
  keepLogin() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    isLogged=preferences.getBool('isLogged')??false;
    setState(() {

    });
    Future.delayed(Duration(
        seconds: 3
    )).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => isLogged?HomePage():LoginSignup(),)),);

  }
  @override
  void initState() {
    keepLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("InMakes",style: TextStyle(
             color: Colors.white,fontWeight: FontWeight.bold,fontSize: width*0.1
           ),)

            ],
        ),
      ),

    );
  }
}
