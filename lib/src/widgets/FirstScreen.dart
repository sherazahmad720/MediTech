import 'package:flutter/material.dart';
import 'package:medi_tech/main.dart';

Widget FirstScreen(String type, String img, String price) {
  return ListView(
    children: [
      Card(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
              ),
            ),
            Text(type),
            Text(price),
          ],
        ),
      )),
    ],
  );
}
