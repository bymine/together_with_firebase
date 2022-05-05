import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("진행 중인프로젝트"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('addProject');
              },
              icon: const Icon(LineIcons.plusSquare)),
          IconButton(onPressed: () {}, icon: const Icon(LineIcons.search)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Swiper(
              onIndexChanged: (index) {
                controller.changeIndex(index);
              },
              itemCount: controller.projects.length,
              loop: false,
              scale: 0.8,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        opacity: 0.8,
                        image: Image.asset(controller.projects[index].imageUrl)
                            .image,
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.projects[index].title),
                      Text(controller.projects[index].notes)
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(
            () => Expanded(
              flex: 4,
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [Text(controller.currentProject.title)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
