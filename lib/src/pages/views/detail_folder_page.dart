import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:together_with_firebase/src/models/file.dart';
import 'package:together_with_firebase/src/pages/components/file_list_tile.dart';

class DetailFolderPage extends StatelessWidget {
  final Folder folder;
  const DetailFolderPage({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FolderDetailView(folder: folder),
            Container(
              padding:
                  EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${folder.fileMap.keys.first} 파일",
                    style: const TextStyle(fontSize: 20),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: folder.files.length,
                      itemBuilder: (context, index) =>
                          FileListTile(fileData: folder.files[index]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FolderDetailView extends StatelessWidget {
  const FolderDetailView({
    Key? key,
    required this.folder,
  }) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
      height: Get.height * 0.4,
      decoration: const BoxDecoration(
          color: Color(0xff252839),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    LineIcons.angleLeft,
                    color: Colors.white,
                  )),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Icon(
                folder.icon,
                color: folder.color,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                folder.fileMap.keys.first,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                folder.folderSize.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Mb",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "30 Mb",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Used",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        Text(
                          "Free",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          LinearPercentIndicator(
            lineHeight: 8,
            barRadius: const Radius.circular(4),
            backgroundColor: Colors.white54,
            percent: folder.folderSize / 30,
            animation: true,
            progressColor: folder.color,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
