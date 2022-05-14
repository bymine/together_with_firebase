import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';
import 'package:together_with_firebase/src/models/file.dart';
import 'package:together_with_firebase/src/pages/views/detail_folder_page.dart';

class FileFolderThumbnail extends GetView<FileController> {
  const FileFolderThumbnail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            controller.folders.length,
            (index) => GestureDetector(
                  onTap: () {
                    Get.to(() =>
                        DetailFolderPage(folder: controller.folders[index]));
                  },
                  child: FolderCardBox(
                    folder: controller.folders[index],
                  ),
                )),
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
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 1),
          ]),
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
              folder.icon,
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
            "${folder.fileMap.values.first.toStringAsFixed(0)} Files",
            style: const TextStyle(color: Colors.black54),
          ),
          if (folder.folderSize != 0)
            Text(
              folder.folderSize.toStringAsFixed(2) + "MB",
              style: const TextStyle(color: Colors.black54),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
