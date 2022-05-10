import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';

class HomeCardDetailSheet extends GetView<HomeController> {
  const HomeCardDetailSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Obx(
            () {
              if (controller.currentProject == null) {
                return const CircularProgressIndicator();
              } else {
                return Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width * 0.2,
                            height: 5,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        controller.currentProject!.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SingleChildScrollView(
                        child: Row(
                          children: List.generate(
                            controller.currentProject!.userDatas.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, right: 8, bottom: 8),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundImage: controller.currentProject!
                                            .userDatas[index].profile !=
                                        ""
                                    ? CachedNetworkImageProvider(controller
                                        .currentProject!
                                        .userDatas[index]
                                        .profile)
                                    : Image.asset(
                                            "assets/images/sample_profile.png")
                                        .image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "일정",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "채팅",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "파일",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "일정",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "채팅",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "파일",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "일정",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "채팅",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "파일",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
