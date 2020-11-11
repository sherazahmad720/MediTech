import 'package:flutter/material.dart';
// import 'package:medi_tech/main.dart';

Widget medicineCard(String type, String name, String price) {
  String picname = "other.jpg";
  if (type == "Capsules") {
    picname = "capsule.jpg";
  } else if (type == "Drops") {
    picname = "drops.jpg";
  } else if (type == "Injections") {
    picname = "injection.jpg";
  } else if (type == "Liquid") {
    picname = "liquid.jpg";
  } else if (type == "Tablet") {
    picname = "tablet.jpg";
  } else {
    picname = "other.jpg";
  }
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
            image: DecorationImage(
                image: AssetImage("assets/images/$picname"), fit: BoxFit.cover),
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
