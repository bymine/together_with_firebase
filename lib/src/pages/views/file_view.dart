import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/pages/components/file_folder_thumbnail.dart';
import 'package:together_with_firebase/src/pages/components/file_pie_chart_thumbnail.dart';
import 'package:together_with_firebase/src/pages/components/latest_file_list_view.dart';
import 'package:together_with_firebase/src/pages/views/add_file_page.dart';

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
                  children: const [
                    FilePieChartThumbnail(),
                    SizedBox(
                      height: 36,
                    ),
                    FileFolderThumbnail(),
                    SizedBox(
                      height: 36,
                    ),
                    Text(
                      "최근 파일",
                      style: TextStyle(fontSize: 20),
                    ),
                    LatestFileListView(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
