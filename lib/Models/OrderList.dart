import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersListModel {
  int? listId;
  String date;
  String storeName;
  String storeAddress;

  OrdersListModel(
      {this.storeName = '',
      this.date = '',
      this.listId,
      this.storeAddress = ''});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ListId': listId,
      'Date': date,
      'StoreName': storeName,
      "StoreAddress": storeAddress
    };
    return map;
  }

  factory OrdersListModel.fromMap(Map<String, dynamic> map) => OrdersListModel(
        listId: map['ListId'],
        date: map['Date'],
        storeName: map['StoreName'],
        storeAddress: map['StoreAddress'],
      );
  factory OrdersListModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      OrdersListModel(
        listId: doc['ListId'],
        date: doc['Date'],
        storeName: doc['StoreName'],
        storeAddress: doc['StoreAddress'],
      );
}
