import 'package:flutter/material.dart';

class LeftMessage extends StatelessWidget {
  const LeftMessage({
    Key key,
    this.message
  }) : super(key: key);

  final dynamic message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              radius: MediaQuery.of(context).size.width * 0.05,
              backgroundImage: NetworkImage('https://mcdn.coolmate.me/uploads/March2021/DAI041214_60_550x623.jpg')
            )
          ),
          Container(
            child: Container(
              alignment: Alignment.topLeft,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5
                  )
                ]
              ),
              child: Text(
                message['content'],
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      )
    );
  }
}