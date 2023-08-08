import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({super.key});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  String imagepath="";
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: CircleAvatar(
                radius: 100,
                child: imagepath==""?Icon(Icons.person):null,
                backgroundImage: imagepath==""?null:FileImage(File(imagepath)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
