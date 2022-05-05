import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:together_with_firebase/src/controllers/schedule_controller.dart';
import 'package:together_with_firebase/src/models/schedule.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("5월 2022년"),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(LineIcons.calendarPlus)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar<Schedule>(
              focusedDay: DateTime.now(),
              firstDay: DateTime(2021),
              lastDay: DateTime(2023),
              headerVisible: false,
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.schedules.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(controller.schedules[index].title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
