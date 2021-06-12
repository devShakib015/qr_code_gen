import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_gen/qr_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'QR CODE GEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      )),
      home: QRPage(),
    );
  }
}
