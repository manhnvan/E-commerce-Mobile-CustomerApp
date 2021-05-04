import 'package:flutter/material.dart';
import 'package:seller_app/screens/AddProductScreen/AddProductScreen.dart';
import 'package:seller_app/screens/ChatScreen/ChatScreen.dart';
import 'package:seller_app/screens/ChatScreen/Chatbox.dart';
import 'package:seller_app/screens/OrderScreen/OrderScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: OrderScreen.routeName,
      routes: {
        OrderScreen.routeName: (context) => OrderScreen(),
        AddProductScreen.routeName: (context) => AddProductScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
        ChatBox.routeName: (context) => ChatBox()
      },
    );
  }
}





