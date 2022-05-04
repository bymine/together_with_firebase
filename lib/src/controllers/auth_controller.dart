import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController rePwController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  String get uid => _user.value!.uid;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initalScreen);
  }

  _initalScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/app');
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
      firestore.collection("Users").add({
        "uid": userCredential.user!.uid,
        "user_name": nameController.text,
        "user_nickname": nicknameController.text
      });
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

  void logOut() async {
    await auth.signOut();
  }
}
