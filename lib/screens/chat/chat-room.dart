import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/helpers/customColors.dart';

class ChatRoom extends StatefulWidget {
  // final MainAppProvider provider;
  final dynamic groupId;
  final String groupLabel;
  final dynamic storeId;
  ChatRoom(this.groupId, this.groupLabel, this.storeId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatRoomState();
  }
}

class ChatRoomState extends State<ChatRoom> {
  bool showEmojiKeyboard = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _chatController = TextEditingController();
  ScrollController _chatScrollController = ScrollController();
  var previousCursorPosition;

  List<Map<String, dynamic>> messages = [
    {"message": "Hello there", "issender": true},
    {"message": "Hi there", "issender": false},
    {
      "message":
          "I need someone to help me move some of my properties from Onipanu to Jibowu. Can you do that? ",
      "issender": true
    },
    {
      "message":
          "Yes I can do that, how many people will be working with me or is it just me?",
      "issender": false
    },
    {
      "message": "I need 2 more people to join you, is that okay?",
      "issender": true
    },
    {
      "message": "Yes, that is fine by me but when do you want to relocate?",
      "issender": false
    },
    {
      "message":
          "Planning this sunday after church, is that fine by you too or ypu haev any plans for Sunday?",
      "issender": true
    },
    {
      "message":
          "Not at all, Sunday is fine by me but I would prefer we start by 11:30am so we can finish before dark.",
      "issender": false
    },
  ];

