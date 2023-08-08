class parseJson4
{
  List<carts> Carts=[];
  parseJson4({required Map map})
  {
    for(int i=0;i<map['carts'].length;i++)
    {
      carts p1=carts(map: map['carts'][i]);
      Carts.add(p1);
    }
  }
}
class carts{
  String? id;
  String? userid;
  String? itemname;
  String? price;
  String? image;
  String? discount;

  carts({required Map map})
  {
    id=map['id'];
    userid=map['userid'];
    itemname=map['itemname'];
    price=map['price'];
    image=map['image'];
    discount=map['discount'];
  }
}