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
                        itemBuilder: (context, index) => MessageWidget(
                              message: controller.messages[index],
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

class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 3,
      contentPadding: EdgeInsets.all(10),
      leading: message.writer!.uid != AuthController.to.uid
          ? Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              message.writer!.profile))),
                ),
                Text(message.writer!.name)
              ],
            )
          : null,
      title: message.writer!.uid != AuthController.to.uid
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: Get.height * 0.4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    message.title,
                  ),
                ),
                Text(DateFormat('hh:mm').format(message.date))
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xffD7DDF3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Text(message.title),
                ),
                Text(DateFormat('hh:mm').format(message.date))
              ],
            ),
    );
  }
}
