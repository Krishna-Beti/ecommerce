import 'dart:convert';
import 'dart:io';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../constants.dart';
import 'email_verification_page.dart';

String Name = "";
String Email = "";
String Password = "";
String Gender = "";
String ImageUrl = "";

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imagepath = "";
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  String nameError = "";
  bool nameFlag = false;
  String emailError = "";
  bool emailFlag = false;
  String passwordError = "";
  bool passwordFlag = false;
  bool showpassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  height: 180.h,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Select Source :- ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                              color: Colors.black)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              height: 70.h,
                                              width: 70.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          "images/camera.png"))),
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final XFile? image =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              imagepath = image!.path;
                                              setState(() {});
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              height: 80.h,
                                              width: 80.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          "images/gallery.png"))),
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final XFile? photo =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              imagepath = photo!.path;
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: imagepath == ""
                            ? Lottie.asset(
                                "images/animation.json",
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: FileImage(File(imagepath)),
                                ),
                              ),
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
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
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    nameFlag = true;
                                    nameError = "Please Enter Name";
                                  } else {
                                    nameFlag = false;
                                  }
                                  setState(() {});
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                    suffix: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    hintText: "Name",
                                    errorText: nameFlag ? nameError : null,
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
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    emailFlag = true;
                                    emailError = "Please Enter Email";
                                  } else if (!emailRegex.hasMatch(value)) {
                                    emailFlag = true;
                                    emailError = "Please Enter Valid Email";
                                  } else {
                                    emailFlag = false;
                                  }
                                  setState(() {});
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                    suffix:
                                        Icon(Icons.email, color: Colors.black),
                                    hintText: "Email",
                                    errorText: emailFlag ? emailError : null,
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
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    passwordFlag = true;
                                    passwordError = "Please Enter Password";
                                  } else if (!passwordRegex.hasMatch(value)) {
                                    passwordFlag = true;
                                    passwordError =
                                        "Please Enter Valid Password";
                                  } else {
                                    passwordFlag = false;
                                  }
                                  setState(() {});
                                },
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
                                    errorText:
                                        passwordFlag ? passwordError : null,
                                    hintText: "Password",
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 13.w)),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("Select Gender :-",
                              style: GoogleFonts.slabo13px(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomRadioButton(
                            buttonLables: ["Male", "Female"],
                            buttonValues: ["Male", "Female"],
                            radioButtonValue: (p0) {
                              Gender = p0;
                              setState(() {});
                            },
                            elevation: 20,
                            enableShape: true,
                            customShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: Colors.black, width: 2)),
                            unSelectedColor: Colors.white,
                            margin: EdgeInsets.symmetric(horizontal: 15.h),
                            selectedColor: primaryColor,
                          ),
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
                          child: Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {

                              if (nameController.text != "" &&
                                  emailController.text != "" &&
                                  passwordController.text != "" &&
                                  Gender != "") {
                                if (nameFlag == true ||
                                    emailFlag == true ||
                                    passwordFlag == true) {
                                  errorToast("Warning", "Please Enter Valid Data",
                                      context);
                                } else if (imagepath == "") {
                                  errorToast("Warning",
                                      "Please Select Your Image", context);
                                } else {
                                  Name = nameController.text;
                                  Email = emailController.text;
                                  Password = passwordController.text;
                                  File file = File(imagepath);
                                  ImageUrl = base64Encode(file.readAsBytesSync());
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EmailVerificationPage(),
                                      ));
                                }
                              } else {
                                errorToast(
                                    "Warning", "Please Fill All Fields", context);
                              }
                            }
                        ),
                      )
                    ],
                  ),
                )
        ),
        bottomNavigationBar: Container(
          height: 30.h,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                },
                child: Text("Login",style: GoogleFonts.aclonica(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp
                )),
              ),
              Text("Already have an account ? ",style: GoogleFonts.aclonica(
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

void errorToast(String title, String desc, BuildContext context) {
  return MotionToast.error(
    title: Text(title),
    description: Text(desc),
    animationType: AnimationType.fromRight,
    animationDuration: Duration(milliseconds: 500),
    toastDuration: Duration(milliseconds: 2000),
  ).show(context);
}

void infoToast(String title, String desc, BuildContext context) {
  return MotionToast.info(
    title: Text(title),
    description: Text(desc),
    animationType: AnimationType.fromRight,
    animationDuration: Duration(milliseconds: 500),
    toastDuration: Duration(milliseconds: 2000),
  ).show(context);
}
