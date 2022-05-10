import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:together_with_firebase/src/models/users.dart';

class Project {
  String? idx;
  String title;
  String notes;
  String pw;
  String imageUrl;
  List<DocumentReference<Map<String, dynamic>>> userReferences;
  List<UserInfoData> userDatas = [];

  Project({
    required this.title,
    required this.notes,
    required this.imageUrl,
    required this.pw,
    required this.userReferences,
    this.idx,
  });

  Map<String, dynamic> toMap() {
    return {
      'project_title': title,
      'project_notes': notes,
      'project_pw': pw,
      'project_image': imageUrl,
      'user_references': userReferences,
    };
  }

  factory Project.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();
    return Project(
      idx: document.id,
      title: json['project_title'],
      notes: json['project_notes'],
      imageUrl: json['project_image'],
      userReferences: List<DocumentReference<Map<String, dynamic>>>.from(
          json['user_references']),
      pw: json['project_pw'],
    );
  }
}
