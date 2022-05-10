import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthController.to.signOut();
              },
              icon: const Icon(LineIcons.alternateSignOut))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(
                radius: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text("frfr0723@gmail.com")
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("내 활동"),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Text("2"),
                    Text("프로젝트"),
                  ],
                ),
                Column(
                  children: const [
                    Text("10"),
                    Text("스케줄"),
                  ],
                ),
                Column(
                  children: const [
                    Text("2"),
                    Text("파일"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
