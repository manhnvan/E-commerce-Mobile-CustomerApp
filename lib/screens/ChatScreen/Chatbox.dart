import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/screens/ChatScreen/Message/LeftMessage.dart';
import 'package:seller_app/screens/ChatScreen/Message/RightMessage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constaint.dart';


class ScreenArguments {
  final String topic;
  final String chatboxId;
  ScreenArguments(this.topic, this.chatboxId);
}

class ChatBox extends StatefulWidget {
  static final routeName = '/chatbox';
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {

  IO.Socket socket;
  List<dynamic> messages = <dynamic>[];
  final _messageController = TextEditingController();
  var dio = Dio();
  final _scrollController = ScrollController();
  String topic;
  String chatboxId;

  String currentUserId = "608eb567489da0f52b6ec179";
  
  @override
  void initState() {
    try {
      super.initState();
      final widgetsBinding = WidgetsBinding.instance;
        widgetsBinding.addPostFrameCallback((callback) {
        if (ModalRoute.of(context).settings.arguments != null) {
          final ScreenArguments args = ModalRoute.of(context).settings.arguments;
          setState(() {
            topic = args.topic;
            chatboxId = args.chatboxId;
          });
          dio.get('http://${ip}:${chat_port}/message/${chatboxId}/0').then((value) {
            if (value.data['success']) {
              setState(() {
                messages.addAll(value.data['messages']);
              });
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          });
          socket = IO.io('http://172.28.16.1:3002', <String, dynamic> {
            'transports': ['websocket'],
            'autoConnect': false,
          });
          socket.onConnect((data) {
            print('connect: ${socket.id}');
              socket.on('message', (message) {
              setState(() {
                messages.add(message);
              });
              print(messages.length);
            });
          });

          socket.connect();
          socket.emit('join', chatboxId);
          
          socket.on('disconnect', (_) => print('disconnect'));
          print(socket.connected);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        title: Text(topic != null ? topic : ''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                if (message['from'] == currentUserId) {
                  return RightMessage(message: message);
                } else {
                  return LeftMessage(message: message);
                } 
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 70,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image), 
                  color: Color.fromRGBO(22, 160, 133, 0.7),
                  onPressed: () {}
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration.collapsed(
                      hintText: "Send a message ..."
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send), 
                  color: Color.fromRGBO(22, 160, 133, 0.7),
                  onPressed: () {
                    socket.emit(
                      'sendMessage', 
                      {
                        'chatbox': chatboxId,
                        'sender': 'Mạnh Nguyễn',
                        'from': currentUserId,
                        'content': _messageController.text,
                        'images': []
                      }
                    );
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    _messageController.clear();
                  }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



