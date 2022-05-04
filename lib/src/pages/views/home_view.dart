import 'package:flutter/material.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("홈"),
        actions: [
          IconButton(
              onPressed: () {
                AuthController.to.logOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
