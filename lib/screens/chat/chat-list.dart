import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/shimmerList.dart';
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
  final _scrollController = ScrollController();

  initState() {
    getRecentChats();
    super.initState();
  }

  getRecentChats() async {
    await messageService.fetchRecentChats();
  }

  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return RefreshIndicator(
        onRefresh: () async {
          print('refreshing');
          await messageService.fetchRecentChats();
        },
        child: Obx(() => Container(
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
              c.isFetchingMessage.value &&
                      c.recentChats.value.result!.data == null
                  ? ShimmerList()
                  : c.recentChats.value.result!.data == null
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2),
                                Lottie.asset('assets/images/no-message.json',
                                    fit: BoxFit.fill, width: 150, height: 150),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                        'You have not started any conversation yet',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff333333),
                                            fontSize: 17))),
                                SizedBox(height: 10),
                              ]),
                        )
                      : c.recentChats.value.result!.data!.length == 0
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2),
                                    Lottie.asset(
                                        'assets/images/no-message.json',
                                        fit: BoxFit.fill,
                                        width: 150,
                                        height: 150),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Text(
                                            'You have not started any conversation yet',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff333333),
                                                fontSize: 17))),
                                    SizedBox(height: 10),
                                  ]),
                            )
                          : SingleChildScrollView(
                              controller: _scrollController,
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
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: Color(0xffAEAEAE)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: Color(0xffAEAEAE)),
                                              ),
                                              prefixIcon: Icon(Icons.search),
                                              labelText: 'Search'))),
                                  SizedBox(height: 37),
                                  RefreshIndicator(
                                      onRefresh: () =>
                                          messageService.fetchRecentChats(),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        // reverse: true,
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            height: 5,
                                          );
                                        },
                                        itemCount: c.recentChats.value.result!
                                            .data!.length,
                                        itemBuilder:
                                            ((BuildContext context, index) {
                                          Data chat = c.recentChats.value
                                              .result!.data![index];

                                          return ListTile(
                                              contentPadding:
                                                  EdgeInsets.only(left: 0),
                                              dense: true,
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatRoom(
                                                            user: chat.recipient
                                                                as UserModel),
                                                  )),
                                              leading: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child:
                                                      UsersProfileImageSAvatarx2(
                                                          user:
                                                              chat.recipient)),
                                              title: Text(
                                                  '${chat.recipient!.firstName} ${chat.recipient!.lastName}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF555555),
                                                  )),
                                              subtitle: Text(
                                                '${chat.lastMessage!.message}',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: chat.lastMessage!
                                                              .senderId ==
                                                          c.userData.value.id
                                                      ? Color(0xff888888)
                                                      : Color.fromARGB(
                                                          255, 127, 72, 21),
                                                  fontWeight: chat.lastMessage!
                                                              .senderId ==
                                                          c.userData.value.id
                                                      ? FontWeight.w600
                                                      : FontWeight.w700,
                                                ),
                                              ),
                                              trailing: Text(
                                                  '${Jiffy(chat.lastMessage!.createdAt).fromNow()}'));
                                        }),
                                      ))
                                ],
                              ),
                            )
            ]))));
  }
}
