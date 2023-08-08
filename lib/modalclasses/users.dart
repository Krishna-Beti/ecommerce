
class parseJason {

  List<users> Users=[];
  parseJason({required Map map})
  {
    for(int i=0;i<map['users'].length;i++)
      {
        users u1=users(map: map['users'][i]);
        Users.add(u1);
      }
  }
}

class users {
  String? id;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? image;

  users({required Map map})
  {
     id=map['id'];
     name=map['name'];
     email=map['email'];
     password=map['password'];
     gender=map['gender'];
     image=map['image'];
  }
}
