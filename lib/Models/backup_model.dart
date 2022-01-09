import 'package:cloud_firestore/cloud_firestore.dart';

class BackupModel {
  BackupModel({this.title = '', this.date = '', this.reference});

  String title;
  String date;
  DocumentReference? reference;

  factory BackupModel.fromDocumentSnapshot(DocumentSnapshot doc) => BackupModel(
        reference: doc.reference,
        title: doc["Title"],
        date: doc["Date"],
      );

  Map<String, dynamic> toMap() => {
        "Title": title,
        "Date": date,
      };
}
