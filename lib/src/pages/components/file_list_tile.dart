import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/models/file.dart';
import 'package:together_with_firebase/src/utils.dart/date_utils.dart';

class FileListTile extends StatelessWidget {
  final FileData fileData;
  const FileListTile({Key? key, required this.fileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: fileDecoration(fileData.fileType),
        child: fileIcon(fileData.fileType),
      ),
      title: Text(fileData.title),
      subtitle: Text(
        fileData.mbSize.toStringAsFixed(3) +
            "MB" +
            "  " +
            Utils.formatDate(fileData.date, "-"),
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
    );
  }

  Icon fileIcon(FileExt fileExt) {
    switch (fileExt) {
      case FileExt.photos:
        return const Icon(
          LineIcons.image,
          size: 18,
          color: Colors.green,
        );
      case FileExt.document:
        return const Icon(
          LineIcons.fileInvoice,
          size: 18,
          color: Colors.purple,
        );
      case FileExt.media:
        return LineIcon(
          LineIcons.video,
          size: 18,
          color: Colors.orange,
        );
    }
  }

  BoxDecoration fileDecoration(FileExt fileExt) {
    switch (fileExt) {
      case FileExt.document:
        return BoxDecoration(
            color: Colors.purple.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8)));
      case FileExt.photos:
        return BoxDecoration(
            color: Colors.green.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8)));

      case FileExt.media:
        return BoxDecoration(
            color: Colors.orange.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8)));
    }
  }
}
