import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:together_with_firebase/src/models/users.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  late Rx<User?> _user;
  late Rx<UserInfoData?> userInfo;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController rePwController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  RxList<File> image = RxList([]);
  final _imagePicker = ImagePicker();

  String get uid => _user.value!.uid;
  String get profile => userInfo.value!.profile;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initalScreen);
  }

  _initalScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/app');
      try {
        var data = await firestore
            .collection("Users")
            .where("user_uid", isEqualTo: uid)
            .get();
        userInfo =
            Rx<UserInfoData?>(UserInfoData.fromDocument(data.docs.first));
      } catch (e) {
        null;
      }
    }
  }

  Future<void> getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.assign(File(pickedFile.path));
    }
  }

  // void resetTextEditControllers() {
  //   nameController.clear();
  //   emailController.clear();
  //   pwController.clear();
  //   rePwController.clear();
  //   nicknameController.clear();
  //   print("clear");
  // }

  void signUp() async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: pwController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      userCredential == null;
    } catch (e) {
      print(e);
    }
    if (userCredential != null) {
      var fileDownloadUrls = "";
      if (image.isNotEmpty) {
        final ref =
            firebaseStorage.ref("Profile").child(userCredential.user!.uid);
        await ref.putFile(image.first);
        fileDownloadUrls = await ref.getDownloadURL();
      }

      var addUser = UserInfoData(
          uid: userCredential.user!.uid,
          name: nameController.text,
          email: emailController.text,
          password: pwController.text,
          nickname: nicknameController.text,
          profile: fileDownloadUrls);

      firestore.collection("Users").doc(uid).set(addUser.toMap());
    }
  }

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: pwController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
