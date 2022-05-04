import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
