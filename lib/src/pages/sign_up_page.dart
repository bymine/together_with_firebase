import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/components/text_input_field.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';

class SignUpPage extends GetView<AuthController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //controller.resetTextEditControllers();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원 가입"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 60,
                      backgroundImage: controller.image.isEmpty
                          ? Image.asset(
                              "assets/images/sample_profile.png",
                              scale: 0.8,
                            ).image
                          : Image.file(
                              controller.image.first,
                            ).image,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Positioned(
                      bottom: -4,
                      right: -4,
                      child: GestureDetector(
                        onTap: () {
                          controller.getImage();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 2,
                                    spreadRadius: 2)
                              ]),
                          child: const Icon(LineIcons.pen),
                        ),
                      ))
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: controller.nameController,
                  hintText: "이름",
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "이름을 입력하세요";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: controller.emailController,
                  hintText: "이메일",
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "이메일을 입력하세요";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              ObxValue(
                  (Rx<bool> visivity) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          controller: controller.pwController,
                          hintText: "비밀번호",
                          inputType: TextInputType.visiblePassword,
                          obscureText: visivity.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              visivity.value = !visivity.value;
                            },
                            icon: const Icon(LineIcons.eye),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "비밀번호를 입력하세요";
                            }
                            return null;
                          },
                        ),
                      ),
                  true.obs),
              const SizedBox(
                height: 36,
              ),
              ObxValue(
                  (Rx<bool> visivity) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          controller: controller.rePwController,
                          hintText: "비밀번호 확인",
                          inputType: TextInputType.visiblePassword,
                          obscureText: visivity.value,
                          suffixIcon: IconButton(
                              onPressed: () {
                                visivity.value = !visivity.value;
                              },
                              icon: const Icon(LineIcons.eye)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "비밀번호 확인을 입력하세요";
                            } else if (value != controller.pwController.text) {
                              return "비밀번호가 일치하지 않습니다";
                            }
                            return null;
                          },
                        ),
                      ),
                  true.obs),
              const SizedBox(
                height: 36,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: controller.nicknameController,
                  hintText: "닉네임",
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "닉네임을 입력하세요";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffEBC565),
                      minimumSize: Size(Get.width, 50)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signUp();
                    } else {
                      print("error");
                    }
                  },
                  child: const Text("회원가입"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
