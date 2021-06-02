import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
import 'package:seller_app/components/BottomNavBarVer2.dart';
import 'package:seller_app/screens/AccountScreen/components/OrderInfoCard.dart';
import 'package:seller_app/screens/AccountScreen/components/PersonalInfoCard.dart';
import 'package:seller_app/screens/LoginScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constaint.dart';

class AccountScreen extends StatefulWidget {
  static final routeName = '/account';

  AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String username = '', phoneNumber = '', address = '';

  var dio = new Dio();
  SharedPreferences prefs;
  String waitingItem = '',
      processingItem = '',
      shippingItem = '',
      closeItem = '',
      deniedItem = '';

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      final sellerId = prefs.getString('sellerId');
      dio.get('$api_url/seller/$sellerId').then((value) {
        if (value.data['success']) {
          dynamic doc = value.data['doc'];
          setState(() {
            username = doc['username'];
            phoneNumber = doc['phone'];
            address = doc['address'];
            waitingItem = doc['waitingItem'].toString();
            processingItem = doc['processingItem'].toString();
            shippingItem = doc['shippingItem'].toString();
            closeItem = doc['closeItem'].toString();
            deniedItem = doc['deniedItem'].toString();
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text("Thông tin người bán",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: color_white)),
          gradient: color_gradient_primary,
          automaticallyImplyLeading: false),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(space_medium, space_huge,
                  space_medium, space_huge + nav_height),
              child: Column(
                children: [
                  //Order info here =.=
                  Column(children: [
                    Text('Thông tin đơn hàng',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: space_big),
                    OrderInfoCard(
                        Icons.refresh_rounded, 'Đơn hàng chờ', waitingItem),
                    OrderInfoCard(
                        Icons.all_inbox_rounded, 'Đang xử lý', processingItem),
                    OrderInfoCard(Icons.local_shipping_rounded,
                        'Đang vận chuyển', shippingItem),
                    OrderInfoCard(
                        Icons.receipt_long_rounded, 'Đã chuyển ', closeItem),
                    OrderInfoCard(Icons.block_rounded, 'Từ chối', deniedItem)
                  ]),

                  SizedBox(height: space_huge),

                  //Personal info here :<
                  Column(children: [
                    Text('Thông tin cá nhân',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: space_big),
                    PersonalInfoCard(Icons.account_circle_rounded,
                        'Tên đăng nhập', username),
                    PersonalInfoCard(
                        Icons.phone_rounded, 'Số điện thoại', phoneNumber),
                    PersonalInfoCard(Icons.home_rounded, 'Địa chỉ', address),
                    SizedBox(height: space_huge)
                  ]),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: space_small),
                            child: Text(
                              "Đăng xuất",
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: color_secondary
                              )),
                            ),
                        Icon(Icons.logout, size: icon_size, color: color_secondary)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(left: 0, bottom: 0, child: BottomNavBarVer2(4, null))
        ]),
      ),
      // bottomNavigationBar: BottomNavBar(4),
    );
  }
}
