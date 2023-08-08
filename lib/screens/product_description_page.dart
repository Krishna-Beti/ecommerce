import 'package:ecommerce/constants.dart';
import 'package:ecommerce/modalclasses/products.dart';
import 'package:ecommerce/screens/bottom_naviagtionbar_page.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/registration_page.dart';
import 'package:ecommerce/screens/show_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDescriptionPage extends StatefulWidget {

  products product;
  ProductDescriptionPage({required this.product});

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  int count=0;
  bool isAddedtoCart=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("The Shopping Hub",style: GoogleFonts.bungeeSpice()),
      ),
      body: WillPopScope(
        onWillPop: () => onBackPressed(),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowImagePage(product: widget.product)));
              },
              child: Container(
                height: 340.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${widget.product.image}")
                  )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 310.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text("${widget.product.name}",style: GoogleFonts.robotoSlab(
                                  wordSpacing: 1.5,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                              )),
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: () {
                                  if (count>0) {
                                    count-=1;
                                  }
                                  setState(() {

                                  });
                                }, icon: Icon(Icons.remove)),
                                Text("${count}",style: TextStyle(fontSize: 20.sp)),
                                IconButton(onPressed: () {
                                  count+=1;
                                  setState(() {

                                  });
                                }, icon: Icon(Icons.add)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h,),
                        Text("Manufactured By : ${widget.product.company}",style: GoogleFonts.poppins()),
                        SizedBox(height: 7.h,),
                        Row(
                          children: [
                            Icon(Icons.star,color: Colors.yellow,),
                            Text("${widget.product.rating} Ratings (530 Reviews)")
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Text("Description :-",style: GoogleFonts.poppins(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.h,),
                        Text("${widget.product.desc}",style: GoogleFonts.merriweather(
                          wordSpacing: 2
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        child: Row(
          children: [
            Expanded(child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text("₹ ${widget.product.price}",style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),),
            )),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 20.w),
                height: 40.h,
                child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                     ),
                    onPressed: () async {
                       isAddedtoCart=false;
                      Map map = {
                        'userid':userList[0],
                        'itemname': widget.product.name,
                        'price': widget.product.price,
                        'image': widget.product.image,
                        'discount': widget.product.discount,
                      };
                      setState(() {

                      });
                      var url = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_addtocart.php');
                      var response = await http.post(url, body: map);
                       cartItems+=1;
                       SharedPreferenceData.preferences!.setInt("cartItems", cartItems);
                       isAddedtoCart=true;
                       infoToast("success","Added to your Cart",context);
                       setState(() {

                       });
                }, child: isAddedtoCart?Text("🛒 Add To Cart"):LoadingAnimationWidget.threeArchedCircle(color: Colors.black, size: 40)),
              ),
            )
          ],
        ),
      ),
    );
  }
  onBackPressed(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNaviagtionBarPage(),));
  }
}
