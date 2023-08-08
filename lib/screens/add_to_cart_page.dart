import 'dart:convert';
import 'dart:ffi';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/bottom_naviagtionbar_page.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/profile_page.dart';
import 'package:ecommerce/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../modalclasses/carts.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  parseJson4? p4;
  bool isLoaded=false;
  List qty=[];
  double totalPayment=0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartItems();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "The Shopping Hub",
          style: GoogleFonts.bungeeSpice(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => onbackPressed(),
        child: isLoaded?(p4!.Carts.isEmpty?
        Center(
          child: Text("No Items Added to Your Cart"),
        ):
        ListView.builder(
          itemCount: p4!.Carts.length,
          itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: 100.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                              height: 100.h,
                              width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("${p4!.Carts[index].image}")
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${p4!.Carts[index].itemname}",style: GoogleFonts.roboto(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold
                          )),
                          SizedBox(height: 5.h,),
                          Text("${p4!.Carts[index].discount} % Discount applied"),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(onPressed: () {
                                    if (qty[index]>0) {
                                      qty[index]-=1;
                                    }
                                    setState(() {

                                    });
                                    totalPaymentGetter();
                                  }, icon: Icon(Icons.remove)),
                                  Text("${qty[index]}",style: TextStyle(fontSize: 20.sp)),
                                  IconButton(onPressed: () {
                                    qty[index]+=1;
                                    setState(() {

                                    });
                                    totalPaymentGetter();
                                  }, icon: Icon(Icons.add)),
                                ],
                              ),
                              Text("₹ ${p4!.Carts[index].price}",style: GoogleFonts.abyssinicaSil(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp
                              )),
                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: IconButton(onPressed: () async {
                  infoToast("Success", "Removed from Cart", context);
                  cartItems-=1;
                  SharedPreferenceData.preferences!.setInt("cartItems", cartItems);
                  Map map = {
                    'itemname': p4!.Carts[index].itemname,
                  };
                  isLoaded=false;
                  setState(() {

                  });
                  var url = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_deletecarts.php');
                  var response = await http.post(url, body: map);
                  getCartItems();
                  isLoaded=true;
                  setState(() {

                  });
                }, icon: Icon(Icons.remove_circle,color: Colors.red,)),
                top: 0.h,
                right: 0.w,
              )
            ],
          );
        },))
            :shimmerEffect(),
      ),
      bottomNavigationBar: Container(
        height: 93.h,
        width: double.infinity,
        child: Column(
          children: [
            Text("Total : $totalPayment",style: GoogleFonts.abyssinicaSil(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold
            )),
            Buttons(name: "Checkout",icon: Icon(Icons.check),onpress: () {

            },),
          ],
        ),
      ),
    );
  }

  Shimmer shimmerEffect(){
    return Shimmer.fromColors(
        child:
        ListView.builder(itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            height: 100.h,
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            width: double.infinity,
          );
        },),
        baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!);
  }

  onbackPressed() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNaviagtionBarPage(),));
  }

  getCartItems()
  async {
    Map map={
      'userid':userList[0]
    };
    var url = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_getcartitems.php');
    var response = await http.post(url,body: map);
    Map map2=jsonDecode(response.body);
    p4=parseJson4(map: map2);
    qty=List.filled(p4!.Carts.length, 0);
    isLoaded=true;
    setState(() {
      
    });
  }
  totalPaymentGetter(){
    double pmt=0.0;
    for(int i=0;i<p4!.Carts.length;i++)
      {
        pmt+=double.parse("${p4!.Carts[i].price}")*qty[i];
      }
    totalPayment=pmt;
    setState(() {

    });
  }
}

