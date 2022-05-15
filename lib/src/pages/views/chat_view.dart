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
      body: ListView.builder(
          itemCount: controller.projects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => const DetailChatPage(),
                    arguments: controller.projects[index]);
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
                          image: CachedNetworkImageProvider(
                              controller.projects[index].imageUrl),
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
                              text: controller.projects[index].title,
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                    text:
                                        " ${controller.projects[index].userDatas.length}명",
                                    style:
                                        const TextStyle(color: Colors.black54))
                              ],
                            ),
                          ),
                          const Text("helloasdasdsadasdasdasdasdasdas",
                              style: TextStyle(color: Colors.black54))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: const [
                        Text("12:24", style: TextStyle(color: Colors.black54))
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
