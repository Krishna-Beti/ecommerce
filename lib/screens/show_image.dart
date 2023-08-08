import 'package:ecommerce/screens/product_description_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../modalclasses/products.dart';

class ShowImagePage extends StatefulWidget {

  products product;
  ShowImagePage({required this.product});

  @override
  State<ShowImagePage> createState() => _ShowImagePageState();
}

class _ShowImagePageState extends State<ShowImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () => onbackpressed(),
        child: Container(
          child: Center(
            child: PhotoView(
              imageProvider: NetworkImage("${widget.product.image}"),
            ),
          ),
        ),
      ),
    );
  }
  onbackpressed(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDescriptionPage(product: widget.product),));
  }
}
