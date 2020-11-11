class Orders {
  int orderid;
  String medicalStore;
  String dateandTime;
  String totalQty;
  String mId;

  Orders(
      {this.dateandTime,
      this.mId,
      this.medicalStore,
      this.orderid,
      this.totalQty});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': orderid,
      'medicalStore': medicalStore,
      'dateandTime': dateandTime,
      'totalQty': totalQty,
      'mId': mId,
    };
    return map;
  }

  Orders.fromMap(Map<String, dynamic> map) {
    orderid = map['id'];
    medicalStore = map['medicalStore'];
    dateandTime = map['dateandTime'];
    totalQty = map['totalQty'];
    mId = map['mId'];
  }
}
