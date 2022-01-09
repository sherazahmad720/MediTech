import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalStore {
  int? id;
  String name;
  String address;
  String status;

  MedicalStore({this.address = '', this.id, this.name = '', this.status = ''});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'StoreId': id,
      'StoreName': name,
      'StoreAddress': address,
      'StoreStatus': status,
    };
    return map;
  }

  factory MedicalStore.fromMap(Map<String, dynamic> map) => MedicalStore(
        id: map['StoreId'],
        name: map['StoreName'],
        address: map['StoreAddress'],
        status: map['StoreStatus'],
      );
  factory MedicalStore.fromDocumentSnapshot(DocumentSnapshot doc) =>
      MedicalStore(
        id: doc['StoreId'],
        name: doc['StoreName'],
        address: doc['StoreAddress'],
        status: doc['StoreStatus'],
      );
}
