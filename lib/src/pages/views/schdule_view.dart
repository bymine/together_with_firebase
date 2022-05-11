import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:together_with_firebase/src/controllers/schedule_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/models/schedule.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => DropdownButton(
            isExpanded: true,
            value: controller.currentproject.value,
            underline: Container(),
            items: controller.liveProjects
                .map(
                  (element) => DropdownMenuItem(
                    value: element,
                    child: Text(element.title),
                  ),
                )
                .toList(),
            onChanged: (Project? value) {
              controller.changeProject(value!);
            },
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/addSchedule",
                    arguments: controller.selectedDay,
                    parameters: {
                      'project_idx': controller.currentproject.value.idx!
                    });
              },
              icon: const Icon(LineIcons.calendarPlus)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Obx(() {
          if (controller.loadCompleteState.value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar<Schedule>(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateLine(selectDate: controller.selectedDay!),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.selectedSchedule.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: controller
                                        .selectedSchedule[index].writer !=
                                    null
                                ? CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        controller.selectedSchedule[index]
                                            .writer!.profile),
                                  )
                                : CircleAvatar(),
                            title:
                                Text(controller.selectedSchedule[index].title),
                            subtitle: Text(controller
                                .selectedSchedule[index].startTime
                                .toDate()
                                .toString()),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}

class DateLine extends StatelessWidget {
  const DateLine({
    Key? key,
    required this.selectDate,
  }) : super(key: key);

  final DateTime selectDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: RichText(
        text: TextSpan(
          text: DateFormat('d, ').format(selectDate),
          style: const TextStyle(color: Colors.black, fontSize: 20),
          children: [
            TextSpan(
                text: DateFormat('EEE').format(selectDate),
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 16))
          ],
        ),
      ),
    );
  }
}
