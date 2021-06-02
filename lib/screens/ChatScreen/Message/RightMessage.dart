import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

class RightMessage extends StatelessWidget {
  const RightMessage({Key key, this.message}) : super(key: key);

  final dynamic message;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ChatBubble(
          clipper: ChatBubbleClipper6(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          elevation: 10,
          margin: EdgeInsets.symmetric(vertical: space_small),
          backGroundColor: color_primary,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message['content'],
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
            ),
          ),
        )
      ],
    ));
  }
}
