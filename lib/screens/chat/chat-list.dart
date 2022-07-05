import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/models/reccentChatModel.dart';
import 'package:sabiwork/models/userModel.dart';
import 'package:sabiwork/screens/chat/chat-room.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/messages_service.dart';

class ChatList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatListState();
  }
}

class ChatListState extends State<ChatList> {
  MessageService messageService = MessageService();
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Obx(() => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Chats',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff555555),
                    fontSize: 18)),
            GestureDetector(child: Icon(Icons.more_vert))
          ]),
          c.recentChats.value.result!.data == null
              ? Center(child: Text('You have not started any conversation yet'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 34,
                      ),
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Color(0xffAEAEAE)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Color(0xffAEAEAE)),
                                  ),
                                  prefixIcon: Icon(Icons.search),
                                  labelText: 'Search'))),
                      SizedBox(height: 37),
                      RefreshIndicator(
                          onRefresh: () => messageService.fetchRecentChats(),
                          child: ListView.separated(
                            shrinkWrap: true,
                            // reverse: true,
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 5,
                              );
                            },
                            itemCount: c.recentChats.value.result!.data!.length,
                            itemBuilder: ((BuildContext context, index) {
                              Data chat =
                                  c.recentChats.value.result!.data![index];
                              UserModel recipient =
                                  chat.senderData![0].id == c.userData.value.id
                                      ? chat.recipientData![0]
                                      : chat.senderData![0];
                              return recipient.id == c.userData.value.id
                                  ? SizedBox.shrink()
                                  : ListTile(
                                      contentPadding: EdgeInsets.only(left: 0),
                                      dense: true,
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatRoom(user: recipient),
                                          )),
                                      leading: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: UsersProfileImageSAvatarx2(
                                              user: recipient)),
                                      title: Text(
                                          '${recipient.firstName} ${recipient.lastName}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF555555),
                                          )),
                                      subtitle: Text(
                                        '${chat.docs!.message}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff888888),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      trailing: Text(
                                          '${Jiffy(chat.docs!.createdAt).fromNow()}'));
                            }),
                          ))
                    ],
                  ),
                )
        ])));
  }
}
