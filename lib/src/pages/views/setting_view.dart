import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text("frfr0723@gmail.com")
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text("내 활동"),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("2"),
                    Text("프로젝트"),
                  ],
                ),
                Column(
                  children: [
                    Text("10"),
                    Text("스케줄"),
                  ],
                ),
                Column(
                  children: [
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
