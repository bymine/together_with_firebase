import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/app_controller.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(FileController());
  }
}
