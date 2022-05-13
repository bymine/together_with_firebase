import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path/path.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/file.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/pages/views/file_view.dart';

class FileController extends GetxController {
  static FileController get to => Get.find();
  RxList<FileData> latestFiles = RxList([]);
  Map<String, double> fileTypeMap = {"이미지": 7, "문서": 3, "비디오": 5};
  RxList<Project> liveProjects = RxList([]);
  late Rx<Project> currentproject = liveProjects.first.obs;

  Rx<File> uploadFile = File("").obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String get fileName => basename(uploadFile.value.path);
  TextEditingController fileTitleController = TextEditingController();
  @override
  void onInit() {
    liveProjects.value = HomeController.to.projects;

    getLatestFiles();
    super.onInit();
  }

  void changeProject(Project value) {
    currentproject(value);
  }

  void getLatestFiles() {}

  List<Folder> folders = [
    Folder(
        title: "Photos",
        items: 5,
        color: Colors.green,
        icon: LineIcons.imageFile),
    Folder(
        title: "Media",
        items: 8,
        color: Colors.yellow,
        icon: LineIcons.videoFile),
    Folder(
        title: "Documents",
        items: 3,
        color: Colors.red,
        icon: LineIcons.fileInvoice),
  ];

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      uploadFile.value = File(result.files.single.path!);
    }
  }

  void uploadFileToDatabase() async {
    final ref = firebaseStorage
        .ref("Files")
        .child(currentproject.value.idx!)
        .child(fileName);
    await ref.putFile(uploadFile.value);
    var fileDownloadUrls = await ref.getDownloadURL();

    var reference = firestore.collection("Users").doc(AuthController.to.uid);
    var file = FileData(
        title: fileTitleController.text,
        fileType: FileExt.photos,
        date: DateTime.now(),
        downloadUrl: fileDownloadUrls,
        writerReference: reference);

    firestore
        .collection("Projects")
        .doc(currentproject.value.idx!)
        .collection("Files")
        .add(file.toMap());
  }
}
