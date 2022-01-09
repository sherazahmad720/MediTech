import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  int? orderId;
  String medicalStore;
  String date;
  String price;
  String totalQty;
  String medName;
  String bonus;
  String discount;
  Orders(
      {this.date = '',
      this.medName = '',
      this.price = '',
      this.medicalStore = '',
      this.orderId,
      this.totalQty = '',
      this.bonus = '',
      this.discount = ''});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'OrderId': orderId,
      'StoreName': medicalStore,
      'Date': date,
      'SPrice': price,
      'Quantity': totalQty,
      'medName': medName,
      'bonus': bonus,
      'discount': discount
    };
    return map;
  }

  factory Orders.fromMap(Map<String, dynamic> map) => Orders(
        orderId: map['OrderId'],
        medicalStore: map['StoreName'],
        date: map['Date'],
        price: map['SPrice'],
        totalQty: map['Quantity'],
        medName: map['medName'],
        bonus: map['bonus'],
        discount: map['discount'],
      );
  factory Orders.fromDocumentSnapshot(DocumentSnapshot doc) => Orders(
        orderId: doc['OrderId'],
        medicalStore: doc['StoreName'],
        date: doc['Date'],
        price: doc['SPrice'],
        totalQty: doc['Quantity'],
        medName: doc['medName'],
        bonus: doc['bonus'],
        discount: doc['discount'],
      );
}
