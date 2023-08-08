class parseJson3
{
  List<likes> Likes=[];
  parseJson3({required Map map})
  {
    for(int i=0;i<map['likes'].length;i++)
    {
      likes p1=likes(map: map['likes'][i]);
      Likes.add(p1);
    }
  }
}
class likes{
  String? id;
  String? userid;
  String? itemname;
  String? company;
  String? price;
  String? image;
  String? discount;
  String? rating;
  String? description;

  likes({required Map map})
  {
    id=map['id'];
    userid=map['userid'];
    itemname=map['itemname'];
    company=map['company'];
    price=map['price'];
    image=map['image'];
    discount=map['discount'];
    rating=map['rating'];
    description=map['description'];
  }
}