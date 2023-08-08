import 'package:ecommerce/screens/add_products_page.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:ecommerce/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  List editable=[true,true,true,true];
  bool updateVisibility=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=userList[1];
    emailController.text = userList[2];
    passwordController.text = userList[3];
    genderController.text = userList[4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
      children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100.h),
                height: 180.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 180.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        "Hi! ${userList[1]}",
                        style: GoogleFonts.robotoSlab(
                            color: Colors.black, fontSize: 25.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Welcome To The Shopping Hub",
                        style: GoogleFonts.robotoSlab(
                            color: Colors.black, fontSize: 15.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54
                        ),
                        onPressed: () {
                            editable=[false,false,false,false];
                            updateVisibility=true;
                            setState(() {

                            });
                        },
                        child: Text("Edit Profile"),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 75.h,
                        child: CircleAvatar(
                          radius: 70.h,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(userList[5]),
                        ),
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        Visibility(
          visible: updateVisibility,
          child: showDataTextfield(nameController,editable[0],"Name",),),
          showDataTextfield(emailController,editable[1],"Email"),
          showDataTextfield(passwordController,editable[2],"Password"),
          showDataTextfield(genderController,editable[3],"Gender"),
        Visibility(
          visible: updateVisibility,
          child: Container(
            constraints: BoxConstraints.loose(Size.fromHeight(30.h)),
            color: Colors.green,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54
              ),
              onPressed: () async {
                    updateVisibility=false;
                    editable=[true,true,true,true];
                    Map map = {
                      'id':userList[0],
                      'name': nameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'gender': genderController.text,
                    };
                    var url = Uri.parse(
                        'https://krishnabeti.000webhostapp.com/ecommerce_updateuser.php');
                    var response = await http.post(url, body: map);
                    infoToast("Success", "Data Updated", context);
                    setState(() {

                    });
              },
              child: Text("Update Data"),
            ),
          ),
        ),
        SizedBox(height: 20.h,),
        Buttons(icon: Icon(Icons.add),name: "Add Item",onpress: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddProductsPage(),));
        },),
        Buttons(icon: Icon(Icons.logout),name: "LogOut",onpress: () {
          SharedPreferenceData.preferences!.setBool("key", false);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        },),
        Buttons(icon: Icon(Icons.delete), name: "Delete Account",
          onpress: () {
            showDialog(context: _scaffoldKey.currentContext!, builder: (context) {
              return AlertDialog(
                title: Text("Are you sure want to delete your account?"),
                actions: [
                  ElevatedButton(onPressed: () async {

                    Navigator.of(context).pop();
                    Map map = {
                    'id':userList[0]
                    };
                    var url = Uri.parse(
                    'https://krishnabeti.000webhostapp.com/ecommerce_deleteuser.php');
                    var response = await http.post(url, body: map);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                    SharedPreferenceData.preferences!.setBool("key", false);
                    infoToast("Success", "Deleted Account", context);

                  }, child: Text("Yes")),
                  ElevatedButton(onPressed: () {

                    Navigator.pop(context);

                  }, child: Text("No")),
                ],
              );
            },);
        },)
      ],
    ),
        ));
  }

  Widget showDataTextfield(TextEditingController controller,bool flag,String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextField(
        readOnly: flag,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
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
Widget Buttons({required Icon icon, required String name, required Function() onpress}){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 14.h,horizontal: 20.w),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20)
    ),
    height: 40.h,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black54,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        onPressed:() {
          onpress();
        },
        child:Row(
          children: [
            icon,
            Text(name)
          ],
        )),
  );
}
