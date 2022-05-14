import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';
import 'package:together_with_firebase/src/models/file.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/pages/components/add_file_page.dart';
import 'package:together_with_firebase/src/pages/components/detail_folder_page.dart';
import 'package:together_with_firebase/src/pages/components/file_list_tile.dart';

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
                  Get.to(() => const AddFilePage());
                },
                icon: const Icon(LineIcons.fileUpload))
          ]),
      body: Obx(
        () {
          if (controller.isLoadComplete.value) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        PieChart(
                          colorList: controller.folderColorList,
                          dataMap: controller.folderMap,
                          chartType: ChartType.ring,
                          chartRadius: Get.width * 0.2,
                          ringStrokeWidth: 4,
                          chartValuesOptions: const ChartValuesOptions(
                              chartValueBackgroundColor: Colors.transparent,
                              showChartValuesInPercentage: true),
                          legendOptions:
                              const LegendOptions(showLegends: false),
                        ),
                        SizedBox(
                          width: Get.width * 0.1,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  controller.folders.length,
                                  (index) => Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor: controller
                                                .folders[index].color
                                                .withOpacity(0.6),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              controller.folders[index].fileMap
                                                  .keys.first,
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Text(
                                            controller.folders[index].folderSize
                                                    .toStringAsFixed(0) +
                                                " Files",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ))),
                        )
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
                            (index) => GestureDetector(
                                  onTap: () {
                                    Get.to(() => DetailFolderPage(
                                        folder: controller.folders[index]));
                                  },
                                  child: FolderCardBox(
                                    folder: controller.folders[index],
                                  ),
                                )),
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    const Text("최근 파일"),
                    Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.latestFiles.length,
                          itemBuilder: (context, index) {
                            return FileListTile(
                              fileData: controller.latestFiles[index],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class FolderCardBox extends StatelessWidget {
  const FolderCardBox({Key? key, required this.folder}) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: folder.color.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
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
              color: folder.color,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            folder.fileMap.keys.first,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            "${folder.fileMap.values.first.toStringAsFixed(0)} items",
            style: const TextStyle(color: Colors.black54),
          ),
          Text(folder.folderSize.toStringAsFixed(2) + "MB"),
          const Spacer(),
        ],
      ),
    );
  }
}
