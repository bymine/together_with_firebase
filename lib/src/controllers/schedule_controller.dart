import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/models/schedule.dart';
import 'package:together_with_firebase/src/models/users.dart';
import 'package:together_with_firebase/src/utils.dart/date_utils.dart';

class ScheduleController extends GetxController {
  static ScheduleController get to => Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _scheduleMap = LinkedHashMap<DateTime, List<Schedule>>(
          equals: isSameDay, hashCode: Utils.getHashCode)
      .obs;

  final Rx<DateTime> _focusedDay = DateTime.now().obs;
  late Rx<DateTime?> _selectedDay;
  DateTime? get selectedDay => _selectedDay.value;
  DateTime get focusedDay => _focusedDay.value;

  RxList<Project> liveProjects = RxList([]);
  late Rx<Project> currentproject = liveProjects.first.obs;
  final RxList<Schedule> _loadschedules = RxList([]);
  RxList<Schedule> selectedSchedule = RxList([]);
  RxBool loadCompleteState = false.obs;
  @override
  void onInit() {
    _selectedDay = _focusedDay;
    liveProjects.value = HomeController.to.projects;
    getAllSchedule();
    super.onInit();
  }

  void changeProject(Project value) {
    currentproject(value);
    loadCompleteState(false);
    getAllSchedule();
  }

  void getAllSchedule() async {
    if (liveProjects.isNotEmpty) {
      var data = await firestore
          .collection("Projects")
          .doc(currentproject.value.idx)
          .collection("Schedules")
          .get();

      _loadschedules(data.docs.map((e) => Schedule.fromJson(e)).toList());

      formatting();
      print("load....");
    }
  }

  void formatting() async {
    for (var schedule in _loadschedules) {
      var user = await schedule.writerReference.get();
      schedule.writer = UserInfoData.fromJson(user.data()!);
    }
    _loadschedules.refresh();
    _scheduleMap.value.clear();
    for (var schedule in _loadschedules) {
      List<Schedule> list =
          _scheduleMap.value[schedule.startTime.toDate()] ?? [];
      list.add(schedule);
      _scheduleMap.value[schedule.startTime.toDate()] = list;
    }
    _scheduleMap.refresh();
    getEventsForDay(_focusedDay.value);
    loadCompleteState(true);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay.value, selectedDay)) {
      _selectedDay.value = selectedDay;
      _focusedDay.value = focusedDay;
    }
    getEventsForDay(_focusedDay.value);
  }

  List<Schedule> getEventsForDay(DateTime day) {
    selectedSchedule.value = _scheduleMap.value[day] ?? [];
    selectedSchedule.refresh();
    return selectedSchedule;
  }

  List<Schedule> initalEventLoader(DateTime day) {
    return _scheduleMap.value[day] ?? [];
  }
}
