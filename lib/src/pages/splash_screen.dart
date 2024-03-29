import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_tech/src/controllers/color_controller.dart';
import 'package:medi_tech/src/controllers/db_controller.dart';
import 'package:medi_tech/src/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DbController dbController = Get.put(DbController());
  final colors = Get.put(ColorController());
  //NOTE  This function Count The Time Of splash screen
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  //NOTE  This function Tell the Rout of next page
  route() {
    dbController.allFunctions().then((value) => Get.off(HomePage()));
  }

//NOTE  This function call and start the Timer
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: colors.bg,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Text("MediTech",
                style: TextStyle(
                  fontFamily: "Proxima Nova",
                  fontWeight: FontWeight.w700,
                  fontSize: 50,
                  color: Color(0xffffffff),
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 76),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Developed by ",
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: Color(0xffffffff),
                          )),
                      Text(
                        "Sherazi",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Version 0.1 (beta)",
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: Color(0xffffffff),
                      )),
                ],
              )),
        ),
      ]),
    );
  }
}
