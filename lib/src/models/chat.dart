import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:together_with_firebase/src/models/users.dart';

class Chat {
  String? idx;
  String title;
  List<DocumentReference<Map<String, dynamic>>> userReferences;
  List<UserInfoData> userDatas = [];

  Chat({
    required this.title,
    required this.userReferences,
    this.idx,
  });

  Map<String, dynamic> toMap() {
    return {
      'chat_title': title,
      'user_references': userReferences,
    };
  }

  factory Chat.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();

    return Chat(
      idx: document.id,
      title: json['chat_title'],
      userReferences: List<DocumentReference<Map<String, dynamic>>>.from(
          json['user_references']),
    );
  }
}