  // initState() {
  //   print('length ${widget.provider.groupChatMessageList.length}');
  //   super.initState();
  // }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  next() {
    sendMessage();
  }

  sendMessage() {
    // if (_chatController.text == '') {
    //   return;
    // }

    // // print('position ${_chatController.selection.start}');
    // // print('length ${_chatController.text.length}');
    // // print('character length ${_chatController.text.characters.length}');

    // // append emoji based on the current cursor position

    // widget.provider
    //     .sendGroupMessage(
    //   message: _chatController.text,
    //   groupChatId: widget.groupId,
    // )
    //     .then((success) {
    //   if (success['success']) {
    //     _chatController.text = '';
    //   } else {}
    // });
  }

  // buildHelpButton() {
  //   return MaterialButton(
  //     onPressed: () {
  //       //  Navigator.pushReplacementNamed(context, '/dashboard');
  //       // Navigator.pushReplacementNamed(context, '/listing');
  //     },
  //     child: Text(
  //       'Live chat',
  //       style: TextStyle(
  //           fontSize: 15,
  //           fontFamily: 'SFUIDisplay',
  //           fontWeight: FontWeight.bold,
  //           letterSpacing: 1.5,
  //           color: Colors.white),
  //     ),
  //     // color: Color(0xff3700b3),
  //     color: Color(0xff1763DD),
  //     elevation: 0,
  //     minWidth: MediaQuery.of(context).size.width * 0.5,
  //     height: 45,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //   );
  // }

  Widget searchField() {
    return Form(
        // key: _formKey,
        child: TextFormField(
      showCursor: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'search topic...',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelStyle: TextStyle(
            fontSize: 13,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )),
      onSaved: (String? value) {
        // _formData['uid'] = value;
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter topic';
        }
      },
    ));
  }

  Widget buildtextFormField() {
    return Form(
        // key: _formKey,
        child: Container(
            // height: MediaQuery.of(context).size.height * 0.08,
            // height: 50,
            child: Row(children: <Widget>[
      Expanded(
          child: Container(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
              child: TextFormField(
                onTap: () {
                  // either show emoji or keypad based on state
                  // hide keyboard
                  if (!showEmojiKeyboard) {
                    _focusNode.requestFocus();
                    setState(() {
                      showEmojiKeyboard = false;
                    });
                  } else {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    setState(() {
                      showEmojiKeyboard = true;
                    });
                  }
                },
                maxLines: 5,
                minLines: 1,
                // expands: true,
                cursorColor: Colors.black45,
                focusNode: _focusNode,
                controller: _chatController,
                style: TextStyle(color: Colors.black87, fontSize: 17),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(
                      fontFamily: 'Charlie',
                      fontSize: 16,
                      height: 1.4,
                      letterSpacing: 0.3,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    )),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Type your message';
                  }
                },
                onSaved: (String? value) {
                  // _formData['message'] = value;
                },
              )))
    ])));
  }

  Widget buildEMojiPicker() {
    return Container(child: EmojiPicker(
      onEmojiSelected: (emoji, category) {
        // print('emoji length ${emoji.emoji.length}');

        if (_chatController.selection.start == -1) {
          _chatController.text = _chatController.text + emoji.name;
        } else {
          // save curso position before String manipulation i.e cursor position + emoji length
          previousCursorPosition =
              _chatController.selection.start + emoji.name.length;
          _chatController.text = StringUtils.addCharAtPosition(
              _chatController.text,
              emoji.name,
              _chatController.selection.start);
          // set cursor position
          _chatController.selection = TextSelection(
              baseOffset: previousCursorPosition,
              extentOffset: previousCursorPosition);
        }

        // set cursor to current position
        // _chatController.selection = TextSelection(
        //     baseOffset: _chatController.selection.start,
        //     extentOffset: _chatController.selection.start);
        // _chatController.selection = new TextSelection.fromPosition(
        //     new TextPosition(offset: previousCursorPosition));
        // _chatController.text = _chatController.text + emoji.emoji;
        print(emoji);
      },
      // config: Config(
      // // rows: 4,
      // columns: 7,
      // // recommendKeywords: ["racing", "horse"],
      // // numRecommended: 10,
      //     ).
    ));
  }

  Widget buildChatForm() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: const BorderRadius.only(
          //   bottomRight: Radius.circular(13.0),
          //   bottomLeft: Radius.circular(13.0),
          //   topLeft: Radius.circular(13.0),
          //   topRight: Radius.circular(13.0),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: buildtextFormField(),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Row(
                  children: [
                    // buildEMojiPicker(),
                    IconButton(
                      icon: Icon(Icons.send, color: CustomColors.ButtonColor),
                      onPressed: () {
                        next();
                        // sendMessage(model.sendMessage);
                        // Navigator.pushNamed<bool>(
                        //   context, '/login'
                        // );
                      },
                    ),
                    GestureDetector(
                      child: Text('😀', style: TextStyle(fontSize: 17)),
                      onTap: () {
                        // hide keyboard
                        if (showEmojiKeyboard) {
                          _focusNode.requestFocus();
                          setState(() {
                            showEmojiKeyboard = false;
                          });
                        } else {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() {
                            showEmojiKeyboard = true;
                            // _chatController.selection.start;
                          });
                        }
                      },
                    )
                  ],
                ))
          ],
        ));
  }

  Widget buildMessageBody() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.68 +
            MediaQuery.of(context).viewInsets.bottom,
        margin: EdgeInsets.only(top: 20, bottom: 7),
        padding: EdgeInsets.only(bottom: 60),
        child: ListView.builder(
          controller: _chatScrollController,
          // reverse: true,
          shrinkWrap: true,
          // itemCount: 4,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            print('message $message');
            // print('projects $project');
            // if (project.id != 1) {
            return Container(
              padding: EdgeInsets.only(bottom: 10),
              child: message['issender'] == true
                  ? Container(
                      padding: EdgeInsets.only(bottom: 0, right: 15),
                      child: Align(
                          alignment: Alignment(0.9, -0.9),
                          child: buildSenderConversationBody(
                              message['message'], '05:30')))
                  : Container(
                      padding: EdgeInsets.only(bottom: 0, left: 15),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: buildReceiverConversationBody(
                              message['message'], "Ayodele", "6:30"))),
            );
            // } else {
            //   return Container(
            //     padding: EdgeInsets.only(bottom: 40),
            //     child: Align(
            //       alignment: Alignment.topLeft,
            //       child: buildReceiverConversationBody('${project.body}')
            //     )
            //   );
            // }
            // return MemberItem(project, index, model);
          },
        ));
  }

  Widget buildSenderConversationBody(message, time) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                        bottomLeft: const Radius.circular(25.0)),
                  ),
                  borderOnForeground: true,
                  elevation: 0.5,
                  // margin: EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                            bottomLeft: const Radius.circular(25.0)),
                        // gradient: LinearGradient(
                        //     begin: Alignment.centerLeft,
                        //     end: Alignment.centerRight,
                        //     colors: [
                        //       Color(0xff1763DD),
                        //       Color(0xff4575f0),
                        //     ])
                        color: Color(0xff983701).withOpacity(0.2),
                      ),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF555555),
                                fontWeight: FontWeight.w600,
                              )),
                          // SizedBox(height: 5),
                          // Text('Today 12:38 PM',
                          //     style: TextStyle(
                          //       fontSize: 10,
                          //       color: Colors.white,
                          //       fontFamily: 'Charlie',
                          //       fontWeight: FontWeight.w600,
                          //     ))
                        ],
                      ))),
              Container(
                  padding: EdgeInsets.only(right: 22, top: 5),
                  child: Text('$time',
                      style: TextStyle(fontSize: 12, color: Colors.black87)))
            ]));
  }

  Widget buildReceiverConversationBody(message, sender, time) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                  color: Color(0xFFE5E5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                        bottomRight: const Radius.circular(25.0)),
                  ),
                  borderOnForeground: true,
                  elevation: 0.5,
                  // margin: EdgeInsets.all(10.0),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('$sender',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87)),
                          SizedBox(height: 5),
                          Text('$message',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff888888),
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ))),
              Container(
                  padding: EdgeInsets.only(left: 22, top: 5),
                  child: Text('$time',
                      style: TextStyle(fontSize: 12, color: Colors.black87)))
            ]));
  }

  Widget buildMessageBody1() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.68,
      child: ListView(
        children: <Widget>[
          // Container(
          //     padding: EdgeInsets.only(bottom: 15, left: 15),
          //     child: Align(
          //         alignment: Alignment.topLeft,
          //         child: buildReceiverConversationBody(
          //             'Hello! 👋 Is there anything I can do to help you with your discount codes?'))),

          Container(
              padding: EdgeInsets.only(bottom: 15, right: 15),
              child: Align(
                  alignment: Alignment(0.9, -0.9),
                  child: buildSenderConversationBody(
                      "I need a really good dress for the winter formal. What do you think about the new dress i just posted? I think its fire! 🔥",
                      '12:20 PM'))),
          Container(
              padding: EdgeInsets.only(bottom: 15, left: 15),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: buildReceiverConversationBody(
                      "Love the dress! 👗", 'Olivia', '12:30 PM'))),

          Container(
              padding: EdgeInsets.only(bottom: 15, left: 15),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: buildReceiverConversationBody(
                      "That dress will look great on you! 😍",
                      'Amelia',
                      '12:35 PM'))),
          Container(
              padding: EdgeInsets.only(bottom: 15, right: 15),
              child: Align(
                  alignment: Alignment(0.9, -0.9),
                  child: buildSenderConversationBody(
                      "Oh okay! I'll check it out and let you know what i think about it",
                      '12:55 PM'))),

          // Container(
          // padding: EdgeInsets.only(bottom: 40),
          // child: Align(
          //   alignment: Alignment(-0.9, -0.9),
          //   child: Text('hello', style: KontactTheme.headline),
          // )
          // ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    // Locale myLocale = Localizations.localeOf(context);
    // print(myLocale.languageCode);
    return WillPopScope(
        onWillPop: () async {
          if (showEmojiKeyboard) {
            _focusNode.requestFocus();
            setState(() {
              showEmojiKeyboard = !showEmojiKeyboard;
            });
            return false;
            // return;
          } else {
            Navigator.pop(context);
            return false;
          }
        },
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(65),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                    child: AppBar(
                      backgroundColor: CustomColors.PrimaryColor,
                      elevation: 0,
                      leading: GestureDetector(
                          child: Icon(Icons.arrow_back_ios, size: 18)),
                      title: Container(
                          child: Row(
                        children: [
                          SizedBox(
                              width: 30, height: 30, child: ProfileImage()),
                          SizedBox(width: 10),
                          Text('Chinedu Uche',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))
                        ],
                      )),
                      actions: [
                        GestureDetector(child: Icon(Icons.call, size: 20)),
                        SizedBox(width: 16),
                      ],
                    ))),
            body: Stack(
              children: [
                Container(
                    color: Color(0xFF),
                    child: Column(
                      children: [
                        // SizedBox(height: 50),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFededed),
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(20.0),
                                  topRight: const Radius.circular(20.0))),
                          child:
                              // widget.provider.fetchingGroupMessages
                              //     ? Container(
                              //         height: MediaQuery.of(context).size.height * 0.68,
                              //         child: Center(
                              //             child: SpinKitFadingFour(
                              //           color: Color(0xFF1A1A1A),
                              //           size: 50.0,
                              //         )))
                              //     :
                              buildMessageBody(),
                        ))
                      ],
                    )
                    // buildBody()
                    ),
                Positioned(
                    // alignment: Alignment.bottomCenter,
                    bottom: 0,
                    child: Container(
                        child: Column(
                      children: [
                        //
                        buildChatForm(),
                        // show emoji keyboard if keyboard is set to true
                        showEmojiKeyboard ? buildEMojiPicker() : Container()
                      ],
                    )))
              ],
            )));
  }
}
