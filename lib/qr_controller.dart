import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRController extends GetxController {
  String googleUrl = "https://google.com";
  GlobalKey globalKey = new GlobalKey();

  late TextEditingController textEditingController;

  RxString data = "".obs;
  RxDouble size = 300.0.obs;
  RxDouble padding = 16.0.obs;
  Rx<Color> bgColor = Colors.white.obs;

  Rx<Color> eyeColor = Colors.black.obs;
  RxInt qrEyeValue = 0.obs;
  List<QrEyeShape> qrEyeShape = [
    QrEyeShape.square,
    QrEyeShape.circle,
  ];

  Rx<Color> dataModuleColor = Colors.black.obs;
  RxInt qrDataModuleShapeValue = 0.obs;
  List<QrDataModuleShape> qrDataModuleShape = [
    QrDataModuleShape.square,
    QrDataModuleShape.circle
  ];

  RxBool gapLess = false.obs;

  @override
  void onInit() {
    textEditingController = TextEditingController();

    super.onInit();
  }
}
