import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/components/text_input_field.dart';
import 'package:together_with_firebase/src/controllers/add_schedule_controller.dart';
import 'package:together_with_firebase/src/utils.dart/date_utils.dart';

class AddSchedulePage extends GetView<AddScheduleController> {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("스케줄 생성"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputField(
                  controller: controller.titleController, hintText: "제목"),
              const SizedBox(
                height: 36,
              ),
              TextInputField(
                controller: controller.notesController,
                hintText: "메모",
                inputType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 36,
              ),
              TextInputField(
                controller: null,
                hintText: Utils.formatDate(controller.startDate.value),
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.selectDate(isDate: true, isStart: null);
                  },
                  icon: const Icon(LineIcons.calendar),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      controller: null,
                      hintText: Utils.formatTime(controller.startDate.value),
                      readOnly: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.selectDate(isDate: false, isStart: true);
                        },
                        icon: const Icon(LineIcons.clock),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 36,
                    child: Center(child: Text("~")),
                  ),
                  Expanded(
                    child: TextInputField(
                      controller: null,
                      hintText: Utils.formatTime(controller.endDate.value),
                      readOnly: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.selectDate(isDate: false, isStart: false);
                        },
                        icon: const Icon(LineIcons.clock),
                      ),
                    ),
                  )
                ],
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
                    controller.addSchedule();
                    Get.back();
                  },
                  child: const Text("스케줄 생성"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
