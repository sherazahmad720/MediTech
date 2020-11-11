class Orders {
  int orderid;
  String listid;
  String Med_id;
  String price;

  Orders({this.Med_id, this.listid, this.orderid, this.price});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': orderid,
      'listid': listid,
      'Med_id': Med_id,
      'price': price,
    };
    return map;
  }

  Orders.fromMap(Map<String, dynamic> map) {
    orderid = map['id'];
    listid = map['listid'];
    Med_id = map['Med_id'];
    price = map['price'];
  }
}
