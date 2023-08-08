import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modalclasses/users.dart';

Future<Map> loginUser(String email,String password) async {

  Map map1={};
  var url = Uri.parse('https://krishnabeti.000webhostapp.com/ecommerce_loginuser.php');
  var response = await http.post(url);
  Map map=jsonDecode(response.body);
  parseJason p1=parseJason(map: map);
  for(int i=0;i<p1.Users!.length;i++)
  {
    if(email==p1.Users![i].email&&password==p1.Users![i].password)
    {
      map1['id']=p1.Users[i].id;
      map1['name']=p1.Users[i].name;
      map1['email']=p1.Users[i].email;
      map1['password']=p1.Users[i].password;
      map1['gender']=p1.Users[i].gender;
      map1['image']=p1.Users[i].image;
      return map1;
    }
  }
  return map1;
}
