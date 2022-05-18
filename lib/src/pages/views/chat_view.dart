import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/controllers/chat_controller.dart';
import 'package:together_with_firebase/src/pages/views/detail_chat_page.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Room"),
      ),
      body: Obx(
        () {
          if (controller.isLoadRoom.value) {
            return ListView.builder(
                itemCount: controller.chatRooms.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => const DetailChatPage(),
                          arguments: controller.chatRooms[index].project);
                      ChatController.to.loadMessages(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(controller
                                    .chatRooms[index].project.imageUrl),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: controller
                                        .chatRooms[index].project.title,
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text:
                                              " ${controller.chatRooms[index].project.userDatas.length}명",
                                          style: const TextStyle(
                                              color: Colors.black54))
                                    ],
                                  ),
                                ),
                                Obx(() => Text(
                                    controller.chatRooms[index].thumbNail.value
                                            .lastMessage ??
                                        "",
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.black54)))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Obx(() => Text(
                                  controller
                                      .chatRooms[index].thumbNail.value.date
                                      .toString(),
                                  style: TextStyle(color: Colors.black54)))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
