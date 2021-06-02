import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';

class LeftMessage extends StatelessWidget {
  const LeftMessage({Key key, this.message}) : super(key: key);

  final dynamic message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ChatBubble(
          clipper: ChatBubbleClipper6(
              type: BubbleType.receiverBubble, radius: border_radius_big),
          backGroundColor: color_white,
          elevation: 10,
          margin: EdgeInsets.symmetric(vertical: space_small),
          child: Container(
            padding: EdgeInsets.all(space_tiny),
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
    );
  }
}
