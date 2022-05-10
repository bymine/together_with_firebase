import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/components/text_input_field.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';

class DetailProjectPage extends GetView<HomeController> {
  final Project project;
  const DetailProjectPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Stack(
          children: [
            Image.network(
              project.imageUrl,
              width: Get.width,
              height: Get.height,
              fit: BoxFit.fill,
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xffEBC565),
                    minimumSize: Size(Get.width, 60)),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('참여코드 입력'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("참여코드 입력이 필요한 프로젝트 입니다"),
                          TextInputField(
                            controller: controller.pwController,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text("취소"),
                          onPressed: () => Get.back(),
                        ),
                        TextButton(
                          child: const Text("완료"),
                          onPressed: () {
                            controller.joinProject(project);
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("프로젝트 참여하기"),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      LineIcons.times,
                      color: Colors.white,
                    ))
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    project.notes,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
