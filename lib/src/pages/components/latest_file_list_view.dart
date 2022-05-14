import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';
import 'package:together_with_firebase/src/pages/components/file_list_tile.dart';

class LatestFileListView extends GetView<FileController> {
  const LatestFileListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.latestFiles.length,
        itemBuilder: (context, index) {
          return FileListTile(
            fileData: controller.latestFiles[index],
          );
        });
  }
}
