import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:seller_app/screens/ChatScreen/Chatbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constaint.dart';

class ChatScreen extends StatefulWidget {
  static final routeName = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List<dynamic> chatboxes = <dynamic>[];
  var dio = Dio();
  SharedPreferences prefs;
  String currentUserId;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      currentUserId = prefs.getString('sellerId');
      dio.get('$chat_url/${currentUserId}/').then((value) {
        if (value.data['success']) {
          print(value.data);
          setState(() {
            chatboxes.addAll(value.data['chatboxes']);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: CupertinoScrollbar(
          isAlwaysShown: true,
          child: ListView.builder(
            itemCount: chatboxes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ChatBox.routeName,
                    arguments: ScreenArguments(
                      chatboxes[index]['topic'],
                      chatboxes[index]['_id'],
                    ),
                  );
                },
                child: ChatCard(chatCardInfo: chatboxes[index]),
              );
            }
          ),
      ),
      bottomNavigationBar: BottomNavBar(3),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key key,
    this.chatCardInfo
  }) : super(key: key);

  final dynamic chatCardInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color.fromRGBO(22, 160, 133,1.0)
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5
                    )
                  ]
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage('https://mcdn.coolmate.me/uploads/March2021/DAI041214_60_550x623.jpg')
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            chatCardInfo['topic'], 
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            chatCardInfo['lastMessage'] != null ? DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(chatCardInfo['lastMessage']['created'])) : '',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ]
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        chatCardInfo['lastMessage']['content'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis
                      ),
                    )
                  ]
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}