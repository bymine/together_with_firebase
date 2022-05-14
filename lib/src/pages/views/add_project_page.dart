import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/components/text_input_field.dart';
import 'package:together_with_firebase/src/controllers/add_project_controller.dart';

class AddProjectPage extends GetView<AddProjectController> {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로젝트 생성"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "프로젝트 배경 설정",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Stack(
              children: [
                Obx(
                  () => Container(
                    width: double.infinity,
                    height: Get.height * 0.25,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: controller.image.isEmpty
                            ? Image.asset(
                                    "assets/images/project_background_1.png")
                                .image
                            : Image.file(controller.image.first).image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: GestureDetector(
                    onTap: () {
                      controller.getImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: const Icon(
                        LineIcons.image,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
            TextInputField(
                controller: controller.titleController, hintText: "제목"),
            const SizedBox(
              height: 36,
            ),
            TextInputField(
              controller: controller.notesController,
              hintText: "소개글",
              inputType: TextInputType.multiline,
            ),
            const SizedBox(
              height: 36,
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      controller: controller.pwController,
                      hintText: "비밀번호",
                      readOnly: !controller.isLock.value,
                    ),
                  ),
                  Column(
                    children: [
                      const Text("잠금 설정"),
                      Checkbox(
                          value: controller.isLock.value,
                          onChanged: (value) {
                            controller.changeLock(value!);
                            FocusNode().dispose();
                          }),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xffEBC565),
                    minimumSize: Size(Get.width, 50)),
                onPressed: () {
                  controller.createProject();
                  if (controller.isAddComplete.value) Get.back();
                },
                child: const Text("프로젝트 생성"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
