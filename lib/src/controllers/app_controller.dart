import 'package:get/get.dart';

enum AppNavigator { home, schedule, chat, file, setting }

class AppController extends GetxController {
  final Rx<int> _index = 0.obs;

  int get currentIndex => _index.value;

  changeIndex(int index) {
    _index(index);
  }
}
