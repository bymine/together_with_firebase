import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/models/schedule.dart';
import 'package:together_with_firebase/src/models/users.dart';

class ScheduleController extends GetxController {
  static ScheduleController get to => Get.find();

  final _scheduleMap = LinkedHashMap<DateTime, List<Schedule>>(
          equals: isSameDay, hashCode: getHashCode)
      .obs;
  final Rx<DateTime> _focusedDay = DateTime.now().obs;
  late Rx<DateTime?> _selectedDay;
  DateTime? get selectedDay => _selectedDay.value;
  DateTime get focusedDay => _focusedDay.value;
  LinkedHashMap<DateTime, List<Schedule>> get event => _scheduleMap.value;

  RxList<Project> liveProjects = RxList([]);
  final RxList<Schedule> _loadschedules = RxList([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Schedule> selectedSchedule = RxList([]);

  @override
  void onInit() {
    _selectedDay = _focusedDay;
    liveProjects.value = HomeController.to.projects;
    // paramenter 사용??
    getAllSchedule();
    super.onInit();
  }

  void getAllSchedule() async {
    if (liveProjects.isEmpty) {
      print("empty project");
    } else {
      print(liveProjects.first.idx);
      var data = await firestore
          .collection("Projects")
          .doc(liveProjects.first.idx)
          .collection("Schedules")
          .get();
      print(data.docs.first.data());

      _loadschedules(data.docs.map((e) => Schedule.fromJson(e)).toList());

      formatingUserData();
    }
  }

  void formatingUserData() async {
    for (var schedule in _loadschedules) {
      var user = await schedule.writerReference.get();
      schedule.writer = UserInfoData.fromJson(user.data()!);
    }
    _loadschedules.refresh();
    toMakeHashMap();
  }

  void toMakeHashMap() {
    _scheduleMap.value.clear();
    for (var schedule in _loadschedules) {
      List<Schedule> list =
          _scheduleMap.value[schedule.startTime.toDate()] ?? [];
      list.add(schedule);
      _scheduleMap.value[schedule.startTime.toDate()] = list;
    }
    print("hashMap");
    getEventsForDay(_focusedDay.value);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay.value, selectedDay)) {
      _selectedDay.value = selectedDay;
      _focusedDay.value = focusedDay;
    }
    getEventsForDay(_focusedDay.value);
  }

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<Schedule> getEventsForDay(DateTime day) {
    selectedSchedule.value = _scheduleMap.value[day] ?? [];
    selectedSchedule.refresh();
    print("getDAtas");
    return selectedSchedule;
  }

  List<Schedule> initalEventLoader(DateTime dateTime) {
    return _scheduleMap.value[dateTime] ?? [];
  }
}
