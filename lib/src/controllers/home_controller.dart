import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/models/users.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxInt currentIndex = 0.obs;
  RxList<Project> projects = RxList([]);
  Project? get currentProject =>
      projects.isEmpty ? null : projects[currentIndex.value];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Project> searchProjects = RxList([]);
  TextEditingController pwController = TextEditingController();

  @override
  void onInit() {
    getAllProjects();
    super.onInit();
  }

  void getAllProjects() async {
    var reference = firestore.collection("Users").doc(AuthController.to.uid);
    var data = await firestore
        .collection("Projects")
        .where("user_references", arrayContainsAny: [reference]).get();

    var list = data.docs.map((e) => Project.fromJson(e)).toList();
    projects.value = list;
    formatingUsersData();
  }

  void formatingUsersData() async {
    for (var project in projects) {
      for (var usereference in project.userReferences) {
        var user = await usereference.get();
        project.userDatas.add(UserInfoData.fromJson(user.data()!));
      }
    }
    projects.refresh();
  }

  void changeIndex(int index) {
    currentIndex(index);
  }

  void getSearchProject() async {
    var reference = firestore.collection("Users").doc(AuthController.to.uid);
    var data = await firestore
        .collection("Projects")
        .where("user_references", whereNotIn: [reference]).get();
    var list = data.docs.map((e) => Project.fromJson(e)).toList();
    searchProjects.value = list;
  }

  void joinProject(Project project) async {
    var reference = firestore.collection("Users").doc(AuthController.to.uid);

    project.userReferences.add(reference);
    if (project.pw == pwController.text) {
      firestore.collection("Projects").doc(project.idx).update(project.toMap());
    }
  }
}
