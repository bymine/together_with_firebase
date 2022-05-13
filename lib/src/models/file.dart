import 'package:cloud_firestore/cloud_firestore.dart';

enum FileExt { photos, document, media }

class FileData {
  String? id;
  String title;
  FileExt fileType;
  DateTime date;
  DocumentReference<Map<String, dynamic>> writerReference;
  String downloadUrl;

  FileData(
      {required this.title,
      required this.fileType,
      required this.date,
      required this.writerReference,
      required this.downloadUrl,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      "file_title": title,
      "file_type": fileType.toString(),
      "upload_date": date,
      "writer_reference": writerReference,
      "file_downloadUrl": downloadUrl
    };
  }

  factory FileData.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();

    return FileData(
        id: document.id,
        title: json['file_title'],
        fileType: json['file_type'],
        date: json['upload_date'],
        writerReference: json['writer_reference'],
        downloadUrl: json['file_downloadUrl']);
  }
}
