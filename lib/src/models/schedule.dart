import 'package:flutter/material.dart';

class Schedule {
  String? id;
  String title;
  String? notes;
  DateTime standDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Schedule(
      {required this.title,
      required this.standDate,
      this.id,
      this.notes,
      this.startTime,
      this.endTime});
}

// 시작 날짜 , 종료 날짜 , 시작 시간, 종료 시간 어떻게 구현할것인가
// 1. (시작 날짜 + 시작 시간),(종료 날짜 + 종료 시간)
// 2. (시작 날짜), (종료 날짜), (시작 시간), (종료 시간)
// 3. (기준날짜), (시작 시간),(종료 시간) --> 사용   # 여러 시간에 걸쳐 일정 만들것같지않아서 ex) 1박2일 2박 3일 등등
