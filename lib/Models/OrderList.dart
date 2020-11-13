class OrdersList {
  int orderid;
  String date;
  String storeName;

  OrdersList({this.storeName, this.date, this.orderid});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'OrderId': orderid,
      'Date': date,
      'StoreName': storeName,
    };
    return map;
  }

  OrdersList.fromMap(Map<String, dynamic> map) {
    orderid = map['OrderId'];
    date = map['Date'];
    storeName = map['StoreName'];
  }
}
