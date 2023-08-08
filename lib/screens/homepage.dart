import 'dart:convert';
import 'dart:math';
import 'package:awesome_rating/awesome_rating.dart';
import 'package:ecommerce/modalclasses/products.dart';
import 'package:ecommerce/screens/add_to_cart_page.dart';
import 'package:ecommerce/screens/product_description_page.dart';
import 'package:ecommerce/screens/registration_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/getdata.dart';
import 'package:ecommerce/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../modalclasses/likes.dart';
import 'login_page.dart';
import 'package:badges/badges.dart' as badges;

List userList = [];
int cartItems=0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  parseJson2? p2;
  parseJson3? p3;
  List likesFlag=[];
  List CategoryName=["Smart Phone","Fashion","Furniture","Electronics","Toys & Kids","Two Wheelers"];
  int SliderActiceImage=0;
  List list = [];
  bool isLoaded=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important, color: Colors.black),
            onPressed: () {

            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddToCartPage(),));
            },
            child: Container(
              margin: EdgeInsets.only(top: 14.h,right: 13.w),
              child: badges.Badge(
                badgeContent: Text("${cartItems}"),
                showBadge: cartItems>0?true:false,
                child: Icon(Icons.shopping_cart,color: Colors.black),
                badgeAnimation: badges.BadgeAnimation.scale(),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        title: Text(
          "The Shopping Hub",
          style: GoogleFonts.bungeeSpice(),
        ),
      ),
      body: isLoaded?homeLayout():shimmerEffect()
    );
  }
  Shimmer shimmerEffect(){
    return Shimmer.fromColors(child: Column(
      children: [
        SizedBox(height: 10.h,),
        Container(
          color: Colors.white,
          height: 50.h,
        ),
        SizedBox(height: 20.h,),
        Container(
          height: 150.h,
          color: Colors.white,
        ),
        SizedBox(height: 10.h,),
        Container(
          height: 30.h,
          color: Colors.white,
        ),
        SizedBox(height: 10.h,),
        Expanded(
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 10,mainAxisSpacing: 10,crossAxisCount: 2,mainAxisExtent: 170.h), itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
            );
          },),
        )
      ],
    ), baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!);
  }
  Widget homeLayout(){
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                prefixIcon: Container(
                  margin: EdgeInsets.symmetric(vertical: 7.h,horizontal: 5.w),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 2,color: Colors.black))
                  ),
                  child: Icon(Icons.search,color: Colors.black),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.symmetric(vertical: 7.h,horizontal: 5.w),
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(width: 2,color: Colors.black))
                  ),
                  child: Icon(Icons.mic,color: Colors.black),
                ),
                hintText: "Search Your Items",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 1)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 3)
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Stack(
            children: [
              CarouselSlider.builder(
                  itemCount: 7 , itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 8),
                          blurRadius: 5,
                        )
                      ],
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("SliderImages/slider${index+1}.jpg")
                      )
                  ),
                );
              }, options: CarouselOptions(
                viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    SliderActiceImage=index;
                    setState(() {
                    });
                  },
                  height: 190.h,
                  // autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 2)
              )),
              Positioned(
                  bottom: 20,
                  left: 100.w,
                  child: DotsIndicator(
                    position: SliderActiceImage,
                    dotsCount: 7,
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeColor: Colors.green[900],
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  )
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
            child: Container(
              height: 70.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    width: 70.w,
                    height: 20.h,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/category${index+1}.jpg'),
                        ),
                        Expanded(child: Text(CategoryName[index],textAlign: TextAlign.center,))
                      ],
                    ),
                  );
                },),
            ),
          ),
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDescriptionPage(product: p2!.Products[index]),));
                },
                child: Container(
                  padding: EdgeInsets.only(right: 7.w,left: 7.w,),
                  decoration: BoxDecoration(
                      border: index%2==0?Border(right: BorderSide(color: Colors.black12,width: 1.5),bottom: BorderSide(color: Colors.black12,width: 1.5),top: index==0||index==1?BorderSide(color: Colors.black12,width: 1.5):BorderSide.none):
                      Border(bottom: BorderSide(color: Colors.black12,width: 1.5),top: index==0||index==1?BorderSide(color: Colors.black12,width: 1.5):BorderSide.none)
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex : 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage("${p2!.Products[index].image}")
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          Expanded(
                            flex : 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text("${p2!.Products[index].name}",style: GoogleFonts.robotoSlab(
                                      wordSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                    ),)),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("₹ ${p2!.Products[index].price}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    Text("${p2!.Products[index].discount}% OFF",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Text("ratings",style: TextStyle(color: Colors.grey),),
                                    AwesomeStarRating(
                                      borderColor: Colors.yellow,
                                      size: 20.h,
                                      rating: double.parse("${p2!.Products[index].rating}"),
                                      starCount: 5,
                                      allowHalfRating: true,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        right: 8.w,
                        top: 8.h,
                        child: GestureDetector(
                          onTap: () async {
                            likesFlag[index]=!likesFlag[index];
                            if(likesFlag[index]==true)
                              {
                                infoToast("Success", "Product Added to favourite list", context);
                                Map map = {
                                  'userid':userList[0],
                                  'itemname': p2!.Products[index].name,
                                  'company': p2!.Products[index].company,
                                  'price': p2!.Products[index].price,
                                  'image': p2!.Products[index].image,
                                  'discount': p2!.Products[index].discount,
                                  'rating': p2!.Products[index].rating,
                                  'description': p2!.Products[index].desc,
                                };
                                var url = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_insertlikes.php');
                                var response = await http.post(url, body: map);
                              }
                            else
                            {
                              infoToast("Success", "Product removed from favourite list", context);
                              Map map = {
                                'itemname': p2!.Products[index].name,
                              };
                              var url = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_deletelikes.php');
                              var response = await http.post(url, body: map);
                            }
                            setState(() {

                            });
                          },
                          child: CircleAvatar(
                            radius: 20.w,
                            backgroundColor: Colors.white,
                            child: likesFlag[index]==true?Icon(Icons.favorite,color: Colors.red):Icon(Icons.favorite_border,color: Colors.red),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              );
            },childCount: p2!.Products.length,), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 270.h,
        )),
      ],
    );
  }

   getproducts() async {
     userList = SharedPreferenceData.preferences!.getStringList("userData")!;
     cartItems=SharedPreferenceData.preferences!.getInt("cartItems")??0;
    var url = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_getproducts.php');
    var response = await http.post(url);
    Map map=jsonDecode(response.body);
    p2=parseJson2(map: map);
    likesFlag=List.filled(p2!.Products.length, false);
    Map map1={
      'userid':userList[0]
    };
     var url1 = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_getlikes.php');
     var response1 = await http.post(url1,body: map1);
     Map map2=jsonDecode(response1.body);
     p3=parseJson3(map: map2);
     if(map2['likes']!=null)
       {
         for(int i=0;i<p2!.Products.length;i++)
           {
             for(int j=0;j<p3!.Likes.length;j++)
               {
                 if(p3!.Likes[j].itemname==p2!.Products[i].name)
                   {
                     likesFlag[i]=true;
                   }
               }
           }
       }
    isLoaded=true;
    setState(() {

    });
  }

}
