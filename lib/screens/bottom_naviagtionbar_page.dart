import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/screens/favourites_page.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNaviagtionBarPage extends StatefulWidget {
  const BottomNaviagtionBarPage({super.key});

  @override
  State<BottomNaviagtionBarPage> createState() => _BottomNaviagtionBarPageState();
}

class _BottomNaviagtionBarPageState extends State<BottomNaviagtionBarPage> {
  List Screens=[
    HomePage(),
    HomePage(),
    FavouritesPage(),
    ProfilePage(),
  ];
  int selected=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[selected],
        bottomNavigationBar: CurvedNavigationBar(
          items: [
            Icon(Icons.home,size: 30),
            Icon(Icons.reorder,size: 30),
            Icon(Icons.favorite,size: 30),
            Icon(Icons.person,size: 30),
          ],
          onTap: (value) {
            selected=value;
            setState(() {

            });
          },
          backgroundColor: Colors.white,
          color: Colors.green,
          animationDuration: Duration(milliseconds: 250),
        ),

    );
  }
}
