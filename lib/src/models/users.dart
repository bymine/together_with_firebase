import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoData {
  String uid;
  String name;
  String email;
  String password;
  String nickname;
  String profile;

  UserInfoData(
      {required this.uid,
      required this.name,
      required this.email,
      required this.password,
      required this.nickname,
      required this.profile});

  Map<String, dynamic> toMap() {
    return {
      'user_uid': uid,
      'user_name': name,
      'user_email': email,
      'user_password': password,
      'user_nickname': nickname,
      'user_profile': profile
    };
  }

  factory UserInfoData.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();
    return UserInfoData(
        uid: json['user_uid'],
        name: json['user_name'],
        email: json['user_email'],
        password: json['user_password'],
        nickname: json['user_nickname'],
        profile: json['user_profile']);
  }

  factory UserInfoData.fromJson(Map<String, dynamic> json) {
    return UserInfoData(
        uid: json['user_uid'],
        name: json['user_name'],
        email: json['user_email'],
        password: json['user_password'],
        nickname: json['user_nickname'],
        profile: json['user_profile']);
  }
}
