class Orders {
  int listId;
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
      this.listId,
      this.totalQty});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ListId': listId,
      'StoreName': medicalStore,
      'Date': date,
      'SPrice': price,
      'Quantity': totalQty,
      'medName': medName,
    };
    return map;
  }

  Orders.fromMap(Map<String, dynamic> map) {
    listId = map['ListId'];
    medicalStore = map['StoreName'];
    date = map['Date'];
    price = map['SPrice'];
    totalQty = map['Quantity'];
    medName = map['medName'];
  }
}
