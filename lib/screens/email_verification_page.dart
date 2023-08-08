import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:ecommerce/screens/registration_page.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/resources/arrays.dart';
import '../constants.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  EmailOTP myauth = EmailOTP();
  bool showIndicator = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = Email;
  }

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
          child: showIndicator
              ? Container(
            height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.flickr(
                        leftDotColor: Colors.yellow,
                        rightDotColor: Colors.purple,
                        size: 150),
                    Text("Processing", style: GoogleFonts.slabo13px(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),)
                  ],
                ),
              )
              : SingleChildScrollView(
            child: Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      Text("Verify Your Email",
                          style: GoogleFonts.slabo13px(
                              letterSpacing: 1.5,
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 50.h,
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
                                readOnly: true,
                                textInputAction: TextInputAction.next,
                                controller: emailController,
                                decoration: InputDecoration(
                                    suffix: TextButton(
                                      onPressed: () async {
                                        myauth.setConfig(
                                          appEmail: "me@rohitchouhan.com",
                                          appName: "Email OTP",
                                          userEmail: emailController.text,
                                          otpLength: 6,
                                          otpType: OTPType.digitsOnly,
                                        );
                                        if (await myauth.sendOTP() == true) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("OTP has been sent"),
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Oops, OTP send failed\nCheck Your Email Address"),
                                          ));
                                        }
                                      },
                                      child: Text("Send OTP",
                                          style: GoogleFonts.slabo13px(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
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
                                controller: otpController,
                                decoration: InputDecoration(
                                    hintText: "OTP",
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
                          child: Text("Verify",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            if (await myauth.verifyOTP(
                                    otp: otpController.text) ==
                                true) {
                              infoToast("Success", "OTP Verified Successfully", context);
                              Map map = {
                                'name': Name,
                                'email': Email,
                                'password': Password,
                                'gender': Gender,
                                'imageurl': ImageUrl
                              };
                              var url = Uri.parse(
                                  'https://krishnabeti.000webhostapp.com/ecommerce_insertuser.php');
                              showIndicator = true;
                              setState(() {});
                              var response = await http.post(url, body: map);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            } else {
                              errorToast("Warning", "Invalid OTP", context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
