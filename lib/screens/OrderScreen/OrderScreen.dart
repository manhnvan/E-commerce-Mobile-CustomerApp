import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:seller_app/components/BottomNavBarVer2.dart';

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
        appBar: NewGradientAppBar(
          title: Text("Đơn hàng",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: color_white)),
          gradient: color_gradient_primary,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: color_secondary,
            labelColor: color_green_dark,
            labelStyle:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
            unselectedLabelColor: color_black_opacity_strong,
            isScrollable: true,
            tabs: [
              Tab(
                text: "Chờ tiếp nhận",
              ),
              Tab(text: "Đã tiếp nhận"),
              Tab(text: "Đang vận chuyển"),
              Tab(text: "Hoàn thành"),
              Tab(text: "Đã từ chối")
            ],
          ),
        ),
        body: Container(
          color: color_grey,
          child: Stack(children: [
            TabBarOrder(),
            Positioned(left: 0, bottom: 0,child: BottomNavBarVer2(1, null))
          ]),
        ),
        // bottomNavigationBar: BottomNavBar(1),
      ),
    );
  }
}
