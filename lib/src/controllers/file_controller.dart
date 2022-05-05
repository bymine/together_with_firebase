import 'package:get/get.dart';
import 'package:together_with_firebase/src/models/file.dart';

class FileController extends GetxController {
  static FileController get to => Get.find();
  RxList<File> latestFiles = RxList([]);
  Map<String, double> fileTypeMap = {"이미지": 7, "문서": 3, "비디오": 5};

  @override
  void onInit() {
    getLatestFiles();
    super.onInit();
  }

  void getLatestFiles() {
    latestFiles.value = [
      File(
          title: "Prodcast with Brenda Eavs",
          fileType: FileType.photos,
          date: DateTime.now()),
      File(
          title: "Prodcast with Brenda Eavs",
          fileType: FileType.document,
          date: DateTime.now()),
      File(
          title: "Prodcast with Brenda Eavs",
          fileType: FileType.photos,
          date: DateTime.now()),
    ];
  }
}
