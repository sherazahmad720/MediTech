import 'package:flutter/material.dart';
// import 'package:medi_tech/main.dart';

Widget medicalStoreCard(String name, String address, String status) {
  return Card(
      child: Padding(
    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(address,
            style:
                TextStyle(fontStyle: FontStyle.italic, color: Colors.orange)),
      ],
    ),
  ));
}
