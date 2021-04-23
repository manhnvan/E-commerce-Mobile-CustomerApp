import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
    this.currentIndex,
  }) : super(key: key);

  final currentIndex;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
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
