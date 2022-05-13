import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';

class AddProjectController extends GetxController {
  static AddProjectController get to => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  RxList<File> image = RxList([]);
  final _imagePicker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController rePwController = TextEditingController();
  RxBool isAddComplete = false.obs;
  RxBool isLock = true.obs;


  @override
  void onClose() {
    if (isAddComplete.value) {
      HomeController.to.getAllProjects();
    }

    super.onClose();
  }

  Future<void> getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.assign(File(pickedFile.path));
    }
  }

  void changeLock(bool value) {
    isLock(value);
  }

  void createProject() async {
    var fileDownloadUrls = "";
    if (image.isNotEmpty) {
      final ref = firebaseStorage.ref("Project").child(titleController.text);
      await ref.putFile(image.first);
      fileDownloadUrls = await ref.getDownloadURL();
    }

    var reference = firestore.collection("Users").doc(AuthController.to.uid);
    var project = Project(
        title: titleController.text,
        notes: notesController.text,
        imageUrl: fileDownloadUrls,
        pw: isLock.value ? pwController.text : "null",
        userReferences: [reference]);

    firestore.collection("Projects").doc().set(project.toMap());

    isAddComplete(true);
  }
}
