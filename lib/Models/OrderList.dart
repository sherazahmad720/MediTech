class OrdersList {
  int listId;
  String date;
  String storeName;
  String storeAddress;

  OrdersList({this.storeName, this.date, this.listId, this.storeAddress});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ListId': listId,
      'Date': date,
      'StoreName': storeName,
      "StoreAddress": storeAddress
    };
    return map;
  }

  OrdersList.fromMap(Map<String, dynamic> map) {
    listId = map['ListId'];
    date = map['Date'];
    storeName = map['StoreName'];
    storeAddress = map['StoreAddress'];
  }
}
