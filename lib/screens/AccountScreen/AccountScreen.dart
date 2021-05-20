import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:seller_app/screens/LoginScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constaint.dart';


class AccountScreen extends StatefulWidget {
  static final routeName = '/account';
  AccountScreen({
    Key key
  }) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String username = '', phoneNumber = '', address = '';

  var dio = new Dio();
  SharedPreferences prefs;
  String waitingItem = '', processingItem = '', shippingItem = '', closeItem = '', deniedItem = '';

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
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.black12,
          margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      children:[
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Tên đăng nhập", style: TextStyle(fontSize: 17.0),)
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text(username, style: TextStyle(fontSize: 17.0),)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Số điện thoại", style: TextStyle(fontSize: 17.0),)
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text(phoneNumber, style: TextStyle(fontSize: 17.0),)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Địa chỉ", style: TextStyle(fontSize: 17.0),)
                              ),
                              Flexible(
                                child: Column(
                                    children:[
                                      Container(
                                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                          height: 50.0,
                                          child: Text(address, style: TextStyle(fontSize: 17.0), overflow: TextOverflow.ellipsis,)
                                      ),
                                    ]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      children:[
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Đơn hàng chờ", style: TextStyle(fontSize: 17.0),)
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text(waitingItem, style: TextStyle(fontSize: 17.0),)
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Đang xử lý", style: TextStyle(fontSize: 17.0),)
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text(processingItem, style: TextStyle(fontSize: 17.0),)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Đang vận chuyển", style: TextStyle(fontSize: 17.0),)
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text(shippingItem, style: TextStyle(fontSize: 17.0),)
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Đã nhận", style: TextStyle(fontSize: 17.0),)
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text(closeItem, style: TextStyle(fontSize: 17.0),)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(accout_card_info_margin),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(account_card_border_radius),
                            color: Colors.lightBlueAccent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Từ chối", style: TextStyle(fontSize: 17.0),)
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text(deniedItem, style: TextStyle(fontSize: 17.0),)
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              ),
              Container(
                  margin: EdgeInsets.all(accout_card_info_margin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(account_card_border_radius),
                    color: Colors.lightBlueAccent
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (Route<dynamic> route) => false,);
                    },
                    child: Column(
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Đăng xuất", style: TextStyle(fontSize: 17.0, color: Colors.black),)
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                              )
                            ],
                          ),
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(4),
    );
  }
}


