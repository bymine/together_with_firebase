import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/pages/components/add_file_page.dart';

class FileView extends GetView<FileController> {
  const FileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(
            () => DropdownButton(
              isExpanded: true,
              value: controller.currentproject.value,
              underline: Container(),
              items: controller.liveProjects
                  .map(
                    (element) => DropdownMenuItem(
                      value: element,
                      child: Text(element.title),
                    ),
                  )
                  .toList(),
              onChanged: (Project? value) {
                controller.changeProject(value!);
              },
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => AddFilePage());
                },
                icon: const Icon(LineIcons.fileUpload))
          ]),
      body: SingleChildScrollView(
        child: Container(
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
                height: 36,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      controller.folders.length,
                      (index) => Container(
                            margin: const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: controller.folders[index].color
                                    .withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            width: Get.width * 0.30,
                            height: Get.height * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    LineIcons.imageFile,
                                    color: controller.folders[index].color,
                                  ),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                Text(
                                  controller.folders[index].title,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "${controller.folders[index].items} items",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                const Spacer(),
                              ],
                            ),
                          )),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const Text("최근 파일"),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.latestFiles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(LineIcons.fileInvoice),
                      title: Text(controller.latestFiles[index].title),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Folder {
  String title;
  int items;
  Color color;
  IconData icon;
  Folder(
      {required this.title,
      required this.items,
      required this.color,
      required this.icon});
}
