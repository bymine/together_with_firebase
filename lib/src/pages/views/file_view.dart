import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';

class FileView extends GetView<FileController> {
  const FileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("파일"), actions: [
        IconButton(onPressed: () {}, icon: const Icon(LineIcons.fileUpload))
      ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PieChart(
                  dataMap: controller.fileTypeMap,
                  chartType: ChartType.ring,
                  chartRadius: Get.width * 0.2,
                  ringStrokeWidth: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    controller.fileTypeMap.length,
                    (index) => Container(
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          width: Get.width * 0.45,
                          height: Get.height * 0.2,
                        )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("최근 파일"),
            ListView.builder(
                shrinkWrap: true,
                itemCount: controller.latestFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(LineIcons.fileInvoice),
                    title: Text(controller.latestFiles[index].title),
                  );
                })
          ],
        ),
      ),
    );
  }
}
