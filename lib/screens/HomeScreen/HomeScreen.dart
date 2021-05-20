import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:seller_app/constaint.dart';
import 'package:seller_app/screens/HomeScreen/components/ProductCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentUserId;
  SharedPreferences prefs;
  var dio = new Dio();
  List<dynamic> products = [];
  int page = 0;
  int limit = 10;

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      currentUserId = prefs.getString('sellerId');
      dio.get('$api_url/product?page=$page&limit=$limit&sellerId=$currentUserId').then((value) {
        if (value.data['success']) {
          setState(() {
            products = value.data['docs'];
          });
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(value.data['msg']),
            )
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gian hàng", textAlign: TextAlign.center,),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              dynamic item = products[index];
              return ProductCard(
                productId: item['_id'],
                productName: item['productName'],
                image: item['thumbnail'],
                price: item['price'],
                vendor: item['vendor'],
                rate: item['rating'].toDouble(),
                like: item['like']
              );
            },
          ),
        ),
        bottomNavigationBar:BottomNavBar(0)
    );
  }
}
