import 'package:flutter/material.dart';
import 'package:inmakes_backend/login/login.dart';
import '../const/color.dart';
import '../custom/container.dart';
import '../main.dart';


import 'signup.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade900,
              Colors.green.shade800,

              Colors.white,
              Colors.white.withOpacity(0.5),

            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            SizedBox(height: width*0.2,),

            Text(
              'Inmakes',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: ColorP.whiteColor,
              ),
            ),

            SizedBox(height: width*0.07,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Container(
                    width: width * 0.4,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: ColorP.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Container(
                    width: width * 0.4,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: ColorP.whiteColor,
                      borderRadius: BorderRadius.circular(width * 0.03),
                      border: Border.all(color: ColorP.prim),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: ColorP.prim,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width*0.1,
            )

          ],
        ),
      ),
    );
  }
}
