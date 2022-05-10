import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:search_page/search_page.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';
import 'package:together_with_firebase/src/pages/components/detail_project_page.dart';
import 'package:together_with_firebase/src/pages/components/home_card_detail_sheet.dart';
import 'package:together_with_firebase/src/pages/components/home_swiper_view.dart';

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
          IconButton(
              onPressed: () {
                controller.getSearchProject();
                showSearchPage(context);
              },
              icon: const Icon(LineIcons.search)),
        ],
      ),
      body: Obx(
        () {
          if (controller.projects.isEmpty) {
            return const Text("진행 중인 프로젝트가 없습니다");
          } else {
            return Stack(
              children: const [
                HomeSwiperCardsView(),
                HomeCardDetailSheet(),
              ],
            );
          }
        },
      ),
    );
  }

  void showSearchPage(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchPage<Project>(
        barTheme: Theme.of(context),
        showItemsOnEmpty: false,
        builder: (project) => Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            children: [
              const Divider(),
              ListTile(
                onTap: () {
                  Get.to(() => DetailProjectPage(project: project));
                },
                title: Text(
                  project.title,
                  style: const TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.notes,
                      maxLines: 1,
                    ),
                    Text("${project.userReferences.length} 명")
                  ],
                ),
                trailing: Container(
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: NetworkImage(project.imageUrl))),
                ),
              ),
            ],
          ),
        ),
        filter: (project) {
          List<String> list = [];
          for (var element in controller.searchProjects) {
            if (element.title.contains(project.title)) {
              list.add(element.title);
            }
          }
          return list;
        },
        failure: const Center(
          child: Text('No project found'),
        ),
        items: controller.searchProjects,
      ),
    );
  }
}
