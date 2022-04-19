import 'package:flutter/material.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/screens/chat/chat-room.dart';

class ChatList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatListState();
  }
}

class ChatListState extends State<ChatList> {
  Widget build(BuildContext context) {
    return Container(
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
          SingleChildScrollView(
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
                Divider(
                  height: 5,
                ),
                ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    dense: true,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatRoom('2', 'General', '3433r3r3'),
                        )),
                    leading:
                        SizedBox(width: 40, height: 40, child: ProfileImage()),
                    title: Text('Chinedu Uche',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF555555),
                        )),
                    subtitle: Text(
                      'Okay, I will',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff888888),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text('5:30pm')),
                Divider(
                  height: 5,
                ),
                ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    dense: true,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatRoom('2', 'General', '3433r3r3'),
                        )),
                    leading:
                        SizedBox(width: 40, height: 40, child: ProfileImage()),
                    title: Text('Daniel Oyeniyi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF555555),
                        )),
                    subtitle: Text(
                      'Thanks for the patronage',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff888888),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text('4:00pm')),
                Divider(
                  height: 5,
                ),
                ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    dense: true,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatRoom('2', 'General', '3433r3r3'),
                        )),
                    leading:
                        SizedBox(width: 40, height: 40, child: ProfileImage()),
                    title: Text('Felix John',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF555555),
                        )),
                    subtitle: Text(
                      'I will think about it',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff888888),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text('3:30pm'))
              ],
            ),
          )
        ]));
  }
}
