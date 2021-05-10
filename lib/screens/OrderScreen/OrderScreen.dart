import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';

import 'TabBarOrder.dart';

class OrderScreen extends StatelessWidget {
  static final routeName = '/order';
  const OrderScreen({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Đơn hàng"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Chờ tiếp nhận",),
              Tab(text: "Đã tiếp nhận"),
              Tab(text: "Đang vận chuyển"),
              Tab(text: "Hoàn thành"),
              Tab(text: "Đã từ chối")
            ],
          ),
        ),
        body: TabBarOrder(),
        bottomNavigationBar: BottomNavBar(1),
      ),
    );
  }
}