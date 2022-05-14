import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum FileExt { photos, document, media }

class FileData {
  String? id;
  String title;
  FileExt fileType;
  double mbSize;
  DateTime date;
  DocumentReference<Map<String, dynamic>> writerReference;
  String downloadUrl;

  FileData(
      {required this.title,
      required this.fileType,
      required this.date,
      required this.writerReference,
      required this.mbSize,
      required this.downloadUrl,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      "file_title": title,
      "file_type": formatFileTypeToString(fileType),
      "file_size": mbSize,
      "upload_date": date,
      "writer_reference": writerReference,
      "file_downloadUrl": downloadUrl
    };
  }

  factory FileData.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();

    FileExt fileExt;

    if (json['file_type'] == "document") {
      fileExt = FileExt.document;
    } else if (json['file_type'] == "photo") {
      fileExt = FileExt.photos;
    } else {
      fileExt = FileExt.media;
    }

    return FileData(
        id: document.id,
        title: json['file_title'],
        fileType: fileExt,
        mbSize: json['file_size'],
        date: json['upload_date'].toDate(),
        writerReference: json['writer_reference'],
        downloadUrl: json['file_downloadUrl']);
  }

  String formatFileTypeToString(FileExt fileExt) {
    switch (fileExt) {
      case FileExt.document:
        return "document";
      case FileExt.photos:
        return "photo";

      case FileExt.media:
        return "media";
    }
  }
}

class Folder {
  Map<String, double> fileMap;
  Color color;
  IconData icon;
  double folderSize;

  Folder(
      {required this.fileMap,
      required this.color,
      required this.icon,
      required this.folderSize});
}
