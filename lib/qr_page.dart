import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:qr_code_gen/qr_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget {
  final QRController controller = Get.put(QRController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator"),
        leading: Icon(Icons.qr_code),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: "Qr Code Gen",
                applicationLegalese: "devShakib",
                applicationVersion: "1.0.3",
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Simple Qr Code Generator!!"),
                  )
                ],
              );
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Obx(
                  () => QrImage(
                    data: controller.data.value,
                    size: controller.size.value,
                    backgroundColor: controller.bgColor.value,
                    padding: EdgeInsets.all(controller.padding.value),
                    dataModuleStyle: QrDataModuleStyle(
                      color: controller.dataModuleColor.value,
                      dataModuleShape: controller.qrDataModuleShape[
                          controller.qrDataModuleShapeValue.value],
                    ),
                    eyeStyle: QrEyeStyle(
                      color: controller.eyeColor.value,
                      eyeShape:
                          controller.qrEyeShape[controller.qrEyeValue.value],
                    ),
                    gapless: !controller.gapLess.value,
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(16)),
              ),
              onPressed: () {
                Get.bottomSheet(
                  ConfigPanel(controller: controller),
                  barrierColor: Colors.black26,
                );
              },
              icon: Icon(Icons.tune),
              label: Text("Config"),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ConfigPanel extends StatelessWidget {
  const ConfigPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final QRController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black54,
            Colors.black87,
            Colors.black,
          ],
        ),
      ),
      child: Settings(controller: controller),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final QRController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              "Your Data",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.textEditingController,
              onChanged: (value) {
                if (value.length == 0) {
                  controller.data.value = controller.googleUrl;
                } else
                  controller.data.value = value;
              },
              decoration: InputDecoration(
                labelText: "Data",
                prefixIcon: Icon(Icons.text_snippet_rounded),
                hintText: controller.googleUrl,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Size",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Slider.adaptive(
              max: 340,
              min: 100,
              value: controller.size.value,
              onChanged: (value) {
                controller.size.value = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Padding",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Slider.adaptive(
              max: 24,
              min: 4,
              value: controller.padding.value,
              onChanged: (value) {
                controller.padding.value = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: Text(
                "Background Color",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                ColorPicker(
                  pickerAreaHeightPercent: 0.2,
                  displayThumbColor: true,
                  showLabel: false,
                  pickerColor: controller.bgColor.value,
                  onColorChanged: (color) {
                    controller.bgColor.value = color;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Eye Shape",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ToggleButtons(
              onPressed: (value) {
                controller.qrEyeValue.value = value;
              },
              color: Colors.white,
              fillColor: Colors.blue,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              children: controller.qrEyeShape
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        e.toString().substring(11).toUpperCase(),
                      ),
                    ),
                  )
                  .toList(),
              isSelected: controller.qrEyeShape.map((e) {
                if (controller.qrEyeValue.value ==
                    controller.qrEyeShape.indexOf(e))
                  return true;
                else
                  return false;
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Data Module Shape",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ToggleButtons(
              onPressed: (value) {
                controller.qrDataModuleShapeValue.value = value;
              },
              color: Colors.white,
              fillColor: Colors.blue,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              children: controller.qrDataModuleShape
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        e.toString().substring(18).toUpperCase(),
                      ),
                    ),
                  )
                  .toList(),
              isSelected: controller.qrDataModuleShape.map((e) {
                if (controller.qrDataModuleShapeValue.value ==
                    controller.qrDataModuleShape.indexOf(e))
                  return true;
                else
                  return false;
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: Text(
                "Eye Color",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                ColorPicker(
                  pickerAreaHeightPercent: 0.2,
                  displayThumbColor: true,
                  showLabel: false,
                  pickerColor: controller.eyeColor.value,
                  onColorChanged: (color) {
                    controller.eyeColor.value = color;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: Text(
                "Data Module Color",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                ColorPicker(
                  pickerAreaHeightPercent: 0.2,
                  displayThumbColor: true,
                  showLabel: false,
                  pickerColor: controller.dataModuleColor.value,
                  onColorChanged: (color) {
                    controller.dataModuleColor.value = color;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Gap Between Modules",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Switch(
                    value: controller.gapLess.value,
                    onChanged: (value) {
                      controller.gapLess.value = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
