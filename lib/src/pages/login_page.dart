import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/components/text_input_field.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    List images = ["g.png", "t.png", "f.png"];
    //controller.resetTextEditControllers();
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.4,
                    child: SvgPicture.asset(
                      "assets/svgs/logo.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: controller.emailController,
                  hintText: "이메일",
                  inputType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: controller.pwController,
                  hintText: "비밀번호",
                  inputType: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffEBC565),
                      minimumSize: Size(Get.width, 50)),
                  onPressed: () {
                    controller.signIn();
                  },
                  child: const Text("로그인"),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.toNamed('/signUp');
                      },
                      child: const Text(
                        "회원 가입",
                        style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(
                    height: 30,
                    width: 20,
                    child: VerticalDivider(
                      width: 3,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "이메일 찾기",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 20,
                    child: VerticalDivider(
                      width: 3,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "비밀번호 찾기",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
              Wrap(
                children: List<Widget>.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[500],
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage("assets/images/" + images[index]),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
