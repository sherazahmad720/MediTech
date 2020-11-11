class Orders {
  int orderid;
  String medicalStore;
  String DateandTime;
  String totalQty;
  String M_id;

  Orders(
      {this.DateandTime,
      this.M_id,
      this.medicalStore,
      this.orderid,
      this.totalQty});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': orderid,
      'medicalStore': medicalStore,
      'DateandTime': DateandTime,
      'totalQty': totalQty,
      'M_id': M_id,
    };
    return map;
  }

  Orders.fromMap(Map<String, dynamic> map) {
    orderid = map['id'];
    medicalStore = map['medicalStore'];
    DateandTime = map['DateandTime'];
    totalQty = map['totalQty'];
    M_id = map['M_id'];
  }
}
