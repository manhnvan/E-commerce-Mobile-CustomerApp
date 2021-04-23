import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';

import 'TabBarOrder.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng"),
        bottom: TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: "Chờ tiếp nhận"),
            Tab(text: "Đã tiếp nhận"),
            Tab(text: "Đang vận chuyển"),
            Tab(text: "Hoàn thành")
          ],
        ),
      ),
      body: TabBarOrder(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}