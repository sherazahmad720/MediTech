import 'package:flutter/material.dart';
// import 'package:medi_tech/main.dart';

Widget medicineCard(String type, String name, String price) {
  return Card(
      child: Padding(
    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(60),
            // image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
          ),
        ),
        Text(name),
        Text(price,
            style:
                TextStyle(fontStyle: FontStyle.italic, color: Colors.orange)),
      ],
    ),
  ));
}
