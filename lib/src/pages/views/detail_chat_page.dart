import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:together_with_firebase/src/controllers/auth_controller.dart';
import 'package:together_with_firebase/src/controllers/chat_controller.dart';
import 'package:together_with_firebase/src/models/project.dart';

class DetailChatPage extends GetView<ChatController> {
  const DetailChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Project project = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xffD7DDF3),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(project.imageUrl))),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(project.title)
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          children: [
            Obx(
              () {
                if (controller.isLoadComplete.value) {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) => ListTile(
                              leading: controller.messages[index].writer!.uid !=
                                      AuthController.to.uid
                                  ? Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  controller.messages[index]
                                                      .writer!.profile))),
                                    )
                                  : null,
                              title: controller.messages[index].writer!.uid ==
                                      AuthController.to.uid
                                  ? Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: Wrap(
                                        children: [
                                          Text(
                                              controller.messages[index].title),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      color: const Color(0xffD7DDF3),
                                      child: Text(
                                          controller.messages[index].title),
                                    ),
                              trailing: Text(DateFormat('hh:mm')
                                  .format(controller.messages[index].date)),
                            )),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffD7DDF3),
                    hintText: "메세지를 입력하세요",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        borderSide: BorderSide.none),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.sendMessage();
                          FocusNode().dispose();
                        },
                        icon: LineIcon(LineIcons.paperPlane))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
