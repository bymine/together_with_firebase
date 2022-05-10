import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:together_with_firebase/src/models/users.dart';

class Schedule {
  String? id;
  String title;
  String notes;
  Timestamp startTime;
  Timestamp endTime;
  DocumentReference<Map<String, dynamic>> writerReference;
  UserInfoData? writer;

  Schedule(
      {required this.title,
      this.id,
      required this.notes,
      required this.startTime,
      required this.endTime,
      required this.writerReference});

  Map<String, dynamic> toMap() {
    return {
      "schedule_title": title,
      "schedule_notes": notes,
      "schedule_start_time": startTime,
      "schedule_end_time": endTime,
      "writer_reference": writerReference
    };
  }

  factory Schedule.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();
    return Schedule(
        title: json['schedule_title'],
        notes: json['schedule_notes'],
        startTime: json['schedule_start_time'],
        endTime: json['schedule_end_time'],
        writerReference: json['writer_reference']);
  }
}

// 시작 날짜 , 종료 날짜 , 시작 시간, 종료 시간 어떻게 구현할것인가
// 1. (시작 날짜 + 시작 시간),(종료 날짜 + 종료 시간)
// 2. (시작 날짜), (종료 날짜), (시작 시간), (종료 시간)
// 3. (기준날짜), (시작 시간),(종료 시간) --> 사용   # 여러 시간에 걸쳐 일정 만들것같지않아서 ex) 1박2일 2박 3일 등등
