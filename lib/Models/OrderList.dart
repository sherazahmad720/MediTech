class OrdersList {
  int listId;
  String date;
  String storeName;

  OrdersList({this.storeName, this.date, this.listId});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ListId': listId,
      'Date': date,
      'StoreName': storeName,
    };
    return map;
  }

  OrdersList.fromMap(Map<String, dynamic> map) {
    listId = map['ListId'];
    date = map['Date'];
    storeName = map['StoreName'];
  }
}
