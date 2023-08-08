class parseJson2
{
  List<products> Products=[];
  parseJson2({required Map map})
  {
    for(int i=0;i<map['products'].length;i++)
      {
        products p1=products(map: map['products'][i]);
        Products.add(p1);
      }
  }
}
class products{
  String? id;
  String? name;
  String? company;
  String? price;
  String? discount;
  String? rating;
  String? image;
  String? desc;

  products({required Map map})
  {
    id=map['id'];
    name=map['name'];
    company=map['company'];
    price=map['price'];
    discount=map['discount'];
    rating=map['rating'];
    image=map['image'];
    desc=map['description'];
  }
}