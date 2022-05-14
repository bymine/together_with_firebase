import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/components/text_input_field.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';

class AddFilePage extends GetView<FileController> {
  const AddFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("파일 업로드"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInputField(
                controller: controller.fileTitleController, hintText: "제목"),
            const SizedBox(
              height: 36,
            ),
            Obx(
              () => TextInputField(
                controller: null,
                hintText: controller.fileName,
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.selectFile();
                    },
                    icon: const Icon(LineIcons.fileUpload)),
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
                  controller.uploadFileToDatabase();
                },
                child: const Text("파일 업로드"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
