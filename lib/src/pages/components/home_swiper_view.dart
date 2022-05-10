import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/controllers/home_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';

class HomeSwiperCardsView extends GetView<HomeController> {
  const HomeSwiperCardsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Obx(
            () => Swiper(
              onIndexChanged: (index) {
                controller.changeIndex(index);
              },
              loop: false,
              index: controller.currentIndex.value,
              itemCount: controller.projects.length,
              viewportFraction: 0.8,
              scale: 0.9,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.zero,
                  builder: DotSwiperPaginationBuilder(color: Colors.grey)),
              layout: SwiperLayout.DEFAULT,
              itemBuilder: (context, index) {
                return ProjectCard(
                  project: controller.projects[index],
                );
              },
            ),
          ),
        ),
        Flexible(flex: 4, child: Container()),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: project.imageUrl == ""
                  ? Image.asset("assets/images/project_background_1.png").image
                  : CachedNetworkImageProvider(project.imageUrl),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.dstATop),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 4,
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  project.title,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: () async {},
                icon: const Icon(LineIcons.cog),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
