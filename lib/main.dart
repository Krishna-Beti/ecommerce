import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
