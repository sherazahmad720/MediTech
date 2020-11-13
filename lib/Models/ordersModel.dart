class Orders {
  int orderId;
  String medicalStore;
  String date;
  String price;
  String totalQty;
  String medName;

  Orders(
      {this.date,
      this.medName,
      this.price,
      this.medicalStore,
      this.orderId,
      this.totalQty});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'OrderId': orderId,
      'StoreName': medicalStore,
      'Date': date,
      'SPrice': price,
      'Quantity': totalQty,
      'medName': medName,
    };
    return map;
  }

  Orders.fromMap(Map<String, dynamic> map) {
    orderId = map['OrderId'];
    medicalStore = map['StoreName'];
    date = map['Date'];
    price = map['SPrice'];
    totalQty = map['Quantity'];
    medName = map['medName'];
  }
}
