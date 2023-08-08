import 'dart:convert';
import 'package:awesome_rating/awesome_rating.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/product_description_page.dart';
import 'package:ecommerce/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart'
;
import 'package:shimmer/shimmer.dart';
import '../modalclasses/likes.dart';
import '../modalclasses/products.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {

  List likesFlag=[];
  parseJson2? p2;
  parseJson3? p3;
  bool isLoaded=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likesDataGetter();
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
     body: isLoaded?(p3!.Likes.isEmpty?
         Center(
           child: Text("No Items Added to Your Favourite List"),
         )
         :GridView.builder(
       itemCount: p3!.Likes.length,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         mainAxisExtent: 270.h,
       ), itemBuilder: (context, index) {
       return GestureDetector(
         onTap: () {
           for(int i=0;i<p2!.Products.length;i++)
           {
             if(p3!.Likes[index].itemname==p2!.Products[i].name) {
               Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context) =>
                     ProductDescriptionPage(
                         product: p2!.Products[i]),));
             }
           }
         },
         child: Container(
           padding: EdgeInsets.only(right: 7.w,left: 7.w,),
           decoration: BoxDecoration(
               border: index%2==0?Border(right: BorderSide(color: Colors.black12,width: 1.5),bottom: BorderSide(color: Colors.black12,width: 1.5),top: index==0||index==1?BorderSide(color: Colors.black12,width: 1.5):BorderSide.none):
               Border(bottom: BorderSide(color: Colors.black12,width: 1.5),top: index==0||index==1?BorderSide(color: Colors.black12,width: 1.5):BorderSide.none)
           ),
           child: Column(
             children: [
               Expanded(
                 flex : 8,
                 child: Container(
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image: NetworkImage("${p3!.Likes[index].image}")
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
                         Expanded(child: Text("${p3!.Likes[index].itemname}",style: GoogleFonts.robotoSlab(
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
                         Text("₹ ${p3!.Likes[index].price}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                         Text("${p3!.Likes[index].discount}% OFF",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                       ],
                     ),
                     SizedBox(height: 10.h,),
                     Row(
                       children: [
                         Text("ratings",style: TextStyle(color: Colors.grey),),
                         AwesomeStarRating(
                           borderColor: Colors.yellow,
                           size: 20.h,
                           rating: double.parse("${p3!.Likes[index].rating}"),
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
         ),
       );
     },)):shimmerEffect(),
   );
  }

  Shimmer shimmerEffect(){
    return Shimmer.fromColors(
        child:
        GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 10,mainAxisSpacing: 10,crossAxisCount: 2,mainAxisExtent: 170.h), itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
          );
        },), baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!);
  }

  Future<void> likesDataGetter() async {
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
    likesFlag=List.filled(p3!.Likes.length, true);
    isLoaded=true;
    print("++++++++++++++++++++++++${p3!.Likes}");
    setState(() {

    });
  }
}
