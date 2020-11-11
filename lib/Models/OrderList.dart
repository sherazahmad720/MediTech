class Orders {
  int orderid;
  String listid;
  String medId;
  String price;

  Orders({this.medId, this.listid, this.orderid, this.price});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': orderid,
      'listid': listid,
      'medId': medId,
      'price': price,
    };
    return map;
  }

  Orders.fromMap(Map<String, dynamic> map) {
    orderid = map['id'];
    listid = map['listid'];
    medId = map['medId'];
    price = map['price'];
  }
}
