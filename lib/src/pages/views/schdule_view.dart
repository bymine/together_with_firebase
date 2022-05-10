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
        title: Text(controller.liveProjects.first.title),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/addSchedule",
                    arguments: controller.selectedDay,
                    parameters: {
                      'project_idx': controller.liveProjects.first.idx!
                    });
              },
              icon: const Icon(LineIcons.calendarPlus)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => TableCalendar<Schedule>(
                focusedDay: controller.focusedDay,
                firstDay: DateTime(2021),
                lastDay: DateTime(2023),
                headerVisible: false,
                selectedDayPredicate: (day) =>
                    isSameDay(controller.selectedDay, day),
                onDaySelected: controller.onDaySelected,
                startingDayOfWeek: StartingDayOfWeek.monday,
                eventLoader: controller.initalEventLoader,
              ),
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.selectedSchedule.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: controller.selectedSchedule[index].writer != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(controller
                                  .selectedSchedule[index].writer!.profile),
                            )
                          : CircleAvatar(),
                      title: Text(controller.selectedSchedule[index].title),
                      subtitle: Text(controller
                          .selectedSchedule[index].startTime
                          .toDate()
                          .toString()),
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
