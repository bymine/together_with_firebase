import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/models/users.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();

  RxList<Project> projects = RxList([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Message> messages = RxList([]);

  RxInt currentIndex = 0.obs;

  TextEditingController messageController = TextEditingController();

  RxBool isLoadComplete = false.obs;
  @override
  void onInit() {
    projects = HomeController.to.projects;

    super.onInit();
  }

  loadMessages(int index) async {
    if (projects.isNotEmpty) {
      currentIndex(index);
    }

    firestore
        .collection("Projects")
        .doc(projects[currentIndex.value].idx!)
        .collection("Chats")
        .orderBy("message_date")
        .snapshots()
        .listen((event) {
      messages(event.docs.map((e) => Message.fromJson(e)).toList());
      formatting();
    });
  }

  void formatting() {
    for (var message in messages) {
      message.writer = projects[currentIndex.value].userDatas[
          projects[currentIndex.value]
              .userReferences
              .indexOf(message.writerReference)];
    }
    isLoadComplete(true);
  }

  sendMessage() {
    print("send chat");
    var reference = firestore.collection("Users").doc(AuthController.to.uid);

    if (messageController.text.isNotEmpty) {
      firestore
          .collection("Projects")
          .doc(projects[currentIndex.value].idx!)
          .collection("Chats")
          .add(Message(
                  title: messageController.text,
                  date: DateTime.now(),
                  writerReference: reference)
              .toMap());

      messageController.clear();
    }
  }
}

class Message {
  String? idx;
  String title;
  DateTime date;
  DocumentReference<Map<String, dynamic>> writerReference;
  UserInfoData? writer;

  Message(
      {required this.title,
      required this.date,
      this.writer,
      required this.writerReference,
      this.idx});

  Map<String, dynamic> toMap() {
    return {
      'message_title': title,
      'message_date': date,
      'message_writer_reference': writerReference
    };
  }

  factory Message.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> documnet) {
    var json = documnet.data();
    return Message(
        idx: documnet.id,
        title: json['message_title'],
        date: json['message_date'].toDate(),
        writerReference: json['message_writer_reference']);
  }
}
