import 'dart:async';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/bottom_naviagtionbar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("images/splash.json"),
            SizedBox(height: 20.h,),
            Text("The Shopping Hub",style: GoogleFonts.bungeeSpice(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }

  Future<void> getinstance() async {
    SharedPreferenceData.preferences = await SharedPreferences.getInstance();
    bool checker=SharedPreferenceData.preferences!.getBool("key") ?? false;

    Timer(Duration(seconds: 4), () {
      if(checker)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNaviagtionBarPage(),));
        }
      else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
    });
  }
}
