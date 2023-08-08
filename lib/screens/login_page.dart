import 'package:ecommerce/getdata.dart';
import 'package:ecommerce/modalclasses/users.dart';
import 'package:ecommerce/screens/bottom_naviagtionbar_page.dart';
import 'package:ecommerce/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showpassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool internetChecker = true;
  bool showProgress=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('images/back.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                "images/animation.json",
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    height: 48.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/textfield.png'))),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      height: 58.h,
                      width: 300.w,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        decoration: InputDecoration(
                            suffix: Icon(Icons.email, color: Colors.black),
                            hintText: "Email",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 13.w)),
                      ),
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    height: 48.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/textfield.png'))),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      height: 58.h,
                      width: 300.w,
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        obscureText: showpassword,
                        decoration: InputDecoration(
                            suffix: GestureDetector(
                              onTap: () {
                                showpassword = !showpassword;
                                setState(() {});
                              },
                              child: showpassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                            hintText: "Password",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 13.w)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 35.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.h),
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: showProgress?LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.black,
                      size: 40):Text("Login",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold)),
                  onPressed: ()  async {
                    bool flag=false;
                        if(emailController.text!=""&&passwordController.text!="")
                          {
                            showProgress=true;
                            setState(() {});
                            Map map=await loginUser(emailController.text, passwordController.text);
                            if(map.isNotEmpty)
                            {
                              SharedPreferenceData.preferences!.setBool("key", true);
                              SharedPreferenceData.preferences!.setStringList("userData", [
                                map['id'],
                                map['name'],
                                map['email'],
                                map['password'],
                                map['gender'],
                                map['image']
                              ]);
                              infoToast("Success", "Login Successfull", context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNaviagtionBarPage(),));

                            }
                            else
                            {
                              showProgress=false;
                              setState(() {});
                              errorToast("Warning", "Invalid Credentials", context);
                            }
                          }
                        else{
                          errorToast("Warning", "Please fill all required fields", context);
                        }
                  },
                ),
              )
            ],
          ),
        )),
        bottomNavigationBar: Container(
          height: 40.h,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationPage(),));
                },
                child: Text("Sign Up",style: GoogleFonts.aclonica(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp
                )),
              ),
              Text("Don't have an account ? ",style: GoogleFonts.aclonica(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp
              )),
            ],
          ),
        ),
      ),
    );
  }
}
