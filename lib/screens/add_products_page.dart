import 'dart:convert';
import 'dart:io';
import 'package:ecommerce/screens/bottom_naviagtionbar_page.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({super.key});

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  TextEditingController nameController=TextEditingController();
  TextEditingController companyController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController discountController=TextEditingController();
  double ratings=0.0;
  TextEditingController descController=TextEditingController();
  bool showProgress=false;
  String imagepath="";
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h,),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70.h,
                      backgroundColor: Colors.green,
                      backgroundImage: imagepath==""?null:FileImage(File(imagepath)),
                    ),
                    Positioned(
                        bottom: 7.h,
                        right: 7.h,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (context) {
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
                            },);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 20,
                            child: CircleAvatar(
                              child: Icon(Icons.camera_alt_outlined,color: Colors.black),
                      radius: 15.h,
                      backgroundColor: Colors.white,
                    ),
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 5.h,),
                textFields(nameController, "Product Name"),
                textFields(companyController, "Company Name"),
                textFields(priceController, "Price"),
                textFields(discountController, "Discount"),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratings=rating;
                    print(ratings);
                    setState(() {

                    });
                  },
                ),
                textFields(descController, "Description"),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 14.h,horizontal: 20.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  height: 40.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      onPressed:() async {
                        if(nameController.text!=""&&companyController.text!=""&&priceController.text!=""&&discountController.text!=""&&ratings!=0.0&&descController.text!="")
                          {
                            File file = File(imagepath);
                            String imgurl = base64Encode(file.readAsBytesSync());
                            Map map = {
                              'name': nameController.text,
                              'company': companyController.text,
                              'price': priceController.text,
                              'rating': ratings.toString(),
                              'discount': discountController.text,
                              'image': imgurl,
                              'description': descController.text,
                            };
                            var url = Uri.parse(
                                'https://krishnabeti.000webhostapp.com/ecommerce_insertproduct.php');
                            setState(() {});
                            showProgress=true;
                            setState(() {

                            });
                            var response = await http.post(url, body: map);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNaviagtionBarPage(),));
                            infoToast("Success", "Data Uploaded", context);
                          }
                        else
                        {
                          errorToast("Warning", "Please Fill All Fields", context);
                        }
                      },
                      child: showProgress?LoadingAnimationWidget.threeArchedCircle(
                          color: Colors.black,
                          size: 40):Text("Update Data",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold))
                  )
                )
              ],
            ),
          ),
      ),
    );
  }
  Widget textFields(TextEditingController controller,String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextField(
        controller: controller,
        maxLines: controller==descController?5:null,
        keyboardType: controller==descController?TextInputType.multiline:null,
        decoration: InputDecoration(
          hintText: hint,
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3)),
        ),
      ),
    );
  }
}
