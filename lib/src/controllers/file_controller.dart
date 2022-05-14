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

class FileController extends GetxController {
  static FileController get to => Get.find();
  RxList<FileData> latestFiles = RxList([]);
  RxList<FileData> allFiles = RxList([]);
  RxList<Project> liveProjects = RxList([]);
  late Rx<Project> currentproject = liveProjects.first.obs;
  RxList<Folder> folders = RxList([]);
  Rx<File> uploadFile = File("").obs;

  RxBool isLoadComplete = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String get fileName => basename(uploadFile.value.path);
  TextEditingController fileTitleController = TextEditingController();

  @override
  void onInit() {
    liveProjects.value = HomeController.to.projects;

    getFilesFromDatabase();
    super.onInit();
  }

  void changeProject(Project value) {
    currentproject(value);
    getFilesFromDatabase();
  }

  void getFilesFromDatabase() async {
    var fileData = await firestore
        .collection("Projects")
        .doc(currentproject.value.idx!)
        .collection("Files")
        .get();
    allFiles.value = fileData.docs.map((e) => FileData.fromJson(e)).toList();
    sortLatestFromAll();
    classifyFolderType();
    isLoadComplete(true);
  }

  void sortLatestFromAll() {
    latestFiles.value = allFiles;
  }

  void classifyFolderType() {
    folders.value = [
      Folder(
          fileMap: {
            "이미지": allFiles
                .where((p0) => p0.fileType == FileExt.photos)
                .toList()
                .length
                .toDouble()
          },
          color: Colors.green,
          icon: LineIcons.imageFile,
          folderSize: calculateFolderSize(
              allFiles.where((p0) => p0.fileType == FileExt.photos).toList())),
      Folder(
          fileMap: {
            "미디어": allFiles
                .where((p0) => p0.fileType == FileExt.media)
                .toList()
                .length
                .toDouble()
          },
          color: Colors.orange,
          icon: LineIcons.videoFile,
          folderSize: calculateFolderSize(
              allFiles.where((p0) => p0.fileType == FileExt.media).toList())),
      Folder(
          fileMap: {
            "문서": allFiles
                .where((p0) => p0.fileType == FileExt.document)
                .toList()
                .length
                .toDouble()
          },
          color: Colors.purple,
          icon: LineIcons.fileInvoice,
          folderSize: calculateFolderSize(allFiles
              .where((p0) => p0.fileType == FileExt.document)
              .toList())),
    ];
  }

  double calculateFolderSize(List<FileData> list) {
    double count = 0;
    for (var element in list) {
      count += element.mbSize;
    }
    return count;
  }

  Map<String, double> get folderMap {
    Map<String, double> map = {};

    for (var folder in folders) {
      map.addAll(folder.fileMap);
    }

    return map;
  }

  List<Color> get folderColorList {
    List<Color> color = [];
    for (var folder in folders) {
      color.add(folder.color.withOpacity(0.6));
    }
    return color;
  }

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
    int sizeInBytes = uploadFile.value.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    var reference = firestore.collection("Users").doc(AuthController.to.uid);
    var file = FileData(
        title: fileTitleController.text,
        fileType: FileExt.photos,
        date: DateTime.now(),
        mbSize: sizeInMb,
        downloadUrl: fileDownloadUrls,
        writerReference: reference);

    firestore
        .collection("Projects")
        .doc(currentproject.value.idx!)
        .collection("Files")
        .add(file.toMap());
  }
}
