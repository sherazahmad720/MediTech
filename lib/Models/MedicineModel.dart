import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  int? medId;
  String name;
  String price;
  String type;

  Medicine({this.name = '', this.medId, this.type = '', this.price = ''});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'medId': medId,
      'medName': name,
      'medType': type,
      'medPrice': price,
    };
    return map;
  }

  factory Medicine.fromMap(Map<String, dynamic> map) => Medicine(
        medId: map['medId'],
        name: map['medName'],
        price: map['medPrice'],
        type: map['medType'],
      );
  factory Medicine.fromDocumentSnapshot(DocumentSnapshot doc) => Medicine(
        medId: doc['medId'],
        name: doc['medName'],
        price: doc['medPrice'],
        type: doc['medType'],
      );
}
