import 'package:flutter/material.dart';
import 'package:seller_app/screens/AddProductScreen/AddProductScreen.dart';
import 'package:seller_app/screens/ChatScreen/ChatScreen.dart';
import 'package:seller_app/screens/OrderScreen/OrderScreen.dart';

class BottomNavBar extends StatelessWidget {
  
  BottomNavBar(this.currentIndex);

  int currentIndex;

  final listWidget = [
    OrderScreen.routeName,
    OrderScreen.routeName,
    AddProductScreen.routeName,
    ChatScreen.routeName,
    AddProductScreen.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        Navigator.pushNamed(context, listWidget[index]);
      },
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Order"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: "Add"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "Message"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Account"
        ),
      ],
    );
  }
}