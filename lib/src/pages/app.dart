import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/controllers/app_controller.dart';
import 'package:together_with_firebase/src/pages/views/chat_view.dart';
import 'package:together_with_firebase/src/pages/views/file_view.dart';
import 'package:together_with_firebase/src/pages/views/home_view.dart';
import 'package:together_with_firebase/src/pages/views/schdule_view.dart';

import 'package:together_with_firebase/src/pages/views/setting_view.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _bodyView(),
          bottomNavigationBar: _bottomBar(),
        ));
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: (index) {
          controller.changeIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(LineIcons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(LineIcons.clock), label: "일정"),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.rocketChat), label: "채팅"),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.fileInvoice), label: "파일"),
          BottomNavigationBarItem(icon: Icon(LineIcons.cog), label: "설정"),
        ]);
  }

  Widget _bodyView() {
    switch (AppNavigator.values[controller.currentIndex]) {
      case AppNavigator.home:
        return const HomeView();
      case AppNavigator.schedule:
        return const ScheduleView();
      case AppNavigator.chat:
        return const ChatView();
      case AppNavigator.file:
        return const FileView();
      default:
        return const SettingView();
    }
  }
}
