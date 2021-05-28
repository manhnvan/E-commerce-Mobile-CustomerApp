import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/screens/AccountScreen/AccountScreen.dart';
import 'package:seller_app/screens/AddProductScreen/AddProductScreen.dart';
import 'package:seller_app/screens/ChatScreen/ChatScreen.dart';
import 'package:seller_app/screens/HomeScreen/HomeScreen.dart';
import 'package:seller_app/screens/OrderScreen/OrderScreen.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  BottomNavBar(this.currentIndex);

  int currentIndex;

  final listWidget = [
    HomeScreen.routeName,
    OrderScreen.routeName,
    AddProductScreen.routeName,
    ChatScreen.routeName,
    AccountScreen.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [box_shadow_black]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(border_radius_big),
          topRight: Radius.circular(border_radius_big)
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            Navigator.pushNamed(context, listWidget[index]);
          },
          currentIndex: currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded,
                    size: icon_size, color: color_green_dark),
                activeIcon: Icon(Icons.home_rounded,
                    size: icon_size, color: color_secondary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded,
                    size: icon_size, color: color_green_dark),
                activeIcon: Icon(Icons.list_alt_rounded,
                    size: icon_size, color: color_secondary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_rounded,
                    size: icon_size, color: color_green_dark),
                activeIcon: Icon(Icons.add_circle_rounded,
                    size: icon_size, color: color_secondary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded,
                    size: icon_size, color: color_green_dark),
                activeIcon: Icon(Icons.message_rounded,
                    size: icon_size, color: color_secondary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded,
                    size: icon_size, color: color_green_dark),
                activeIcon: Icon(Icons.account_circle_rounded,
                    size: icon_size, color: color_secondary),
                label: ''),
          ],
        ),
      ),
    );
  }
}
