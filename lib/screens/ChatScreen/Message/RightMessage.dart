import 'package:flutter/material.dart';

class RightMessage extends StatelessWidget {
  const RightMessage({
    Key key,
    this.message
  }) : super(key: key);

  final dynamic message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(22, 160, 133, 0.7),
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
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
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
          )
        ],
      )
    );
  }
}