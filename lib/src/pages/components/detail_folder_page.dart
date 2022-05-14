import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:together_with_firebase/src/models/file.dart';

class DetailFolderPage extends StatelessWidget {
  final Folder folder;
  const DetailFolderPage({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
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
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            LineIcons.angleLeft,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        folder.fileMap.keys.first,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        folder.folderSize.toStringAsFixed(2),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 36),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "MB",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Text(
                                  "100 Mb",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Used",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Text(
                                  "Free",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  LinearPercentIndicator(
                    percent: folder.folderSize / 100,
                    animation: true,
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
