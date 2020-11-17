import 'package:get/get.dart';
import 'package:share/share.dart';
// import 'package:flutter_share/flutter_share.dart';

class ShareController extends GetxController {
  Future<void> shareApp(String text) async {
    Share.share(text);
    // await FlutterShare.share(
    //     title: "Share Order", text: text, chooserTitle: "MediTech Order");
  }
}
