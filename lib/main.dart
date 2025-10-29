
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'login/login_signup.dart';
import 'login/signup.dart';
import 'login/splash.dart';
late double height;
late double width;


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      DevicePreview(
        enabled:true,
        builder: (context) =>  CrudApp(),)
  );
}
class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(
            // scaffoldBackgroundColor: ColorConstant.whiteColor,
            textTheme: GoogleFonts.outfitTextTheme()
        ),
        debugShowCheckedModeBanner: false,
        home:Splash(),
      ),
    );
  }
}
