// import 'package:aliza_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class HeadingCard extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController());
  final String heading;
  final String count;
  final Color color;
  final Icon icon;
  HeadingCard({this.color, this.count, this.heading, this.icon});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal:10),
        // height: 60,
        width: Get.width / 2 - 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff042c5c).withOpacity(0.47),
                    ),
                  ),
                  Text(
                    count,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xff042c5c),
                    ),
                  )
                ],
              ),
              Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(18)),
                  child: icon),
            ],
          ),
        ),
      ),
    );
  }
}
