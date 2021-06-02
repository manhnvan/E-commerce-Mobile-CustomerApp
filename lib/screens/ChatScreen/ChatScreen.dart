import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:seller_app/components/BottomNavBarVer2.dart';
import 'package:seller_app/screens/ChatScreen/Chatbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constaint.dart';
import 'components/ChatCard.dart';

class ChatScreen extends StatefulWidget {
  static final routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> chatBoxes = <dynamic>[];
  var dio = Dio();
  SharedPreferences prefs;
  String currentUserId;

  @override
  // ignore: must_call_super
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      currentUserId = prefs.getString('sellerId');
      dio.get('$chat_url/$currentUserId/').then((value) {
        if (value.data['success']) {
          print(value.data);
          setState(() {
            chatBoxes.addAll(value.data['chatboxes']);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text("Hỗ trợ khách hàng",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: color_white)),
          gradient: color_gradient_primary,
          automaticallyImplyLeading: false),
      body: Container(
        color: color_grey,
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(top: space_medium, bottom: nav_height),
                itemCount: chatBoxes.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatBox(
                                  topic: chatBoxes[index]['topic'],
                                  chatboxId: chatBoxes[index]['_id'])));
                    },
                    child: ChatCard(chatBoxes[index]),
                  );
                }),

            Positioned(left: 0, bottom: 0, child: BottomNavBarVer2(3, null))
          ]
        ),
      ),
      // bottomNavigationBar: BottomNavBar(3),
    );
  }
}
