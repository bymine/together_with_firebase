import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';
import 'package:together_with_firebase/src/controllers/schedule_controller.dart';
import 'package:together_with_firebase/src/models/schedule.dart';

class AddScheduleController extends GetxController {
  static AddScheduleController get to => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  Rx<DateTime> startDate =
      DateTime(Get.arguments.year, Get.arguments.month, Get.arguments.day).obs;
  Rx<DateTime> endDate =
      DateTime(Get.arguments.year, Get.arguments.month, Get.arguments.day).obs;
  RxBool isAddComplete = false.obs;
  @override
  void onInit() {
    print(Get.parameters);
    super.onInit();
  }

  @override
  void onClose() {
    if (isAddComplete.value) {
      ScheduleController.to.getAllSchedule();
    }

    super.onClose();
  }

  void addSchedule() {
    var reference = firestore.collection("Users").doc(AuthController.to.uid);

    var addSchedule = Schedule(
        title: titleController.text,
        notes: notesController.text,
        startTime: Timestamp.fromDate(startDate.value),
        endTime: Timestamp.fromDate(endDate.value),
        writerReference: reference);

    firestore
        .collection("Projects")
        .doc(Get.parameters['project_idx'])
        .collection("Schedules")
        .add(addSchedule.toMap());

    isAddComplete(true);
  }

  Future<void> selectDate(
      {required bool isDate, required bool? isStart}) async {
    if (isDate) {
      DateTime? _pickerDate = await showDatePicker(
          context: Get.context!,
          initialDate: startDate.value,
          firstDate: DateTime(2020),
          lastDate: DateTime(2024));

      if (_pickerDate != null) {
        startDate.value =
            DateTime(_pickerDate.year, _pickerDate.month, _pickerDate.day);
        endDate.value =
            DateTime(_pickerDate.year, _pickerDate.month, _pickerDate.day);
      }
    } else {
      TimeOfDay? _pcikerTime = await showTimePicker(
          context: Get.context!,
          initialTime: isStart!
              ? TimeOfDay.fromDateTime(startDate.value)
              : TimeOfDay.fromDateTime(endDate.value));
      if (_pcikerTime != null) {
        if (isStart) {
          startDate.value = DateTime(
              startDate.value.year,
              startDate.value.month,
              startDate.value.day,
              _pcikerTime.hour,
              _pcikerTime.minute);
        } else {
          endDate.value = DateTime(endDate.value.year, endDate.value.month,
              endDate.value.day, _pcikerTime.hour, _pcikerTime.minute);
        }
      }
    }
  }
}
