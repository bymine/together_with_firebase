enum FileType { photos, document, media }

class File {
  String? idx;
  String title;
  FileType fileType;
  DateTime date;

  File(
      {required this.title,
      required this.fileType,
      required this.date,
      this.idx});
}
